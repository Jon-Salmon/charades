/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/back.png
  AssetGenImage get back => const AssetGenImage('assets/images/back.png');

  /// File path: assets/images/restart.png
  AssetGenImage get restart => const AssetGenImage('assets/images/restart.png');

  /// File path: assets/images/settings.png
  AssetGenImage get settings =>
      const AssetGenImage('assets/images/settings.png');

  /// List of all assets
  List<AssetGenImage> get values => [back, restart, settings];
}

class $AssetsSfxGen {
  const $AssetsSfxGen();

  /// File path: assets/sfx/ping.mp3
  String get ping => 'assets/sfx/ping.mp3';

  /// File path: assets/sfx/woosh.mp3
  String get woosh => 'assets/sfx/woosh.mp3';

  /// List of all assets
  List<String> get values => [ping, woosh];
}

class $AssetsWordsGen {
  const $AssetsWordsGen();

  /// File path: assets/words/animals.txt
  String get animals => 'assets/words/animals.txt';

  /// File path: assets/words/bible_books.txt
  String get bibleBooks => 'assets/words/bible_books.txt';

  /// File path: assets/words/bible_stories.txt
  String get bibleStories => 'assets/words/bible_stories.txt';

  /// File path: assets/words/brands.txt
  String get brands => 'assets/words/brands.txt';

  /// File path: assets/words/british_sit_comms.txt
  String get britishSitComms => 'assets/words/british_sit_comms.txt';

  /// File path: assets/words/celebrities.txt
  String get celebrities => 'assets/words/celebrities.txt';

  /// File path: assets/words/contries.txt
  String get contries => 'assets/words/contries.txt';

  /// File path: assets/words/fairy_tales.txt
  String get fairyTales => 'assets/words/fairy_tales.txt';

  /// File path: assets/words/food.txt
  String get food => 'assets/words/food.txt';

  /// File path: assets/words/harry_potter.txt
  String get harryPotter => 'assets/words/harry_potter.txt';

  /// File path: assets/words/heros_and_villians.txt
  String get herosAndVillians => 'assets/words/heros_and_villians.txt';

  /// File path: assets/words/historical_figures.txt
  String get historicalFigures => 'assets/words/historical_figures.txt';

  /// File path: assets/words/karaoke_songs.txt
  String get karaokeSongs => 'assets/words/karaoke_songs.txt';

  /// File path: assets/words/literature.txt
  String get literature => 'assets/words/literature.txt';

  /// File path: assets/words/movies.txt
  String get movies => 'assets/words/movies.txt';

  /// File path: assets/words/music.txt
  String get music => 'assets/words/music.txt';

  /// File path: assets/words/musicals.txt
  String get musicals => 'assets/words/musicals.txt';

  /// File path: assets/words/science.txt
  String get science => 'assets/words/science.txt';

  /// File path: assets/words/sports.txt
  String get sports => 'assets/words/sports.txt';

  /// File path: assets/words/sports_legends.txt
  String get sportsLegends => 'assets/words/sports_legends.txt';

  /// File path: assets/words/star_wars.txt
  String get starWars => 'assets/words/star_wars.txt';

  /// File path: assets/words/tv_shows.txt
  String get tvShows => 'assets/words/tv_shows.txt';

  /// File path: assets/words/video_games.txt
  String get videoGames => 'assets/words/video_games.txt';

  /// List of all assets
  List<String> get values => [
        animals,
        bibleBooks,
        bibleStories,
        brands,
        britishSitComms,
        celebrities,
        contries,
        fairyTales,
        food,
        harryPotter,
        herosAndVillians,
        historicalFigures,
        karaokeSongs,
        literature,
        movies,
        music,
        musicals,
        science,
        sports,
        sportsLegends,
        starWars,
        tvShows,
        videoGames
      ];
}

class Assets {
  Assets._();

  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $AssetsSfxGen sfx = $AssetsSfxGen();
  static const $AssetsWordsGen words = $AssetsWordsGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
