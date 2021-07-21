import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_fight_club/fight_club_colors.dart';
import 'package:flutter_fight_club/fight_club_icons.dart';
import 'package:flutter_fight_club/fight_club_images.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: GoogleFonts.pressStart2pTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  static const maxLives = 5;

  BodyPart? defendingBodyPart;
  BodyPart? attackingBodyPart;

  BodyPart whatEnemyAttacks = BodyPart.random();
  BodyPart whatEnemyDefends = BodyPart.random();

  int yourLives = maxLives;
  int enemysLives = maxLives;

  String youStatusText = '';
  String enemyStatusText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FightClubColors.background,
      body: SafeArea(
        child: Column(
          children: [
            FightersInfo(
              maxLivesCount: maxLives,
              yourLivesCount: yourLives,
              enemysLivesCount: enemysLives,
            ),
            SizedBox(height: 30),
            Expanded(
              child: SizedBox(
                height: 146,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: ColoredBox(
                    color: Color.fromRGBO(197, 209, 234, 1),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Text(
                            "$youStatusText\n$enemyStatusText",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: FightClubColors.darkGreyText,
                              height: 3,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            ControlsWidget(
              selectDefendingBodyPart: _selectDefendingBodyPart,
              selectAttackingBodyPart: _selectAttackingBodyPart,
              defendingBodyPart: defendingBodyPart,
              attackingBodyPart: attackingBodyPart,
            ),
            SizedBox(height: 14),
            GoButton(
              text: (yourLives == 0 || enemysLives == 0)
                  ? "Start new game"
                  : "Go",
              onTap: _onGoButtonClicked,
              color: _getGoButtonColor(),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Color _getGoButtonColor() {
    if (yourLives == 0 || enemysLives == 0) {
      return FightClubColors.blackButton;
    } else if (defendingBodyPart == null || attackingBodyPart == null) {
      return FightClubColors.greyButton;
    } else {
      return FightClubColors.blackButton;
    }
  }

  void _onGoButtonClicked() {
    if (yourLives == 0 || enemysLives == 0) {
      setState(() {
        youStatusText = '';
        enemyStatusText = '';
        yourLives = enemysLives = maxLives;
      });
    } else if (defendingBodyPart != null && attackingBodyPart != null) {
      setState(() {
        final bool enemyLoseLife = attackingBodyPart != whatEnemyDefends;
        final bool youLoseLife = defendingBodyPart != whatEnemyAttacks;

        if (enemyLoseLife) {
          enemysLives -= 1;
          youStatusText =
              'You hit enemy’s ${attackingBodyPart?.name.toLowerCase()}.';
        } else {
          youStatusText = 'Your attack was blocked.';
        }

        if (youLoseLife) {
          yourLives -= 1;
          enemyStatusText =
              'Enemy hit your ${whatEnemyAttacks.name.toLowerCase()}.';
        } else {
          enemyStatusText = 'Enemy’s attack was blocked.';
        }

        if (yourLives == 0 && enemysLives == 0) {
          youStatusText = 'Draw';
          enemyStatusText = '';
        }

        if (yourLives > 0 && enemysLives == 0) {
          youStatusText = 'You won';
          enemyStatusText = '';
        }

        if (yourLives == 0 && enemysLives > 0) {
          youStatusText = 'You lose';
          enemyStatusText = '';
        }

        whatEnemyAttacks = BodyPart.random();
        whatEnemyDefends = BodyPart.random();

        defendingBodyPart = attackingBodyPart = null;
      });
    }
  }

  void _selectDefendingBodyPart(BodyPart value) {
    if (yourLives == 0 || enemysLives == 0) {
      return;
    }
    setState(() {
      defendingBodyPart = value;
    });
  }

  void _selectAttackingBodyPart(BodyPart value) {
    if (yourLives == 0 || enemysLives == 0) {
      return;
    }
    setState(() {
      attackingBodyPart = value;
    });
  }
}

class GoButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color color;

  const GoButton({
    Key? key,
    required this.onTap,
    required this.color,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GestureDetector(
        onTap: onTap,
        child: SizedBox(
          height: 40,
          child: ColoredBox(
            color: color,
            child: Center(
              child: Text(
                text.toUpperCase(),
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 16,
                  color: FightClubColors.whiteText,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ControlsWidget extends StatelessWidget {
  const ControlsWidget({
    Key? key,
    required this.selectDefendingBodyPart,
    required this.selectAttackingBodyPart,
    required this.defendingBodyPart,
    required this.attackingBodyPart,
  }) : super(key: key);

  final BodyPart? defendingBodyPart;
  final ValueSetter<BodyPart> selectDefendingBodyPart;

  final BodyPart? attackingBodyPart;
  final ValueSetter<BodyPart> selectAttackingBodyPart;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Defend".toUpperCase(),
                style: TextStyle(color: FightClubColors.darkGreyText),
              ),
              SizedBox(height: 13),
              BodyPartButton(
                bodyPart: BodyPart.head,
                selected: defendingBodyPart == BodyPart.head,
                bodyPartSetter: selectDefendingBodyPart,
              ),
              SizedBox(height: 14),
              BodyPartButton(
                bodyPart: BodyPart.torso,
                selected: defendingBodyPart == BodyPart.torso,
                bodyPartSetter: selectDefendingBodyPart,
              ),
              SizedBox(height: 14),
              BodyPartButton(
                bodyPart: BodyPart.legs,
                selected: defendingBodyPart == BodyPart.legs,
                bodyPartSetter: selectDefendingBodyPart,
              ),
            ],
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Attack".toUpperCase(),
                style: TextStyle(color: FightClubColors.darkGreyText),
              ),
              SizedBox(height: 13),
              BodyPartButton(
                bodyPart: BodyPart.head,
                selected: attackingBodyPart == BodyPart.head,
                bodyPartSetter: selectAttackingBodyPart,
              ),
              SizedBox(height: 14),
              BodyPartButton(
                bodyPart: BodyPart.torso,
                selected: attackingBodyPart == BodyPart.torso,
                bodyPartSetter: selectAttackingBodyPart,
              ),
              SizedBox(height: 14),
              BodyPartButton(
                bodyPart: BodyPart.legs,
                selected: attackingBodyPart == BodyPart.legs,
                bodyPartSetter: selectAttackingBodyPart,
              ),
            ],
          ),
        ),
        SizedBox(width: 16),
      ],
    );
  }
}

class FightersInfo extends StatelessWidget {
  final int maxLivesCount;
  final int yourLivesCount;
  final int enemysLivesCount;

  const FightersInfo({
    Key? key,
    required this.maxLivesCount,
    required this.yourLivesCount,
    required this.enemysLivesCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 1,
                child: ColoredBox(
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      LivesWidget(
                        overallLivesCount: maxLivesCount,
                        currentLivesCount: yourLivesCount,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          children: [
                            const SizedBox(height: 16),
                            Text(
                              "You",
                              style: TextStyle(
                                  color: FightClubColors.darkGreyText),
                            ),
                            const SizedBox(height: 12),
                            Image.asset(
                              FightClubImages.youAvatar,
                              width: 92,
                              height: 92,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: ColoredBox(
                  color: Color.fromRGBO(197, 209, 234, 1),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          children: [
                            const SizedBox(height: 16),
                            Text(
                              "Enemy",
                              style: TextStyle(
                                  color: FightClubColors.darkGreyText),
                            ),
                            const SizedBox(height: 12),
                            Image.asset(
                              FightClubImages.enemyAvatar,
                              width: 92,
                              height: 92,
                            ),
                          ],
                        ),
                      ),
                      LivesWidget(
                        overallLivesCount: maxLivesCount,
                        currentLivesCount: enemysLivesCount,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Center(
            child: ColoredBox(
              color: Colors.green,
              child: SizedBox(
                width: 44,
                height: 44,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LivesWidget extends StatelessWidget {
  final int overallLivesCount;
  final int currentLivesCount;
  const LivesWidget({
    Key? key,
    required this.overallLivesCount,
    required this.currentLivesCount,
  })  : assert(overallLivesCount >= 1),
        assert(currentLivesCount >= 0),
        assert(currentLivesCount <= overallLivesCount),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(overallLivesCount, (index) {
        if (index < currentLivesCount) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Image.asset(
              FightClubIcons.heartFull,
              width: 18,
              height: 18,
            ),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Image.asset(
              FightClubIcons.heartEmpty,
              width: 18,
              height: 18,
            ),
          );
        }
      }),
    );
  }
}

class BodyPart {
  final String name;

  const BodyPart._(this.name);

  static const head = BodyPart._("Head");
  static const torso = BodyPart._("Torso");
  static const legs = BodyPart._("Legs");

  @override
  String toString() {
    return "BodyPart{name: $name}";
  }

  static const List<BodyPart> _values = [head, torso, legs];

  static BodyPart random() {
    return _values[Random().nextInt(_values.length)];
  }
}

class BodyPartButton extends StatelessWidget {
  final BodyPart bodyPart;
  final bool selected;
  final ValueSetter<BodyPart> bodyPartSetter;

  const BodyPartButton({
    Key? key,
    required this.bodyPart,
    required this.selected,
    required this.bodyPartSetter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => bodyPartSetter(bodyPart),
      child: SizedBox(
        height: 40,
        child: ColoredBox(
          color: (selected)
              ? FightClubColors.blueButton
              : FightClubColors.greyButton,
          child: Center(
            child: Text(
              bodyPart.name.toUpperCase(),
              style: TextStyle(
                color: (selected)
                    ? FightClubColors.whiteText
                    : FightClubColors.darkGreyText,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
