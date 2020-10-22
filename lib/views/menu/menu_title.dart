import 'package:flutter/material.dart';

class MenuTitle extends StatelessWidget {
  const MenuTitle({
    Key key,
    @required this.animation,
  }) : super(key: key);

  final Animation<double> animation;

  static const _curve = Curves.easeOutCubic;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (_, child) {
        final animationValue = _curve.transform(animation.value);

        return Transform(
          transform: Matrix4.translationValues(
            250 * (1 - animationValue) - 50 * animationValue,
            0,
            0,
          ),
          child: child,
        );
      },
      child: const Text(
        'Menu',
        style: TextStyle(
          color: Color(0x88444444),
          fontSize: 250,
          height: 1.2,
          letterSpacing: 1.2,
          fontFamily: 'lora',
        ),
        textAlign: TextAlign.center,
        softWrap: false,
      ),
    );
  }
}
