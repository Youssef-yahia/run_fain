import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ourgame/constants.dart';
import 'package:ourgame/main.dart';
import 'package:ourgame/page_route.dart';
import 'package:ourgame/pages/scores.dart';

class MainMenuPage extends StatelessWidget {
  const MainMenuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Container(
      color: Colors.black,
      child: Stack(
        children: [
          Positioned(
            child: SafeArea(
                child: FittedBox(
                    child: Image.asset("assets/BG_solid.png"),
                    fit: BoxFit.fill)),
            width: screenSize.width,
            height: screenSize.height,
            top: 0,
            left: 0,
          ),
          Positioned(
              child: Image.asset("assets/BG.png"),
              left: 0,
              top: 0,
              width: 480,
              height: 480),
          Center(
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
        ],
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
          NonePageRoute(
            builder: (context) => MyHomePage(title: ""),
          ),
        );
      },
    );
  }

  Widget scoreText(BuildContext context) {
    return GestureDetector(
        child: Text('Scores', style: STYLE_REGULAR),
        onTap: () {
          Navigator.of(context).push(
            NonePageRoute(
              builder: (context) => ScoresPage(),
            ),
          );
        });
  }
}
