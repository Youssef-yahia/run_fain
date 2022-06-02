import 'package:flutter/material.dart';
import 'package:ourgame/fain.dart';
import 'package:ourgame/game_object.dart';
import 'package:ourgame/roadBlock.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Application name
      title: 'Flutter Dodge game',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Dodge Game Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  Fain fain = Fain();
  double runDistance = 0;
  double runVelocity = 30;

  late AnimationController worldController;
  Duration lastUpdateCall = Duration();

  List<RoadBlock> roadBlock = [
    RoadBlock(worldLocation: Offset(200, 0))
  ];

  @override
  void initState() {
    super.initState();
    worldController = AnimationController(vsync: this, duration: Duration(days: 99));
    worldController.addListener(_update);
    worldController.forward();
  }

  // called everytime AnimationController ticks
  _update() {
    fain.update(worldController.lastElapsedDuration! - lastUpdateCall!, worldController.lastElapsedDuration!);
    double elapsedTimeSeconds = (worldController.lastElapsedDuration - lastUpdateCall).inMilliseconds / 1000;

    lastUpdateCall = worldController.lastElapsedDuration!;
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    List<Widget> children = [];

    for (GameObject object in [
      ...roadBlock,
      fain
    ]) {
      children.add(AnimatedBuilder(
          animation: worldController,
          builder: (context, _) {
            Rect objectRect = object.getRect(screenSize, runDistance);
            return Positioned(
              left: objectRect.left,
              top: objectRect.top,
              width: objectRect.width,
              height: objectRect.height,
              child: object.render(),
            );
          }));
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            fain.jump();
          },
          child: Stack(
            alignment: Alignment.center,
            children: children,
          ),
        ) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
