import 'package:flutter/material.dart';
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
            Column(
              children: [
                FutureBuilder<int?>(
                  future: SharedPreferences.getInstance().then(
                    (sharedPreferences) =>
                        sharedPreferences.getInt("stats_won"),
                  ),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData || snapshot.data == null) {
                      return _statusText("Won: 0");
                    }

                    return _statusText("Won: ${snapshot.data}");
                  },
                ),
                SizedBox(height: 6),
                FutureBuilder<int?>(
                  future: SharedPreferences.getInstance().then(
                    (sharedPreferences) =>
                        sharedPreferences.getInt("stats_lost"),
                  ),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData || snapshot.data == null) {
                      return _statusText("Lost: 0");
                    }

                    return _statusText("Lost: ${snapshot.data}");
                  },
                ),
                SizedBox(height: 6),
                FutureBuilder<int?>(
                  future: SharedPreferences.getInstance().then(
                    (sharedPreferences) =>
                        sharedPreferences.getInt("stats_draw"),
                  ),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData || snapshot.data == null) {
                      return _statusText("Draw: 0");
                    }

                    return _statusText("Draw: ${snapshot.data}");
                  },
                ),
              ],
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
