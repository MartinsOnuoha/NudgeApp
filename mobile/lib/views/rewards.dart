import 'package:flutter/material.dart';
import 'package:nudge/utils/margin.dart';
import 'package:nudge/utils/theme.dart';

class RewardsPage extends StatefulWidget {
  RewardsPage({Key key}) : super(key: key);

  @override
  _RewardsPageState createState() => _RewardsPageState();
}

class _RewardsPageState extends State<RewardsPage>
    with TickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;

  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _animation = Tween<double>(
      begin: 0.3,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.decelerate,
      ),
    );
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFFDCA8),
      body: AnimatedBuilder(
          animation: _controller,
          builder: (BuildContext context, Widget child) {
            return Transform.scale(
              child: CardStack(
                child: Column(
                  children: <Widget>[
                    Container(
                      height: screenWidth(context, percent: 0.21),
                      width: screenWidth(context, percent: 0.21),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/rewards.png'))),
                    ),
                    const YMargin(30),
                    Text(
                      'Congratulations',
                      style: TextStyle(
                          fontSize: 17, fontFamily: 'GalanoGrotesque2'),
                    ),
                    Text(
                      'Woosh! You earned 20pts For complete attendance today ',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'GalanoGrotesque',
                          color: lightText),
                    ),
                    Spacer(),
                    Container(
                      height: 55,
                      margin:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                      child: FlatButton(
                        textColor: white,
                        color: blue,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        onPressed: () {},
                        child: Text(
                          'Collect Reward',
                          style: TextStyle(
                              fontSize: 17, fontFamily: 'GalanoGrotesque2'),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              scale: _animation.value,
            );
          }),
    );
  }
}

class CardStack extends StatelessWidget {
  final Widget child;
  const CardStack({
    Key key,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 38.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: screenHeight(context, percent: 0.51),
                  width: screenWidth(context, percent: 0.61),
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: [
                      new BoxShadow(
                        offset: Offset(0, -1),
                        spreadRadius: -10,
                        color: text.withOpacity(0.1),
                        blurRadius: 20,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 13.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: screenHeight(context, percent: 0.51),
                  width: screenWidth(context, percent: 0.71),
                  decoration: BoxDecoration(
                    color: Colors.white54,
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: [
                      new BoxShadow(
                        offset: Offset(0, -1),
                        spreadRadius: -10,
                        color: text.withOpacity(0.1),
                        blurRadius: 20,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 28.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: screenHeight(context, percent: 0.51),
                  width: screenWidth(context, percent: 0.83),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: [
                      new BoxShadow(
                        offset: Offset(0, -1),
                        spreadRadius: -10,
                        color: text.withOpacity(0.18),
                        blurRadius: 20,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Container(
            padding: const EdgeInsets.only(bottom: 28.0),
            height: screenHeight(context, percent: 0.51),
            width: screenWidth(context, percent: 0.61),
            child: Center(child: child),
          ),
        )
      ],
    );
  }
}
