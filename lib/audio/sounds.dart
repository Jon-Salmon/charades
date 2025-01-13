/// Allows control over loudness of different SFX types.
double soundTypeToVolume(SfxType type) {
  switch (type) {
    case SfxType.ping:
    case SfxType.woosh:
      return 1.0;
  }
}

Duration soundTypeToSkip(SfxType type) {
  switch (type) {
    case SfxType.ping:
      return Duration(milliseconds: 150);
    case SfxType.woosh:
      return Duration(milliseconds: 350);
  }
}

enum SfxType {
  ping("ping.mp3"),
  woosh("woosh.mp3"),
  ;

  final String filename;

  const SfxType(this.filename);
}
