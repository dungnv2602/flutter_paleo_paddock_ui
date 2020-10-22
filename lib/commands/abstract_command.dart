import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../globals.dart';
import '../models/_models.dart';
import '../services/_services.dart';

BuildContext _mainContext;

// The commands will use this to access the Provided models and services.
void init(BuildContext context) => _mainContext = context;

// Provide quick lookup methods for all the top-level models and services. Keeps the Command code slightly cleaner.
mixin AbstractCommand {
  NavigatorState get rootNav => AppGlobals.nav;

  T _getProvided<T>() => Provider.of<T>(_mainContext, listen: false);

  /// Convenience lookup methods for all commands to share
  ///
  /// Models
  AppModel get authModel => _getProvided();
  UserModel get userModel => _getProvided();
  RestaurantModel get restaurantModel => _getProvided();
  MenuModel get menuModel => _getProvided();

  /// Services
  UserService get userService => _getProvided();
  RestaurantService get restaurantService => _getProvided();
}
