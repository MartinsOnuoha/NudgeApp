import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  final double fontSize;
  final bool isDarkTheme;
  const Logo({
    Key key,
    this.fontSize,
    this.isDarkTheme = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Image.asset(
      'assets/images/${isDarkTheme ? 'logo_white' : 'logo_blue'}.png',
      scale: 2,
    ));
  }
}
