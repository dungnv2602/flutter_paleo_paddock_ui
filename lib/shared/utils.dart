import 'package:flutter/material.dart';

extension AnimationStatusX on AnimationStatus {
  bool get isForward => this == AnimationStatus.forward;
  bool get isCompleted => this == AnimationStatus.completed;
  bool get isReverse => this == AnimationStatus.reverse;
  bool get isDismissed => this == AnimationStatus.dismissed;

  T when<T>({
    T Function(AnimationStatus) onForward,
    T Function(AnimationStatus) onCompleted,
    T Function(AnimationStatus) onReverse,
    T Function(AnimationStatus) onDismissed,
  }) {
    switch (this) {
      case AnimationStatus.forward:
        return onForward?.call(this);
      case AnimationStatus.completed:
        return onCompleted?.call(this);
      case AnimationStatus.reverse:
        return onReverse?.call(this);
      case AnimationStatus.dismissed:
        return onDismissed?.call(this);
    }
    return null; //unreachable
  }
}

extension TextThemeX on BuildContext {
  TextTheme get _textTheme => Theme.of(this).textTheme;
  TextStyle get headline1 => _textTheme.headline1;
  TextStyle get headline2 => _textTheme.headline2;
  TextStyle get headline3 => _textTheme.headline3;
  TextStyle get headline4 => _textTheme.headline4;
  TextStyle get headline5 => _textTheme.headline5;
  TextStyle get headline6 => _textTheme.headline6;
  TextStyle get subtitle1 => _textTheme.subtitle1;
  TextStyle get subtitle2 => _textTheme.subtitle2;
  TextStyle get bodyText1 => _textTheme.bodyText1;
  TextStyle get bodyText2 => _textTheme.bodyText2;
  TextStyle get caption => _textTheme.caption;
  TextStyle get button => _textTheme.button;
  TextStyle get overline => _textTheme.overline;
}

RenderBox getRenderBoxFromContext(BuildContext context) {
  final box = context.findRenderObject() as RenderBox;
  assert(box != null && box.hasSize);
  return box;
}
