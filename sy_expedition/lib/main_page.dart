import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

import 'package:sy_expedition/styles.dart';

class PageOffsetNotifier with ChangeNotifier {
  double _offset = 0;
  double _page = 0;

  PageOffsetNotifier(PageController pageController) {
    pageController.addListener(() {
      _offset = pageController.offset;
      _page = pageController.page;
      notifyListeners();
    });
  }

  double get offset => _offset;
  double get page => _page;
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  final PageController _pageController = PageController();

  double get maxHeight => MediaQuery.of(context).size.height;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (_) {
        return PageOffsetNotifier(_pageController);
      },
      child: ListenableProvider.value(
        value: _animationController,
        child: Scaffold(
          body: GestureDetector(
            onVerticalDragUpdate: _handleDragUpdate,
            onVerticalDragEnd: _handleDragEnd,
            child: SafeArea(
              child: Stack(alignment: Alignment.center, children: <Widget>[
                PageView(
                  controller: _pageController,
                  physics: ClampingScrollPhysics(),
                  children: <Widget>[
                    LeopardPage(),
                    VulturePage(),
                  ],
                ),
                LeopardImage(),
                VultureImage(),
                AppBar(),
                PageIndicators(),
                ShareButton(),
                ArrowIcon(),
                TravelDetailsLabel(),
                StartCampLabel(),
                StartTimeLabel(),
                BaseCampLabel(),
                BaseTimeLabel(),
                TheKMLabel(),
                HorizontalTravelDots(),
                MapButton(),
                VerticalTravelDots(),
                VultureIconLabel(),
                LeopardsIconLabel(),
              ]),
            ),
          ),
        ),
      ),
    );
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    _animationController.value -= details.primaryDelta / maxHeight;
  }

  void _handleDragEnd(DragEndDetails details) {
    if (_animationController.isAnimating ||
        _animationController.status == AnimationStatus.completed) return;

    final double flingVelocity =
        details.velocity.pixelsPerSecond.dy / maxHeight;

    if (flingVelocity < 0.0) {
      _animationController.fling(velocity: math.max(2.0, -flingVelocity));
    } else if (flingVelocity > 0.0) {
      _animationController.fling(velocity: math.max(-2.0, -flingVelocity));
    } else {
      _animationController.fling(
          velocity: _animationController.value < 0.5 ? -2.0 : 2.0);
    }
  }
}

class LeopardImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer2<PageOffsetNotifier, AnimationController>(
      builder: (context, notifier, animation, child) {
        //print(notifier.offset);
        return Positioned(
          //top: 100,
          left: -0.86 * notifier.offset,
          //height: 275,
          width: MediaQuery.of(context).size.width * 1.6,
          child: Transform.scale(
            alignment: Alignment(0.3, 0),
            scale: 1 - 0.10 * animation.value,
            child: Opacity(opacity: 1 - 0.6 * animation.value, child: child),
          ),
        );
      },
      child: IgnorePointer(
        child: Image.asset('assets/leopard.png'),
      ),
    );
  }
}

class VultureImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer2<PageOffsetNotifier, AnimationController>(
        builder: (context, notifier, animation, child) {
          //print(notifier.offset);
          return Positioned(
            //top: 100,
            left: 1.21 * MediaQuery.of(context).size.width -
                0.85 * notifier.offset,
            height: MediaQuery.of(context).size.height / 3,
            //width: MediaQuery.of(context).size.width * 1.6,
            child: Transform.scale(
              alignment: Alignment(-0.5, 0),
              scale: 1 - 0.1 * animation.value,
              child: Opacity(opacity: 1 - 0.6 * animation.value, child: child),
            ),
          );
        },
        child: IgnorePointer(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 40.0),
            child: Image.asset(
              'assets/vulture.png',
            ),
          ),
        ));
  }
}

class AppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: <Widget>[
            Text(
              'SY',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Spacer(),
            Icon(
              Icons.menu,
              size: 24,
            ),
          ],
        ),
      ),
    );
  }
}

class ShareButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 16,
      //left: 0,
      right: 24,
      child: Icon(
        Icons.share,
        size: 24,
      ),
    );
  }
}

class PageIndicators extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<PageOffsetNotifier>(
      builder: (context, notifier, _) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: notifier.page.round() == 0 ? white : lightGrey,
                  ),
                  height: 6,
                  width: 6,
                ),
                SizedBox(width: 6),
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: notifier.page.round() != 0 ? white : lightGrey,
                  ),
                  height: 6,
                  width: 6,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class LeopardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 32),
        SizedBox(height: 128),
        The72Text(),
        SizedBox(height: 32),
        TravelDescriptionLabel(),
        SizedBox(height: 32),
        LeopardDescription(),
      ],
    );
  }
}

