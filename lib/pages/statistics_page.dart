import 'package:flutter/material.dart';
import 'package:flutter_fight_club/fight_result.dart';
import 'package:flutter_fight_club/resources/fight_club_colors.dart';
import 'package:flutter_fight_club/widgets/secondary_action_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StatisticsPage extends StatelessWidget {
  const StatisticsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FightClubColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 24),
              child: Text(
                "Statistics",
                style: TextStyle(
                  color: FightClubColors.darkGreyText,
                  fontSize: 24,
                ),
              ),
            ),
            Expanded(child: SizedBox()),
            FutureBuilder<SharedPreferences>(
              future: SharedPreferences.getInstance(),
              builder: (context, snapshot) {
                if (!snapshot.hasData || snapshot.data == null) {
                  return const SizedBox();
                }

                final SharedPreferences sp = snapshot.data!;

                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _statusText("Won: ${sp.getInt('stats_won') ?? 0}"),
                    SizedBox(height: 6),
                    _statusText("Lost: ${sp.getInt('stats_lost') ?? 0}"),
                    SizedBox(height: 6),
                    _statusText("Draw: ${sp.getInt('stats_draw') ?? 0}"),
                  ],
                );
              },
            ),
            Expanded(child: SizedBox()),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SecondaryActionButton(
                onTap: () {
                  Navigator.of(context).pop();
                },
                text: "Back",
              ),
            )
          ],
        ),
      ),
    );
  }

  Text _statusText(String s) {
    return Text(
      s,
      style: TextStyle(
        color: FightClubColors.darkGreyText,
        fontSize: 16,
        height: 2.5,
      ),
    );
  }
}
