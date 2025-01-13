import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../generated/assets.gen.dart';

final gameCategories = [
  GameCategory(name: "Animals", icon: Icons.pets, wordsPath: Assets.words.animals),
  GameCategory(name: "Food", icon: Icons.fastfood, wordsPath: Assets.words.food),
  GameCategory(name: "Movies", icon: Icons.movie, wordsPath: Assets.words.movies),
  GameCategory(name: "Science", icon: Icons.science, wordsPath: Assets.words.science),
  GameCategory(name: "Countries", icon: Icons.location_city, wordsPath: Assets.words.contries),
  GameCategory(name: "Fairy Tales", icon: Icons.book, wordsPath: Assets.words.fairyTales),
  GameCategory(name: "Sports", icon: Icons.sports, wordsPath: Assets.words.sports),
  GameCategory(name: "Brands", icon: Icons.business, wordsPath: Assets.words.brands),
  GameCategory(name: "Music", icon: Icons.music_note, wordsPath: Assets.words.music),
  GameCategory(name: "Musicals", icon: Icons.music_note, wordsPath: Assets.words.musicals),
  GameCategory(name: "Bible Books", icon: Icons.book, wordsPath: Assets.words.bibleBooks),
  GameCategory(name: "Bible Stories", icon: Icons.book, wordsPath: Assets.words.bibleStories),
  GameCategory(name: "Sports Legends", icon: Icons.sports, wordsPath: Assets.words.sportsLegends),
  GameCategory(name: "Celebrities", icon: Icons.person, wordsPath: Assets.words.celebrities),
  GameCategory(name: "TV Shows", icon: Icons.tv, wordsPath: Assets.words.tvShows),
  GameCategory(name: "Harry Potter", icon: Icons.book, wordsPath: Assets.words.harryPotter),
  GameCategory(name: "Star Wars", icon: Icons.star, wordsPath: Assets.words.starWars),
  GameCategory(name: "Heroes and Villains", icon: Icons.person, wordsPath: Assets.words.herosAndVillians),
  GameCategory(name: "Historical Figures", icon: Icons.person, wordsPath: Assets.words.historicalFigures),
  GameCategory(name: "Karaoke Songs", icon: Icons.music_note, wordsPath: Assets.words.karaokeSongs),
  GameCategory(name: "British Sitcoms", icon: Icons.tv, wordsPath: Assets.words.britishSitComms),
  GameCategory(name: "Literature", icon: Icons.book, wordsPath: Assets.words.literature),
  GameCategory(name: "Video Games", icon: Icons.videogame_asset, wordsPath: Assets.words.videoGames),
];

class GameCategory {
  final String name;
  final IconData icon;
  final String wordsPath;

  const GameCategory({required this.name, this.icon = Icons.category, required this.wordsPath});

  Future<List<String>> loadWords() async {
    final data = await rootBundle.loadString(wordsPath);
    return data.split("\n").map((e) => e.trim()).where((o) => o.isNotEmpty).toList();
  }
}
