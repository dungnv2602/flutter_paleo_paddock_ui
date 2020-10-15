import 'package:flutter/foundation.dart' show describeEnum;

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
