import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedMenuIndexNotifier =
    StateNotifierProvider.autoDispose<SelectedMenuIndexNotifier>(
  (ref) => SelectedMenuIndexNotifier(initialIndex: 2),
);

class SelectedMenuIndexNotifier extends StateNotifier<int> {
  SelectedMenuIndexNotifier({int initialIndex}) : super(initialIndex ?? 0);

  void notifySelectedIndex(int value) {
    if (state == value) return;
    state = value;
  }
}
