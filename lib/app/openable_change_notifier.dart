import 'package:flutter/widgets.dart';
import 'package:time/time.dart';

import '../shared/index.dart';
import 'openable_state.dart';

class SelectedMenuIndexNotifier extends ValueNotifier<int> {
  SelectedMenuIndexNotifier({int initialIndex}) : super(initialIndex ?? 0);
}

/// AnimationController wrapper especially designed for open-close widget
class OpenableChangeNotifier extends ChangeNotifier {
  OpenableChangeNotifier({
    @required TickerProvider vsync,
    Duration duration,
  })  : assert(vsync != null),
        _controller = AnimationController(
            duration: duration ?? 650.milliseconds, vsync: vsync) {
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
