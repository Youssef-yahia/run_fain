import 'dart:math';

//import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:ourgame/audio/soundplayer.dart';
import 'package:ourgame/constants.dart';
import 'package:ourgame/fain.dart';
import 'package:ourgame/game_object.dart';
import 'package:ourgame/hills.dart';
import 'package:ourgame/map.dart';
import 'package:ourgame/page_route.dart';
import 'package:ourgame/pages/mainmenu.dart';
import 'package:ourgame/roadBlock.dart';
import 'package:ourgame/roadblock2.dart';
import 'package:ourgame/skybox.dart';
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
      home: MainMenuPage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  List<Skybox> skybox = [
    Skybox(worldLocation: Offset(0, 0)),
    Skybox(worldLocation: Offset((480.0 / WORLD_TO_PIXEL_RATIO).toDouble(), 0))
  ];
  List<Hills> hills = [
    Hills(worldLocation: Offset(0, 0)),
    Hills(worldLocation: Offset((1278.0 / WORLD_TO_PIXEL_RATIO).toDouble(), 0))
  ];
  Fain fain = Fain();
  double runDistance = 0;
  double runVelocity = 30;
  double limitVelocity = 60;
  double score = 0;

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

    SoundPlayer.getInstance().playBGM();

    worldController =
        AnimationController(vsync: this, duration: Duration(days: 99));
    worldController.addListener(_update);
    worldController.forward();

    for (int y = 0; y < TILE_MAP.length; y++) {
      for (int x = 0; x < TILE_MAP[y].length; x++) {
        tiles.add(Tile(
            absoluteLocation: Offset(x.toDouble(), y.toDouble()),
            tileType: TILE_MAP[y][x]));
      }
    }
  }

  void _die() {
    setState(() {
      fain.die();
      SCORES.add(score.toInt());
      SoundPlayer.getInstance().stopBGM();

      //worldController.stop();
    });
  }

  // called everytime AnimationController ticks
  _update() {
    fain.update(worldController.lastElapsedDuration! - lastUpdateCall!,
        worldController.lastElapsedDuration!);
    double elapsedTimeSeconds =
        (worldController.lastElapsedDuration! - lastUpdateCall!)
                .inMilliseconds /
            1000;

    if (fain.state != FainState.dead) {
      runDistance += runVelocity * elapsedTimeSeconds;
      score = runDistance;
      print(score);
    }
    runVelocity += elapsedTimeSeconds;
    if (runVelocity > limitVelocity) runVelocity = limitVelocity;

    Size screenSize = MediaQuery.of(context).size;
    Rect fainColRect = fain.collider!
        .getRect(fain.getRect(screenSize, runDistance))
        .deflate(5);
    for (RoadBlock roadBlock in roadBlocks) {
      Rect obstcaleRect = roadBlock.collider!
          .getRect(roadBlock.getRect(screenSize, runDistance));
      if (fainColRect.overlaps(obstcaleRect.deflate(5))) {
        _die();
      }

      if (obstcaleRect.right < 0) {
        setState(() {
          roadBlocks.remove(roadBlock);
          roadBlocks.add(RoadBlock(
              worldLocation: Offset(
                  runDistance + Random().nextInt(100) + runVelocity, 0)));
        });
      }
    }

    for (Skybox sky in skybox) {
      Rect rect = sky.getRect(screenSize, runDistance);
      if (rect.right < 0) {
        sky.worldLocation = Offset(
          sky.worldLocation!.dx + 2 * rect.width / WORLD_TO_PIXEL_RATIO,
          sky.worldLocation!.dy,
        );
      }
    }

    for (Hills hill in hills) {
      Rect rect = hill.getRect(screenSize, runDistance);
      if (rect.right < 0) {
        hill.worldLocation = Offset(
          hill.worldLocation!.dx + 2 * rect.width / WORLD_TO_PIXEL_RATIO,
          hill.worldLocation!.dy,
        );
      }
    }

    for (Tile tile in tiles) {
      Rect rect = tile.getRect(screenSize, runDistance);
      if (rect.right < 0) {
        tile.worldLocation = Offset(
            tile.worldLocation!.dx +
                rect.width * TILE_MAP[0].length / WORLD_TO_PIXEL_RATIO,
            tile.worldLocation!.dy);
        tile.refresh();
        //print("tile out of bounds:" + tile.worldLocation!.dx.toString());
      }
    }

    lastUpdateCall = worldController.lastElapsedDuration;
  }

  Widget bottomButtons(BuildContext context) {
    if (fain.state == FainState.dead) {
      return Positioned(
          bottom: 30,
          left: 0,
          right: 0,
          child: Column(children: [
            const Text("Meow Over", style: STYLE_REGULAR2),
            const SizedBox(height: 200),
            GestureDetector(
                child: const Text(
                  "Back",
                  style: STYLE_REGULAR,
                ),
                onTap: () {
                  worldController.stop();
                  Navigator.of(context).pop();
                  SoundPlayer.getInstance().stopBGM();
                }),
            const SizedBox(
              height: 30,
            ),
            GestureDetector(
                child: const Text(
                  "Restart",
                  style: STYLE_REGULAR,
                ),
                onTap: () {
                  worldController.stop();
                  Navigator.of(context).pop();
                  Navigator.of(context).push(
                    NonePageRoute(
                      builder: (context) => MyHomePage(title: ""),
                    ),
                  );
                }),
          ]));
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    List<Widget> children = [];
    for (GameObject object in [
      ...skybox,
      ...hills,
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

    return Container(
        child: Stack(
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
        AnimatedBuilder(
          animation: worldController,
          builder: (context, _) {
            return Stack(children: [
              Positioned(
                width: screenSize.width,
                left: 10,
                top: 100,
                height: 100,
                child: Text(
                  "Score\n" + score.toInt().toString(),
                  style: STYLE_REGULAR,
                ),
              ),
              bottomButtons(context)
            ]);
          },
        ),
      ],
    )
        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
