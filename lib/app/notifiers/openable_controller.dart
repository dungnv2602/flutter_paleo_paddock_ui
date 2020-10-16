import 'package:flutter/foundation.dart' show describeEnum;
import 'package:flutter/widgets.dart';
import 'package:time/time.dart';

import '../../shared/_shared.dart';

class SelectedMenuIndexNotifier extends ValueNotifier<int> {
  SelectedMenuIndexNotifier({int initialIndex}) : super(initialIndex ?? 0);
}

/// AnimationController wrapper especially designed for open-close widget
class OpenableController extends ChangeNotifier {
  OpenableController({
    @required TickerProvider vsync,
    Duration duration,
    Duration reverseDuration,
  })  : assert(vsync != null),
        _controller = AnimationController(
          duration: duration ?? 600.milliseconds,
          reverseDuration: reverseDuration ?? 300.milliseconds,
          vsync: vsync,
        ) {
    _controller
      ..addListener(notifyListeners)
      ..addStatusListener(_animationStatusListener);
  }

  void _animationStatusListener(AnimationStatus status) {
    status.when<void>(
      onForward: (_) => _openableState = OpenableState.opening,
      onCompleted: (_) => _openableState = OpenableState.opened,
      onReverse: (_) => _openableState = OpenableState.closing,
      onDismissed: (_) => _openableState = OpenableState.closed,
    );
    notifyListeners();
  }

  final AnimationController _controller;

  Animation<double> get animation => _controller.view;

  double get animationValue => _controller.value;
  double get reverseAnimationValue => 1 - _controller.value;

  OpenableState get openableState => _openableState;
  OpenableState _openableState = OpenableState.closed;

  void open() => _controller.forward();

  void close() => _controller.reverse();

  void toggle() {
    if (openableState.isClosed) {
      open();
    } else if (openableState.isOpened) {
      close();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}



enum OpenableState {
  closed,
  opening,
  opened,
  closing,
}

extension OpenableStateX on OpenableState {
  bool get isOpened => this == OpenableState.opened;
  bool get isOpening => this == OpenableState.opening;
  bool get isClosed => this == OpenableState.closed;
  bool get isClosing => this == OpenableState.closing;

  T when<T>({
    T Function(OpenableState) onOpened,
    T Function(OpenableState) onOpening,
    T Function(OpenableState) onClosed,
    T Function(OpenableState) onClosing,
  }) {
    switch (this) {
      case OpenableState.opened:
        return onOpened?.call(this);
      case OpenableState.opening:
        return onOpening?.call(this);
      case OpenableState.closed:
        return onClosed?.call(this);
      case OpenableState.closing:
        return onClosing?.call(this);
    }
    return null; //unreachable
  }

  String get asString => describeEnum(this);
}