import 'package:flutter/widgets.dart';

import '../app_extensions.dart';
import 'abstract_model.dart';
import 'serialization_model.dart';

class MenuModel extends SerializationModel with AbstractModel {
  MenuModel({
    @required TickerProvider vsync,
    Duration duration,
    Duration reverseDuration,
    int initialMenuIndex,
  })  : _selectedMenuIndex = initialMenuIndex ?? 0,
        _openableController = OpenableController(
          vsync: vsync,
          duration: duration,
          reverseDuration: reverseDuration,
        );

  OpenableController get openableController => _openableController;
  final OpenableController _openableController;

  int get selectedMenuIndex => _selectedMenuIndex;
  int _selectedMenuIndex;
  set selectedMenuIndex(int value) {
    if (_selectedMenuIndex == value) return;
    _selectedMenuIndex = value;
    notifyListeners();
  }

  
}

class SelectedMenuIndexNotifier extends ValueNotifier<int> {
  SelectedMenuIndexNotifier({int initialIndex}) : super(initialIndex ?? 0);
}
