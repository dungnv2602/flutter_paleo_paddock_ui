import 'package:state_notifier/state_notifier.dart';

class SelectedMenuIndexNotifier extends StateNotifier<int> {
  SelectedMenuIndexNotifier({int initialIndex}) : super(initialIndex ?? 0);

  void notifySelectedIndex(int value) {
    if (state == value) return;
    state = value;
  }
}
