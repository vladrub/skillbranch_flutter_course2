import 'package:flutter/material.dart';
import 'package:flutter_fight_club/fight_result.dart';
import 'package:flutter_fight_club/resources/fight_club_colors.dart';
import 'package:flutter_fight_club/resources/fight_club_images.dart';

class FightResultWidget extends StatelessWidget {
  final FightResult fightResult;

  const FightResultWidget({
    Key? key,
    required this.fightResult,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      margin: const EdgeInsets.symmetric(
        vertical: 12,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 30,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.white,
            FightClubColors.darkPurple,
          ],
          stops: [0.33, 0.66],
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text(
                "You",
                style: TextStyle(
                  color: FightClubColors.darkGreyText,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 10),
              Image.asset(
                FightClubImages.youAvatar,
                width: 92,
                height: 92,
              ),
            ],
          ),
          Container(
            height: 44,
            decoration: BoxDecoration(
              color: _getResultColor(),
              borderRadius: BorderRadius.circular(20),
            ),
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 4,
            ),
            child: Text(
              fightResult.result.toLowerCase(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
          Column(
            children: [
              Text(
                "Enemy",
                style: TextStyle(
                  color: FightClubColors.darkGreyText,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 10),
              Image.asset(
                FightClubImages.enemyAvatar,
                width: 92,
                height: 92,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color? _getResultColor() {
    if (fightResult.result == "Draw") {
      return FightClubColors.blueButton;
    } else if (fightResult.result == "Won") {
      return FightClubColors.green;
    } else if (fightResult.result == "Lost") {
      return FightClubColors.red;
    }
  }
}
