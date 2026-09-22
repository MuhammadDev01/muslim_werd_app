abstract class Eza3aRepository {
  Stream<String> get statusStream;
  Stream<String?> get errorStream;

  Future<void> play({required String streamUrl});
  Future<void> pause();
  Future<void> stop();
  Future<void> setVolume(double volume);
  Future<void> dispose();
}
