import 'abstract_model.dart';
import 'serialization_model.dart';

/// APP MODEL - Holds global state/settings for various app components and views.
/// A mix of different values: Current theme, app version, settings, online status, selected sections etc.
/// Some of the values are serialized in app.settings file
class AppModel extends SerializationModel with AbstractModel {
  // Eventually other stuff would go here, appSettings, premiumUser flags, currentTheme, etc...

  /// Toggle fpsMeter
  static bool get showFps => true;

  /// Current connection status
  bool get isOnline => _isOnline;
  bool _isOnline = true;
  set isOnline(bool value) {
    if (_isOnline == value) return;
    _isOnline = value;
    notifyListeners();
  }
}