class TravelDescriptionLabel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<PageOffsetNotifier>(
      builder: (context, notifier, child) {
        return Opacity(
          opacity: math.max(0, 1 - 4 * notifier.page),
          child: child,
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 40.0),
        child: Text(
          'Travel description',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

class LeopardDescription extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<PageOffsetNotifier>(
      builder: (context, notifier, child) {
        return Opacity(
          opacity: math.max(0, 1 - 4 * notifier.page),
          child: child,
        );
      },
      child: Padding(
        //padding: const EdgeInsets.only(left: 40.0),
        padding: const EdgeInsets.fromLTRB(40, 0, 10, 0),
        child: Text(
          'The leopard is distinguished by its well-camouflaged fur, opportunistic hunting behaviour, broad diet, and strength.',
          style: TextStyle(fontSize: 15, color: lighterGrey),
        ),
      ),
    );
  }
}

class ArrowIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AnimationController>(
      builder: (context, animation, child) {
        return Positioned(
          top: 128.0 + 32 + (1 - animation.value) * (32.00 + 32 - 28 + 400),
          right: 24,
          child: child,
        );
      },
      child: Icon(
        Icons.keyboard_arrow_up,
        size: 28,
        color: lighterGrey,
      ),
    );
  }
}

class The72Text extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<PageOffsetNotifier>(
      builder: (context, notifier, child) {
        return Transform.translate(
          offset: Offset(-50 - 0.5 * notifier.offset, 0),
          child: child,
        );
      },
      child: RotatedBox(
        quarterTurns: 1,
        child: SizedBox(
          width: 400, //mainSquareSize(context),
          child: FittedBox(
            alignment: Alignment.topCenter,
            fit: BoxFit.cover,
            child: Text(
              '72',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
      //),
    );
  }
}

class VulturePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: VultureCircle());
  }
}

//Page2 begins

class TravelDetailsLabel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer2<PageOffsetNotifier, AnimationController>(
      builder: (context, notifier, animation, child) {
        return Positioned(
          top: 128.0 + 32 + (1 - animation.value) * (32.00 + 32 - 18 + 400),
          left: 24 + MediaQuery.of(context).size.width - notifier.offset,
          child: Opacity(
            opacity: math.max(0, 4 * notifier.page - 3),
            child: child,
          ),
        );
      },
      child: Text(
        'Travel details',
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}

class StartCampLabel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<PageOffsetNotifier>(
      builder: (context, notifier, child) {
        double opacity = math.max(0, 4 * notifier.page - 3);
        return Positioned(
          top: 32.00 + 128 + 32 + 400 + 32 + 32,
          width: (MediaQuery.of(context).size.width - 48) / 3,
          left: opacity * 24.0,
          child: Opacity(
            opacity: opacity,
            child: child,
          ),
        );
      },
      child: Align(
        alignment: Alignment.centerRight,
        child: Text(
          'Start camp',
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w300),
        ),
      ),
    );
  }
}

class StartTimeLabel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<PageOffsetNotifier>(
      builder: (context, notifier, child) {
        double opacity = math.max(0, 4 * notifier.page - 3);
        return Positioned(
          top: 32.00 + 128 + 32 + 400 + 32 + 32 + 40,
          width: (MediaQuery.of(context).size.width - 48) / 3,
          left: opacity * 24.0,
          child: Opacity(
            opacity: opacity,
            child: child,
          ),
        );
      },
      child: Align(
        alignment: Alignment.centerRight,
        child: Text(
          '02:40 PM',
          style: TextStyle(
              fontSize: 17, fontWeight: FontWeight.w300, color: lighterGrey),
        ),
      ),
    );
  }
}

class BaseCampLabel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer2<PageOffsetNotifier, AnimationController>(
      builder: (context, notifier, animation, child) {
        double opacity = math.max(0, 4 * notifier.page - 3);
        return Positioned(
          top: 128.0 +
              32 +
              40 +
              17 +
              (1 - animation.value) * (32.00 + 32 - 17 - 8 + 400),
          width: (MediaQuery.of(context).size.width - 48) / 3,
          right: opacity * 24.0,
          child: Opacity(
            opacity: opacity,
            child: child,
          ),
        );
      },
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          'Base camp',
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w300),
        ),
      ),
    );
  }
}

