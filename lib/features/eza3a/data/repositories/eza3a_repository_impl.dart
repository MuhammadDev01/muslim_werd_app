import 'dart:async';
import 'dart:io' show Socket;

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart' show debugPrint;
import 'package:just_audio/just_audio.dart';
import 'package:muslim_werd_app/features/eza3a/domain/models/eza3a_state.dart';
import 'package:muslim_werd_app/features/eza3a/domain/repositories/eza3a_repository.dart';

class Eza3aRepositoryImpl implements Eza3aRepository {
  Eza3aRepositoryImpl({AudioPlayer? player})
    : _player = player ?? AudioPlayer() {
    _init();
  }

  static const String failureMessage =
      'انقطع البث. قد تكون المشكلة في اتصالك بالإنترنت أو من تعطّل لدى '
      'السيرفر نفسه، حاول مرة أخرى بعد قليل.';

  static const Duration _stallTimeout = Duration(seconds: 10);

  final AudioPlayer _player;
  final StreamController<String> _statusController =
      StreamController<String>.broadcast();
  final StreamController<String?> _errorController =
      StreamController<String?>.broadcast();

  StreamSubscription<PlayerState>? _stateSub;
  StreamSubscription<PlayerException>? _errorSub;
  Timer? _stallTimer;
  bool _tornDown = false;

  @override
  Stream<String> get statusStream => _statusController.stream;

  @override
  Stream<String?> get errorStream => _errorController.stream;

  void _init() {
    _stateSub = _player.playerStateStream.listen(
      _onPlayerState,
      onError: (Object _) {
        unawaited(_failNow());
      },
    );

    _errorSub = _player.errorStream.listen((_) {
      if (_tornDown) return;
      unawaited(_failNow());
    });
  }

  void _onPlayerState(PlayerState playerState) {
    if (_tornDown) return;

    final String status;
    switch (playerState.processingState) {
      case ProcessingState.idle:
        status = Eza3aStatus.idle;
      case ProcessingState.loading:
      case ProcessingState.buffering:
        status = Eza3aStatus.buffering;
      case ProcessingState.ready:
        status = playerState.playing ? Eza3aStatus.playing : Eza3aStatus.paused;
      case ProcessingState.completed:
        status = Eza3aStatus.idle;
    }

    _cancelStallTimer();
    if (status == Eza3aStatus.buffering) {
      _armStallTimer();
    }

    _statusController.add(status);
  }

  void _armStallTimer() {
    _cancelStallTimer();
    _stallTimer = Timer(_stallTimeout, () {
      unawaited(_failNow());
    });
  }

  void _cancelStallTimer() {
    _stallTimer?.cancel();
    _stallTimer = null;
  }

  Future<void> _failNow() async {
    if (_tornDown) return;
    _cancelStallTimer();
    _tornDown = true;
    try {
      await _player.stop();
    } on Exception {
      debugPrint('Eza3a: stop during failure failed');
    }
    _statusController.add(Eza3aStatus.error);
    _errorController.add(failureMessage);
  }

  Future<bool> _hasInternet() async {
    try {
      final results = await Connectivity().checkConnectivity();
      if (results.every((r) => r == ConnectivityResult.none)) return false;
    } on Exception {
      // Fall through to socket check
    }

    final completer = Completer<bool>();
    final timer = Timer(const Duration(seconds: 6), () {
      if (!completer.isCompleted) completer.complete(false);
    });

    try {
      Socket.connect('8.8.8.8', 53).then(
        (socket) {
          socket.destroy();
          if (!completer.isCompleted) completer.complete(true);
        },
        onError: (Object _) {
          if (!completer.isCompleted) completer.complete(false);
        },
      );
      return await completer.future;
    } finally {
      timer.cancel();
    }
  }

  @override
  Future<void> play({required String streamUrl}) async {
    _tornDown = false;
    _cancelStallTimer();
    _statusController.add(Eza3aStatus.buffering);

    if (!await _hasInternet()) {
      await _failNow();
      return;
    }

    try {
      if (_player.processingState == ProcessingState.idle ||
          _player.processingState == ProcessingState.completed) {
        await _player.setUrl(streamUrl);
      }
      await _player.play();
    } on PlayerInterruptedException {
      debugPrint('Eza3a: playback interrupted by user action');
    } on Exception {
      debugPrint('Eza3a: play failed, stream stopped');
      unawaited(_failNow());
    } catch (_) {
      unawaited(_failNow());
    }
  }

  @override
  Future<void> pause() async {
    _cancelStallTimer();
    try {
      await _player.pause();
    } on PlayerInterruptedException {
      debugPrint('Eza3a: pause interrupted by user action');
    } on Exception {
      debugPrint('Eza3a: pause failed');
      unawaited(_failNow());
    }
  }

  @override
  Future<void> stop() async {
    _tornDown = false;
    _cancelStallTimer();
    try {
      await _player.stop();
    } on PlayerInterruptedException {
      debugPrint('Eza3a: stop interrupted by user action');
    } on Exception {
      debugPrint('Eza3a: stop failed');
      unawaited(_failNow());
    }
  }

  @override
  Future<void> setVolume(double volume) async {
    try {
      await _player.setVolume(volume);
    } on Exception {
      debugPrint('Eza3a: setVolume failed');
    }
  }

  @override
  Future<void> dispose() async {
    _cancelStallTimer();
    await _stateSub?.cancel();
    await _errorSub?.cancel();
    await _statusController.close();
    await _errorController.close();
    await _player.dispose();
  }
}
