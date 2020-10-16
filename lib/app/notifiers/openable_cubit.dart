import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:time/time.dart';

import '../../shared/index.dart';
import 'openable_state.dart';

class OpenableCubit extends Cubit<OpenableProperties> {
  OpenableCubit({
    @required TickerProvider vsync,
    Duration duration,
    Duration reverseDuration,
  })  : assert(vsync != null),
        _controller = AnimationController(
          duration: duration ?? 600.milliseconds,
          reverseDuration: reverseDuration ?? 300.milliseconds,
          vsync: vsync,
        ),
        super(const OpenableProperties.initial()) {
    _controller
      ..addListener(_animationValueListener)
      ..addStatusListener(_animationStatusListener);
  }

  void _animationValueListener() {
    emit(
      state.copyWith(
        animationValue: _controller.value,
        reverseAnimationValue: 1 - _controller.value,
      ),
    );
  }

  void _animationStatusListener(AnimationStatus status) {
    status.when<void>(
      onForward: (_) =>
          emit(state.copyWith(openableState: OpenableState.opening)),
      onCompleted: (_) =>
          emit(state.copyWith(openableState: OpenableState.opened)),
      onReverse: (_) =>
          emit(state.copyWith(openableState: OpenableState.closing)),
      onDismissed: (_) =>
          emit(state.copyWith(openableState: OpenableState.closed)),
    );
  }

  final AnimationController _controller;

  Animation<double> get animation => _controller.view;

  void open() => _controller.forward();

  void shut() => _controller.reverse();

  void toggle() {
    if (state.openableState.isClosed) {
      open();
    } else if (state.openableState.isOpened) {
      shut();
    }
  }

  @override
  Future<void> close() {
    _controller.dispose();
    return super.close();
  }
}

class OpenableProperties extends Equatable {
  const OpenableProperties({
    this.openableState,
    this.animationValue,
    this.reverseAnimationValue,
  });

  const OpenableProperties.initial()
      : openableState = OpenableState.closed,
        animationValue = 0,
        reverseAnimationValue = 0;

  final OpenableState openableState;
  final double animationValue;
  final double reverseAnimationValue;

  OpenableProperties copyWith({
    OpenableState openableState,
    double animationValue,
    double reverseAnimationValue,
  }) {
    return OpenableProperties(
      openableState: openableState ?? this.openableState,
      animationValue: animationValue ?? this.animationValue,
      reverseAnimationValue:
          reverseAnimationValue ?? this.reverseAnimationValue,
    );
  }

  @override
  List<Object> get props => [
        openableState,
        animationValue,
        reverseAnimationValue,
      ];
}
