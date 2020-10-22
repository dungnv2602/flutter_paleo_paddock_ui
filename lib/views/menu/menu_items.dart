import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../app_extensions.dart';

const _menuItemCurve = Curves.easeOutCubic;
const _indicatorCurve = Curves.fastOutSlowIn;
const _indicatorDelayInterval = Interval(0.5, 1.0, curve: _indicatorCurve);

class HiddenMenuItems extends StatefulWidget {
  const HiddenMenuItems({
    Key key,
    @required this.controller,
    @required this.models,
    this.initialSelected = 0,
    this.onItemSelected,
  })  : assert(initialSelected <= models.length - 1),
        super(key: key);

  final OpenableController controller;
  final List<HiddenMenuItemModel> models;
  final ValueChanged<int> onItemSelected;
  final int initialSelected;
  @override
  _HiddenMenuItemsState createState() => _HiddenMenuItemsState();
}

class _HiddenMenuItemsState extends State<HiddenMenuItems>
    with SingleTickerProviderStateMixin {
  AnimationController _indicatorController;
  Tween<double> _indicatorYWhenMenuOpen = Tween<double>(begin: 0, end: 0);
  Tween<double> _indicatorYWhenMenuClose = Tween<double>(begin: 0, end: 0);
  Tween<double> _indicatorYWhenAnIndexIsSelected =
      Tween<double>(begin: 0, end: 0);

  Curve _menuItemSlideIntervalAt(int index) => _menuItemSlideIntervals[index];
  List<Curve> _menuItemSlideIntervals;
  List<Curve> _initializeMenuItemSlideIntervals(int itemCount) {
    const slideInterval = 0.1;
    final slideTime = 1 - itemCount / 10;

    return List.generate(
      itemCount,
      (index) {
        final start = index * slideInterval;
        final interval = Interval(
          start,
          start + slideTime,
          curve: _menuItemCurve,
        );
        return interval;
      },
      growable: false,
    );
  }

  Size _menuItemSize = Size.zero;
  void _notifyMenuItemSize(Size value) {
    assert(value != null && value != Size.zero);
    if (_menuItemSize == value) return;
    debugPrint('_notifyMenuItemSize');
    setState(() {
      _menuItemSize = value;
    });
    _setIndicatorYTweenWhenMenuOpenAndClose();
  }

  bool _isIndexSelected(int index) => _selectedIndex == index;
  int _selectedIndex;
  int _lastSelectedIndex;
  void _notifyAnIndexIsSelected(int index) {
    if (_isIndexSelected(index)) return;
    setState(() {
      _lastSelectedIndex = _selectedIndex;
      _selectedIndex = index;
    });
  }

  void _setIndicatorYTweenWhenMenuOpenAndClose() {
    final menuItemHeight = _menuItemSize.height;
    final bottomY = menuItemHeight * (widget.models.length - 1);
    final lastIndex = widget.models.length - 1;
    final indexGap = lastIndex - _selectedIndex;
    final translationFromBottomY = bottomY - menuItemHeight * indexGap;

    _indicatorYWhenMenuOpen =
        Tween<double>(begin: context.heightPx, end: translationFromBottomY);

    _indicatorYWhenMenuClose = Tween<double>(
        begin: translationFromBottomY, end: translationFromBottomY);
  }

  void _setIndicatorYTweenWhenIndexSelected() {
    final menuItemHeight = _menuItemSize.height;

    const lastSelectedY = 0.0;

    final indexGap = _lastSelectedIndex - _selectedIndex;

    final currentSelectedY =
        lastSelectedY - indexGap.sign * indexGap.abs() * menuItemHeight;

    _indicatorYWhenAnIndexIsSelected =
        Tween<double>(begin: lastSelectedY, end: currentSelectedY);
  }

  Future<void> _animateIndicatorAtSelectedIndex() async {
    // set indicator position for indicator transition animation between indexes
    _setIndicatorYTweenWhenIndexSelected();
    await _indicatorController.forward(from: 0);
    // re-assign indicator position for open-close animation
    _setIndicatorYTweenWhenMenuOpenAndClose();
    _indicatorYWhenAnIndexIsSelected = Tween<double>(begin: 0, end: 0);
  }

  @override
  void initState() {
    super.initState();
    _lastSelectedIndex = widget.initialSelected;
    _selectedIndex = widget.initialSelected;

    _menuItemSlideIntervals =
        _initializeMenuItemSlideIntervals(widget.models.length);

    _indicatorController = AnimationController(
      vsync: this,
      duration: 300.milliseconds,
    );
  }

  @override
  Widget build(BuildContext context) {
    /// Provide this ViewModel/State to the sub-views, for easily call
    return Provider.value(
      value: this,
      child: _HiddenMenuItemsView(this),
    );
  }
}

