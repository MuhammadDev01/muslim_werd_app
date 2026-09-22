import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muslim_werd_app/features/eza3a/data/repositories/eza3a_repository_impl.dart';
import 'package:muslim_werd_app/features/eza3a/domain/models/eza3a_state.dart';
import 'package:muslim_werd_app/features/eza3a/domain/repositories/eza3a_repository.dart';

class Eza3aCubit extends Cubit<Eza3aState> {
  Eza3aCubit({Eza3aRepository? repository, String? streamUrl})
    : _repository = repository ?? Eza3aRepositoryImpl(),
      streamUrl = streamUrl ?? defaultStreamUrl,
      super(const Eza3aState()) {
    _bindRepository();
    unawaited(_repository.setVolume(state.volume));
  }

  static const String defaultStreamUrl =
      'https://stream.radiojar.com/8s5u5tpdtwzuv';

  final Eza3aRepository _repository;
  final String streamUrl;

  StreamSubscription<String>? _statusSub;
  StreamSubscription<String?>? _errorSub;
  double _lastVolumeBeforeMute = 0.8;

  void _bindRepository() {
    _statusSub = _repository.statusStream.listen((status) {
      if (isClosed) return;
      emit(
        state.copyWith(status: status, clearError: status != Eza3aStatus.error),
      );
    });

    _errorSub = _repository.errorStream.listen((error) {
      if (isClosed) return;
      if (error != null) {
        emit(state.copyWith(status: Eza3aStatus.error, errorMessage: error));
      }
    });
  }

  Future<void> play() async {
    await _repository.play(streamUrl: streamUrl);
  }

  Future<void> pause() async {
    await _repository.pause();
  }

  Future<void> stop() async {
    await _repository.stop();
  }

  Future<void> toggle() {
    return state.isPlaying ? pause() : play();
  }

  Future<void> setVolume(double volume) async {
    final clamped = volume.clamp(0.0, 1.0).toDouble();
    if (clamped > 0) {
      _lastVolumeBeforeMute = clamped;
    }
    await _repository.setVolume(clamped);
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
    await _statusSub?.cancel();
    await _errorSub?.cancel();
    await _repository.dispose();
    await super.close();
  }
}