class BaseTimeLabel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer2<PageOffsetNotifier, AnimationController>(
      builder: (context, notifier, animation, child) {
        double opacity = math.max(0, 4 * notifier.page - 3);
        return Positioned(
          top: 128.0 +
              32 +
              32 +
              48 +
              17 +
              (1 - animation.value) * (32.00 + 40 - 17 - 16 + 400),
          width: (MediaQuery.of(context).size.width - 48) / 3,
          right: opacity * 24.0,
          child: Opacity(
            opacity: opacity,
            child: child,
          ),
        );
      },
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          '07:40 AM',
          style: TextStyle(
              fontSize: 17, fontWeight: FontWeight.w300, color: lighterGrey),
        ),
      ),
    );
  }
}

class TheKMLabel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<PageOffsetNotifier>(
      builder: (context, notifier, child) {
        double opacity = math.max(0, 4 * notifier.page - 3);
        return Positioned(
          top: 32.00 + 128 + 32 + 400 + 32 + 32 + 40,
          left: 0,
          right: 0,
          //width: (MediaQuery.of(context).size.width - 48) / 3,
          //right: opacity * 24.0,
          child: Opacity(
            opacity: opacity,
            child: child,
          ),
        );
      },
      child: Center(
        child: Text(
          '72 KM',
          style: TextStyle(
              fontSize: 17, fontWeight: FontWeight.bold, color: white),
        ),
      ),
    );
  }
}

class HorizontalTravelDots extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer2<PageOffsetNotifier, AnimationController>(
      builder: (context, notifier, animation, child) {
        double spacingFactor;
        double opacity; //= math.max(0, 4 * notifier.page - 3);
        if (animation.value == 0) {
          spacingFactor = math.max(0, 4 * notifier.page - 3);
          opacity = spacingFactor;
        } else {
          spacingFactor = math.max(0, 1 - 6 * animation.value);
          opacity = 1;
        }
        return Positioned(
          top: 32.00 + 128 + 32 + 400 + 32 + 32 + 8,
          left: 0,
          right: 0,
          child: Center(
            child: Opacity(
              opacity: opacity,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: spacingFactor * 10),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: lightGrey,
                      //border: Border.all(color: lightGrey),
                    ),
                    width: 4,
                    height: 4,
                  ),
                  Container(
                    margin: EdgeInsets.only(right: spacingFactor * 10),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: lightGrey,
                      //border: Border.all(color: lightGrey),
                    ),
                    width: 4,
                    height: 4,
                  ),
                  Container(
                    margin: EdgeInsets.only(right: spacingFactor * 40),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: lightGrey),
                    ),
                    width: 8,
                    height: 8,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: spacingFactor * 40),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: white,
                    ),
                    width: 8,
                    height: 8,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class MapButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      child: Consumer<PageOffsetNotifier>(
        builder: (context, notifier, child) {
          double opacity = math.max(0, 4 * notifier.page - 3);
          return Opacity(
            opacity: opacity,
            child: child,
          );
        },
        child: FlatButton(
          child: Text(
            "On Map",
            style: TextStyle(fontSize: 12),
          ),
          onPressed: () {
            Provider.of<AnimationController>(context).forward();
          },
        ),
      ),
    );
  }
}

class VultureCircle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer2<PageOffsetNotifier, AnimationController>(
      builder: (context, notifier, animation, child) {
        double opacity; //= math.max(0, 4 * notifier.page - 3);
        if (animation.value == 0) {
          opacity = math.max(0, 4 * notifier.page - 3);
        } else
          opacity = math.max(0, 1 - 6 * animation.value);
        double size = MediaQuery.of(context).size.width * 0.5 * opacity;
        return Container(
          margin: const EdgeInsets.only(bottom: 200),
          decoration: BoxDecoration(shape: BoxShape.circle, color: lighterGrey),
          width: size,
          height: size,
        );
      },
    );
  }
}

