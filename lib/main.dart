import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ourgame/constants.dart';
import 'package:ourgame/fain.dart';
import 'package:ourgame/game_object.dart';
import 'package:ourgame/roadBlock.dart';
import 'package:ourgame/roadblock2.dart';
import 'package:ourgame/tile.dart';

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
  double limitVelocity = 60;
  int score = 0;

  late AnimationController worldController;
  Duration? lastUpdateCall = Duration();

  List<RoadBlock> roadBlocks = [
    RoadBlock(
      worldLocation: Offset(200, 0),
    )
  ];

  List<Tile> tiles = [];

  @override
  void initState() {
    super.initState();
    worldController = AnimationController(vsync: this, duration: Duration(days: 99));
    worldController.addListener(_update);
    worldController.forward();

    for (int y = 0; y < TILE_MAP.length; y++) {
      for (int x = 0; x < TILE_MAP[y].length; x++) {
        tiles.add(Tile(absoluteLocation: Offset(x.toDouble(), y.toDouble()), tileType: TILE_MAP[y][x]));
      }
    }
  }

  void _die() {
    setState(() {
      fain.die(); //worldController.stop();
    });
  }

  // called everytime AnimationController ticks
  _update() {
    fain.update(worldController.lastElapsedDuration! - lastUpdateCall!, worldController.lastElapsedDuration!);
    double elapsedTimeSeconds = (worldController.lastElapsedDuration! - lastUpdateCall!).inMilliseconds / 1000;

    if (fain.state != FainState.dead) {
      runDistance += runVelocity * elapsedTimeSeconds;
      score += elapsedTimeSeconds.toInt();
    }
    runVelocity += elapsedTimeSeconds;
    if (runVelocity > limitVelocity) runVelocity = limitVelocity;

    Size screenSize = MediaQuery.of(context).size;
    Rect fainColRect = fain.collider!.getRect(fain.getRect(screenSize, runDistance)).deflate(5);
    for (RoadBlock roadBlock in roadBlocks) {
      Rect obstcaleRect = roadBlock.collider!.getRect(roadBlock.getRect(screenSize, runDistance));
      if (fainColRect.overlaps(obstcaleRect.deflate(5))) {
        _die();
      }

      if (obstcaleRect.right < 0) {
        setState(() {
          roadBlocks.remove(roadBlock);
          roadBlocks.add(RoadBlock(worldLocation: Offset(runDistance + Random().nextInt(100) + runVelocity, 0)));
        });
      }
    }

    for (Tile tile in tiles) {
      Rect rect = tile.getRect(screenSize, runDistance);
      if (rect.right < 0) {
        tile.worldLocation = Offset(tile.worldLocation!.dx + rect.width * TILE_MAP[0].length / WORLD_TO_PIXEL_RATIO, tile.worldLocation!.dy);
        tile.refresh();
        //print("tile out of bounds:" + tile.worldLocation!.dx.toString());
      }
    }

    lastUpdateCall = worldController.lastElapsedDuration;
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    List<Widget> children = [];
    for (GameObject object in [
      ...tiles,
      ...roadBlocks,
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
        body: Stack(
          children: [
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                fain.jump();
              },
              child: Stack(
                alignment: Alignment.center,
                children: children,
              ),
            ),
            Center(
              child: Text(score.toString()),
            ),
          ],
        )
        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
