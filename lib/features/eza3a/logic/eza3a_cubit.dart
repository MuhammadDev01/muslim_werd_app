import 'dart:async';

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
    unawaited(_player.setVolume(state.volume));
  }

  static const String defaultStreamUrl =
      'https://stream.radiojar.com/8s5u5tpdtwzuv';

  final AudioPlayer _player;
  final String streamUrl;

  StreamSubscription<PlayerState>? _stateSub;
  StreamSubscription<PlayerException>? _errorSub;
  double _lastVolumeBeforeMute = 0.8;

  void _bindPlayer() {
    _stateSub = _player.playerStateStream.listen((playerState) {
      if (isClosed) return;
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
      emit(state.copyWith(status: status, clearError: true));
    });

    _errorSub = _player.errorStream.listen((exception) {
      if (isClosed) return;
      emit(
        state.copyWith(
          status: Eza3aStatus.error,
          errorMessage: 'تعذّر الاتصال بالإذاعة. تحقق من اتصالك وأعد المحاولة.',
        ),
      );
    });
  }

  Future<void> play() async {
    try {
      if (_player.processingState == ProcessingState.idle ||
          _player.processingState == ProcessingState.completed) {
        await _player.setUrl(streamUrl);
      }
      await _player.play();
    } on PlayerException {
      emit(
        state.copyWith(
          status: Eza3aStatus.error,
          errorMessage: 'تعذّر الاتصال بالإذاعة. تحقق من اتصالك وأعد المحاولة.',
        ),
      );
    }
  }

  Future<void> pause() async {
    await _player.pause();
  }

  Future<void> stop() async {
    await _player.stop();
  }

  Future<void> toggle() {
    return state.isPlaying ? pause() : play();
  }

  Future<void> setVolume(double volume) async {
    final clamped = volume.clamp(0.0, 1.0).toDouble();
    if (clamped > 0) {
      _lastVolumeBeforeMute = clamped;
    }
    await _player.setVolume(clamped);
    emit(state.copyWith(volume: clamped, isMuted: clamped == 0));
  }

  Future<void> toggleMute() async {
    if (state.isMuted || state.volume == 0) {
      await setVolume(_lastVolumeBeforeMute == 0 ? 0.8 : _lastVolumeBeforeMute);
    } else {
      await setVolume(0);
    }
  }

  @override
  Future<void> close() async {
    await _stateSub?.cancel();
    await _errorSub?.cancel();
    await _player.dispose();
    await super.close();
  }
}