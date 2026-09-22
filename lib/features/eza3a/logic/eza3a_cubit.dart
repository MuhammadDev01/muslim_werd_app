import 'dart:async';
import 'dart:io' show Socket;

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart' show debugPrint;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';

class Eza3aStatus {
  static const idle = 'idle';
  static const buffering = 'buffering';
  static const playing = 'playing';
  static const paused = 'paused';
  static const error = 'error';
}

class Eza3aState {
  const Eza3aState({
    this.status = Eza3aStatus.idle,
    this.volume = 0.8,
    this.isMuted = false,
    this.errorMessage,
  });

  final String status;
  final double volume;
  final bool isMuted;
  final String? errorMessage;

  bool get isPlaying => status == Eza3aStatus.playing;
  bool get isBuffering => status == Eza3aStatus.buffering;
  bool get isDown => status == Eza3aStatus.error;

  Eza3aState copyWith({
    String? status,
    double? volume,
    bool? isMuted,
    String? errorMessage,
    bool clearError = false,
  }) {
    return Eza3aState(
      status: status ?? this.status,
      volume: volume ?? this.volume,
      isMuted: isMuted ?? this.isMuted,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
    );
  }
}

class Eza3aCubit extends Cubit<Eza3aState> {
  Eza3aCubit({AudioPlayer? player, String? streamUrl})
    : _player = player ?? AudioPlayer(),
      streamUrl = streamUrl ?? defaultStreamUrl,
      super(const Eza3aState()) {
    _bindPlayer();
    unawaited(_setVolumeSilently(state.volume));
  }

  static const String defaultStreamUrl =
      'https://stream.radiojar.com/8s5u5tpdtwzuv';

  static const String failureMessage =
      'انقطع البث. قد تكون المشكلة في اتصالك بالإنترنت أو من تعطّل لدى '
      'السيرفر نفسه، حاول مرة أخرى بعد قليل.';

  static const Duration _stallTimeout = Duration(seconds: 10);

  final AudioPlayer _player;
  final String streamUrl;

  StreamSubscription<PlayerState>? _stateSub;
  StreamSubscription<PlayerException>? _errorSub;
  Timer? _stallTimer;
  double _lastVolumeBeforeMute = 0.8;
  bool _tornDown = false;

  void _bindPlayer() {
    _stateSub = _player.playerStateStream.listen(
      _onPlayerState,
      onError: (Object _) {
        if (isClosed) return;
        unawaited(_failNow());
      },
    );

    _errorSub = _player.errorStream.listen((_) {
      if (isClosed || _tornDown) return;
      unawaited(_failNow());
    });
  }

  void _onPlayerState(PlayerState playerState) {
    if (isClosed || _tornDown) return;

    final String status;
    switch (playerState.processingState) {
      case ProcessingState.idle:
        status = Eza3aStatus.idle;
      case ProcessingState.loading:
      case ProcessingState.buffering:
        status = Eza3aStatus.buffering;
      case ProcessingState.ready:
        status =
            playerState.playing ? Eza3aStatus.playing : Eza3aStatus.paused;
      case ProcessingState.completed:
        status = Eza3aStatus.idle;
    }

    _cancelStallTimer();
    if (status == Eza3aStatus.buffering) {
      _armStallTimer();
    }

    emit(state.copyWith(status: status, clearError: true));
  }

  void _armStallTimer() {
    _cancelStallTimer();
    _stallTimer = Timer(_stallTimeout, () {
      if (state.status == Eza3aStatus.buffering) {
        unawaited(_failNow());
      }
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
    if (isClosed) return;
    emit(
      state.copyWith(
        status: Eza3aStatus.error,
        errorMessage: failureMessage,
      ),
    );
  }

  Future<bool> _hasInternet() async {
    try {
      final results = await Connectivity().checkConnectivity();
      if (results.every((r) => r == ConnectivityResult.none)) return false;
    } on Exception {
      // fall through and probe below when connectivity check is unavailable
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

  Future<void> play() async {
    _tornDown = false;
    _cancelStallTimer();
    emit(state.copyWith(status: Eza3aStatus.buffering, clearError: true));
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

  Future<void> toggle() {
    return state.isPlaying ? pause() : play();
  }

  Future<void> setVolume(double volume) async {
    final clamped = volume.clamp(0.0, 1.0).toDouble();
    if (clamped > 0) {
      _lastVolumeBeforeMute = clamped;
    }
    await _setVolumeSilently(clamped);
    emit(state.copyWith(volume: clamped, isMuted: clamped == 0));
  }

  Future<void> toggleMute() async {
    if (state.isMuted || state.volume == 0) {
      await setVolume(_lastVolumeBeforeMute == 0 ? 0.8 : _lastVolumeBeforeMute);
    } else {
      await setVolume(0);
    }
  }

  Future<void> _setVolumeSilently(double volume) async {
    try {
      await _player.setVolume(volume);
    } on Exception {
      debugPrint('Eza3a: setVolume failed');
    }
  }

  @override
  Future<void> close() async {
    _cancelStallTimer();
    await _stateSub?.cancel();
    await _errorSub?.cancel();
    await _player.dispose();
    await super.close();
  }
}