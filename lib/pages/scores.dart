import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ourgame/constants.dart';
import 'package:ourgame/main.dart';

class ScoresPage extends StatelessWidget {
  const ScoresPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    List<int> scores = List.from(SCORES);
    scores.sort((a, b) => b.compareTo(a));

    List<Widget> scoreWidgets = [];

    for (int i = 0; i < 10; i++) {
      if (i < scores.length) {
        scoreWidgets.add(
          Text(
            scores[i].toString(),
            style: STYLE_REGULAR,
          ),
        );
      } else {
        scoreWidgets.add(Text(
          "...",
          style: STYLE_REGULAR,
        ));
      }
    }
    return Container(
      color: Colors.black,
      child: Center(
        child: Column(
          children: [
            SizedBox(
              height: screenSize.height * 0.25,
            ),
            titleText(context),
            SizedBox(height: screenSize.height * 0.25),
            newGameText(context),
            SizedBox(height: screenSize.height * 0.05),
            scoreText(context),
          ],
        ),
      ),
    );
  }

  Widget titleText(BuildContext context) {
    return Text(
      'RUN KITTY!',
      style: STYLE_TITLE,
    );
  }

  Widget newGameText(BuildContext context) {
    return GestureDetector(
        child: Text('New Game', style: STYLE_REGULAR),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => MyHomePage(title: ""),
            ),
          );
        });
  }

  Widget scoreText(BuildContext context) {
    return GestureDetector(
        child: Text('Scores', style: STYLE_REGULAR),
        onTap: () {
          print("score clcik");
        });
  }
}
