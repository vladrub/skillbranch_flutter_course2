class FightResult {
  final String result;

  const FightResult._(this.result);

  static const won = FightResult._("Won");
  static const lost = FightResult._("Lost");
  static const draw = FightResult._("Draw");

  static FightResult? calculateResult(
      final int yourLives, final int enemysLives) {
    if (yourLives == 0 && enemysLives == 0) {
      return draw;
    } else if (yourLives == 0) {
      return lost;
    } else if (enemysLives == 0) {
      return won;
    } else {
      return null;
    }
  }

  static FightResult? fromString(final String string) {
    if (string.toLowerCase() == "won") {
      return won;
    } else if (string.toLowerCase() == "draw") {
      return draw;
    } else if (string.toLowerCase() == "lost") {
      return lost;
    } else {
      return null;
    }
  }

  @override
  String toString() {
    return "FightResult{result: $result}";
  }
}
