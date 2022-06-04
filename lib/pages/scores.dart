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

    for (int i = 0; i < 3; i++) {
      if (i < scores.length) {
        scoreWidgets.add(
          Text(
            (i + 1).toString() + "- " + scores[i].toString(),
            style: STYLE_REGULAR,
          ),
        );
      } else {
        scoreWidgets.add(Text(
          (i + 1).toString() + "- ...",
          style: STYLE_REGULAR,
        ));
      }
    }
    return Container(
      color: Colors.black,
      child: Center(
        child: Column(children: [
          SizedBox(height: screenSize.height * 0.3),
          ...scoreWidgets,
          SizedBox(height: screenSize.height * 0.15),
          backText(context),
        ]),
      ),
    );
  }

  Widget backText(BuildContext context) {
    return GestureDetector(
      child: Text('Back', style: STYLE_REGULAR),
      onTap: () {
        Navigator.of(context).pop();
      },
    );
  }
}
