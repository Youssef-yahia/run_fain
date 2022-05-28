import 'package:flutter/material.dart';
import 'package:ourgame/fain.dart';

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

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  Fain fain = Fain();
  double runDistance = 0;

  late AnimationController worldController;
  Duration? lastUpdateCall = Duration();

  @override
  void initState() {
    super.initState();
    worldController =
        AnimationController(vsync: this, duration: Duration(days: 99));
    worldController.addListener(_update);
    worldController.forward();
  }

  // called everytime AnimationController ticks
  _update() {
    fain.update(worldController.lastElapsedDuration! - lastUpdateCall!,
        worldController.lastElapsedDuration!);
    lastUpdateCall = worldController.lastElapsedDuration;
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
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
            children: [
              AnimatedBuilder(
                  animation: worldController,
                  builder: (context, _) {
                    Rect fainRect = fain.getRect(screenSize, runDistance);
                    return Positioned(
                      left: fainRect.left,
                      top: fainRect.top,
                      width: fainRect.width,
                      height: fainRect.height,
                      child: fain.render(),
                    );
                  })
            ],
          ),
        ) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
