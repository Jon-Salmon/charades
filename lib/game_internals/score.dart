import '../level_selection/category.dart';

class ScoreItem {
  final String word;
  final bool correct;

  const ScoreItem(this.word, this.correct);
}

class Score {
  final GameCategory category;
  final List<ScoreItem> items = [];

  Score(this.category);
}