class VerticalTravelDots extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AnimationController>(
      builder: (context, animation, child) {
        if (animation.value < 1 / 6) {
          return Container();
        }

        // print(MediaQuery.of(context).size.height -
        //     (32.00 + 128 + 32 + 400 + 32 + 32 + 32 + 20 + 40));
        double endTop = 128.0 + 32 + 40 + 24;
        double bottom = MediaQuery.of(context).size.height -
            (32.00 + 128 + 32 + 400 + 32 + 32 + 34 + 20 + 40);
        double top =
            endTop + (1 - (1.2 * (animation.value - 1 / 6))) * (32.00 + 400);
        //(32.00 + 32 - 17 + 400) need to check
        //print(endTop);
        //print(bottom);
        //print((top + bottom));
        //print(MediaQuery.of(context).size.height - endTop - bottom);
        // print((endTop + bottom) / 3);
        double oneThird = (top + bottom + 32 + 40) / 3;
        double twoThird = 2 * oneThird;
        return Positioned(
          top: top,
          bottom: bottom,
          child: Center(
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: white,
                  ),
                  width: 3,
                  height: top + bottom + 32 + 40, //double.infinity,
                ),
                Positioned(
                  top:
                      oneThird, //top > oneThird + endTop ? 0 : oneThird + endTop - top,
                  //bottom: bottom,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: white,
                        width: 2.5,
                      ),
                      color: mainBlack,
                    ),
                    width: 10,
                    height: 10,
                  ),
                ),
                Positioned(
                  top: twoThird,
                  //top > 2 * oneThird + endTop
                  //     ? 0
                  //     : 2 * oneThird + endTop - top,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: white, width: 2.5),
                      color: mainBlack,
                    ),
                    width: 10,
                    height: 10,
                  ),
                ),
                Align(
                  alignment: Alignment(0, 1),
                  child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: mainBlack,
                        border: Border.all(color: white, width: 1)),
                    width: 10,
                    height: 10,
                  ),
                ),
                Align(
                  alignment: Alignment(0, -1),
                  child: Container(
                    decoration:
                        BoxDecoration(shape: BoxShape.circle, color: white),
                    width: 10,
                    height: 10,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class LeopardsIconLabel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AnimationController>(
      builder: (context, animation, child) {
        double opacity;
        if (animation.value < 3 / 4) {
          opacity = 0;
        } else {
          opacity = 4 * (animation.value - 3 / 4);
        }

        double endTop = 128.0 + 32 + 40 + 24;
        double bottom = MediaQuery.of(context).size.height -
            (32.00 + 128 + 32 + 400 + 32 + 32 + 34 + 20 + 40 - 32 - 28 - 0);
        double top =
            endTop + (1 - (1.2 * (animation.value - 1 / 6))) * (32.00 + 400);
        double oneThird = (top + bottom + 32 + 40) / 3;
        //double twoThird = 2 * oneThird;
        return Positioned(
          top: bottom + oneThird - 28 - 16 - 8,
          left: 10 + opacity * 16,
          child: Opacity(opacity: opacity, child: child),
        );
      },
      child: SmallAnimalIconLabel(
        isVulture: false,
        showLine: true,
      ),
    );
  }
}

class VultureIconLabel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AnimationController>(
      builder: (context, animation, child) {
        double opacity;
        if (animation.value < 2 / 3) {
          opacity = 0;
        } else {
          opacity = 3 * (animation.value - 2 / 3);
        }

        double endTop = 128.0 + 32 + 40 + 24;
        double bottom = MediaQuery.of(context).size.height -
            (32.00 + 128 + 32 + 400 + 32 + 32 + 34 + 20 + 40 - 32 - 17);
        double top =
            endTop + (1 - (1.2 * (animation.value - 1 / 6))) * (32.00 + 400);
        double oneThird = (top + bottom + 32 + 40) / 3;
        double twoThird = 2 * oneThird;
        return Positioned(
          top: bottom + twoThird - 28 - 16 - 8,
          right: 10 + opacity * 16,
          child: Opacity(opacity: opacity, child: child),
        );
      },
      child: SmallAnimalIconLabel(
        isVulture: true,
        showLine: true,
      ),
    );
  }
}

class SmallAnimalIconLabel extends StatelessWidget {
  final bool isVulture;
  final bool showLine;
  const SmallAnimalIconLabel(
      {Key key, @required this.isVulture, @required this.showLine})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (isVulture && showLine)
          Container(
            margin: EdgeInsets.only(bottom: 4),
            width: 16,
            height: 1,
            color: white,
          ),
        SizedBox(width: 24),
        Column(
          children: [
            Image.asset(
              isVulture ? 'assets/vultures.png' : 'assets/leopards.png',
              width: 28,
              height: 28,
            ),
            SizedBox(height: 16),
            Text(
              isVulture ? 'Vultures' : 'Leopards',
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
        SizedBox(width: 24),
        if (!isVulture && showLine)
          Container(
            margin: EdgeInsets.only(bottom: 4),
            width: 16,
            height: 1,
            color: white,
          ),
      ],
    );
  }
}

class MapAnimationNotifier with ChangeNotifier {
  final AnimationController _animationController;

  MapAnimationNotifier(this._animationController) {
    _animationController.addListener(() {
      notifyListeners();
    });
  }

  double get value => _animationController.value;
}