class _HiddenMenuItemsView
    extends StatefulView<HiddenMenuItems, _HiddenMenuItemsState> {
  const _HiddenMenuItemsView(_HiddenMenuItemsState state, {Key key})
      : super(state, key: key);

  Widget _buildAnimatedIndicator(OpenableController controller) {
    final indicator = Container(
      width: 5,
      height: state._menuItemSize.height,
      child: Container(
        color: Colors.red,
        margin: const EdgeInsets.symmetric(vertical: 8),
      ),
    );

    final fadeIndicator = FadeTransition(
      opacity: controller.animation,
      child: indicator,
    );

    final indicatorWhenMenuOpenAndClose = AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        final value =
            _indicatorDelayInterval.transform(controller.animationValue);

        switch (controller.openableState) {
          case OpenableState.closed:
          case OpenableState.closing:
            return Transform(
              transform: Matrix4.translationValues(
                  0, state._indicatorYWhenMenuClose.transform(value), 0),
              child: fadeIndicator,
            );
            break;
          case OpenableState.opened:
          case OpenableState.opening:
            return Transform(
              transform: Matrix4.translationValues(
                  0, state._indicatorYWhenMenuOpen.transform(value), 0),
              child: fadeIndicator,
            );
            break;
        }

        return null;
      },
    );

    return AnimatedBuilder(
      animation: state._indicatorController,
      builder: (_, __) {
        final value =
            _indicatorCurve.transform(state._indicatorController.value);

        return Transform(
          transform: Matrix4.translationValues(
              0, state._indicatorYWhenAnIndexIsSelected.transform(value), 0),
          child: indicatorWhenMenuOpenAndClose,
        );
      },
    );
  }

  Widget _buildMenuItem(
      OpenableController controller, int index, HiddenMenuItemModel model) {
    final menuItem = _HiddenMenuItem(
      title: model.title,
      icon: model.icon,
      color: state._isIndexSelected(index) ? Colors.red : Colors.white,
      onPressed: () async {
        state._notifyAnIndexIsSelected(index);
        await state._animateIndicatorAtSelectedIndex();
        state.widget.onItemSelected?.call(index);
      },
    );

    final fadeMenuItem = FadeTransition(
      opacity: controller.animation,
      child: menuItem,
    );

    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        switch (controller.openableState) {
          case OpenableState.closed:
          case OpenableState.closing:
            return fadeMenuItem;
          case OpenableState.opened:
          case OpenableState.opening:
            final value = state
                ._menuItemSlideIntervalAt(index)
                .transform(controller.animationValue);
            final translateY = context.heightPx * (1 - value);
            return Transform(
              transform: Matrix4.translationValues(0, translateY, 0),
              child: fadeMenuItem,
            );
        }
        return null;
      },
    );
  }

  List<Widget> _buildMenuItems(OpenableController controller) {
    final menuItems = <Widget>[];
    for (var index = 0; index < widget.models.length; index++) {
      final model = widget.models[index];
      menuItems.add(_buildMenuItem(controller, index, model));
    }
    return menuItems;
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('HiddenMenuItems: rebuild');

    return Stack(
      children: [
        Column(
          children: _buildMenuItems(widget.controller),
        ),
        _buildAnimatedIndicator(widget.controller),
      ],
    );
  }
}

class _HiddenMenuItem extends StatefulWidget {
  const _HiddenMenuItem({
    Key key,
    this.icon,
    this.color,
    this.onPressed,
    @required this.title,
  })  : assert(title != null),
        super(key: key);

  final Widget icon;
  final Color color;
  final String title;
  final VoidCallback onPressed;

  @override
  _HiddenMenuItemState createState() => _HiddenMenuItemState();
}

class _HiddenMenuItemState extends State<_HiddenMenuItem> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => afterLayout());
  }

  void afterLayout() {
    final renderBox = getRenderBoxFromContext(context);
    context.read<_HiddenMenuItemsState>()._notifyMenuItemSize(renderBox.size);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onPressed,
      splashColor: const Color(0x44000000),
      child: Padding(
        padding: const EdgeInsets.only(top: 16, bottom: 16, left: 16),
        child: Row(
          children: <Widget>[
            if (widget.icon != null) widget.icon,
            const SizedBox(width: 16),
            Text(
              widget.title,
              style: context.headline5.letterSpace(2).textColor(widget.color),
            ),
          ],
        ),
      ),
    );
  }
}

class HiddenMenuItemModel {
  const HiddenMenuItemModel({
    this.icon,
    @required this.title,
  });

  final Widget icon;
  final String title;
}
