import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

typedef LoadAction<T> = Future<T> Function();

@optionalTypeArgs
mixin AutomaticLoadMixin<T extends StatefulWidget> on State<T> {
  bool get isLoading => _isLoading;
  bool _isLoading = false;

  @protected
  set isLoading(bool value) {
    if (_isLoading == value) return;
    setState(() {
      _isLoading = value;
    });
  }

  @protected
  bool get displayLoading;

  @protected
  Future<U> load<U>(LoadAction<U> action) async {
    _isLoading = true;
    final U result = await action?.call();
    isLoading = false;
    return result;
  }

  @protected
  Widget buildLoadingWidget(BuildContext context);

  @protected
  Widget buildSuccessWidget(BuildContext context);

  @override
  Widget build(BuildContext context) {
    if (isLoading && displayLoading) return buildLoadingWidget(context);
    return buildSuccessWidget(context);
  }
}

@optionalTypeArgs
mixin AutomaticLoadingMixin<T extends StatefulWidget> on State<T> {
  bool get isLoading => _isLoading;
  bool _isLoading = false;

  @protected
  set isLoading(bool value) {
    if (_isLoading == value) return;
    setState(() {
      _isLoading = value;
    });
  }

  @protected
  bool get displayLoading;

  @protected
  Widget buildLoadingWidget(BuildContext context);

  @protected
  Widget buildSuccessWidget(BuildContext context);

  @override
  Widget build(BuildContext context) {
    if (isLoading && displayLoading) return buildLoadingWidget(context);
    return buildSuccessWidget(context);
  }

  Future<U> load<U>(LoadAction<U> action) async {
    _isLoading = true;
    final U result = await action?.call();
    isLoading = false;
    return result;
  }
}
