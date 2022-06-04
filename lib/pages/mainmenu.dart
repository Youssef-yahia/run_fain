import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ourgame/constants.dart';
import 'package:ourgame/main.dart';

class MainMenuPage extends StatelessWidget {
  const MainMenuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

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
