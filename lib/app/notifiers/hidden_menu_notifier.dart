import 'package:flutter/widgets.dart';
import 'openable_change_notifier.dart';
import 'selected_menu_index_notifier.dart';

class HiddenMenuProvider extends InheritedWidget {
  const HiddenMenuProvider({
    Key key,
    @required Widget child,
    @required this.controller,
  }) : super(
          child: child,
          key: key,
        );

  final HiddenMenuNotifier controller;

  static HiddenMenuNotifier of(BuildContext context) => context
      .dependOnInheritedWidgetOfExactType<HiddenMenuProvider>()
      .controller;

  @override
  bool updateShouldNotify(HiddenMenuProvider oldWidget) {
    return oldWidget.controller != controller;
  }
}

class HiddenMenuNotifier {
  HiddenMenuNotifier({
    @required TickerProvider vsync,
    Duration duration,
    int initialIndex,
  })  : openableChangeNotifier =
            OpenableChangeNotifier(vsync: vsync, duration: duration),
        selectedIndexNotifier =
            SelectedMenuIndexNotifier(initialIndex: initialIndex);

  final OpenableChangeNotifier openableChangeNotifier;

  final SelectedMenuIndexNotifier selectedIndexNotifier;

  void dispose() {
    openableChangeNotifier.dispose();
    selectedIndexNotifier.dispose();
  }
}
