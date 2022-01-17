class FightResult {
  final String result;

  const FightResult._(this.result);

  static const won = FightResult._("Won");
  static const lost = FightResult._("Lost");
  static const draw = FightResult._("Draw");

  static const values = [won, lost, draw];

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
    return values.firstWhere(
        (value) => value.result.toLowerCase() == string.toLowerCase());
  }

  @override
  String toString() {
    return "FightResult{result: $result}";
  }
}
