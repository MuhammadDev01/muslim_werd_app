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
