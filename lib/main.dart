import 'package:flutter/material.dart';

import 'album_card_widget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Classic Ipod UI',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: IPod(),
    );
  }
}

class IPod extends StatefulWidget {
  IPod({Key key}) : super(key: key);

  @override
  _IPodState createState() => _IPodState();
}

class _IPodState extends State<IPod> {
  final PageController _pageCtrl = PageController(viewportFraction: 0.6);

  double currentPage = 0.0;

  @override
  void initState() {
    _pageCtrl.addListener(() {
      setState(() {
        currentPage = _pageCtrl.page;
      });
    });
    super.initState();
  }

  void _panHandler(DragUpdateDetails dragDetails) {
    double radius = 150;

    // Pan Location on the wheel
    bool onTop = dragDetails.localPosition.dy <= radius;
    bool onLeftSide = dragDetails.localPosition.dx <= radius;
    bool onRightSide = !onLeftSide;
    bool onBottom = !onTop;

    // Pan movements
    bool panUp = dragDetails.delta.dy <= 0.0;
    bool panLeft = dragDetails.delta.dx <= 0.0;
    bool panRight = !panLeft;
    bool panDown = !panUp;

    // Absolute change on axis
    double yChange = dragDetails.delta.dy.abs();
    double xChange = dragDetails.delta.dx.abs();

    // Directional change on wheel
    double verticalRotation = (onRightSide && panDown) || (onLeftSide && panUp)
        ? yChange
        : (yChange * -1);

    double horizontalRotation =
        (onTop && panRight) || (onBottom && panLeft) ? xChange : (xChange * -1);

    // Total computed change
    double rotationalChange = (verticalRotation + horizontalRotation) *
        (dragDetails.delta.distance * 0.2);

    // Move the page view scroller
    _pageCtrl.jumpTo(_pageCtrl.offset + rotationalChange);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white30,
        body: Column(
          children: [
            Container(
              height: 300,
              color: Colors.black,
              child: PageView.builder(
                  controller: _pageCtrl,
                  scrollDirection: Axis.horizontal,
                  itemCount: 9, //Colors.accents.length
                  itemBuilder: (context, int currentIdx) {
                    return AlbumCard(
                      color: Colors.accents[currentIdx],
                      idx: currentIdx,
                      currentPage: currentPage,
                    );
                  }),
            ),
            Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  GestureDetector(
                    onPanUpdate: _panHandler,
                    child: Container(
                      height: 300,
                      width: 300,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black,
                      ),
                      child: Stack(
                        children: [
                          Container(
                            alignment: Alignment.topCenter,
                            margin: const EdgeInsets.only(top: 36),
                            child: Text("MENU",
                                style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                          ),
                          Container(
                            alignment: Alignment.centerRight,
                            margin: const EdgeInsets.only(right: 30),
                            child: IconButton(
                                icon: Icon(Icons.fast_forward),
                                color: Colors.white,
                                iconSize: 40,
                                onPressed: () => _pageCtrl.animateToPage(
                                    (_pageCtrl.page + 1).toInt(),
                                    duration: Duration(milliseconds: 300),
                                    curve: Curves.easeIn)),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            margin: const EdgeInsets.only(left: 30),
                            child: IconButton(
                                icon: Icon(Icons.fast_rewind),
                                iconSize: 40,
                                color: Colors.white,
                                onPressed: () => _pageCtrl.animateToPage(
                                    (_pageCtrl.page - 1).toInt(),
                                    duration: Duration(milliseconds: 300),
                                    curve: Curves.easeIn)),
                          ),
                          Container(
                            alignment: Alignment.bottomCenter,
                            margin: const EdgeInsets.only(bottom: 30),
                            child: Icon(
                              Icons.play_arrow,
                              color: Colors.white,
                              size: 40,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white38,
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
