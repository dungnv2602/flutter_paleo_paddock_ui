import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '_models.dart';

BuildContext _mainContext;

// The models will use this to access the models.
void init(BuildContext context) => _mainContext = context;

// Provide quick lookup methods for all the top-level models.
mixin AbstractModel {
  T _getProvided<T>() => Provider.of<T>(_mainContext, listen: false);

  AppModel get authModel => _getProvided();
  UserModel get userModel => _getProvided();
  RestaurantModel get restaurantModel => _getProvided();
  MenuModel get menuModel => _getProvided();

  
}
