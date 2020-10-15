import 'package:flutter/widgets.dart';

class SelectedMenuIndexNotifier extends ValueNotifier<int> {
  SelectedMenuIndexNotifier({int initialIndex}) : super(initialIndex ?? 0);
}