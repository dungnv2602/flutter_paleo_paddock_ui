import 'package:flutter/widgets.dart';

import 'openable_change_notifier.dart';
import 'selected_menu_index_notifier.dart';

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
