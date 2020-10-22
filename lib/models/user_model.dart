import '../services/models/_models.dart';
import 'abstract_model.dart';
import 'serialization_model.dart';

class UserModel extends SerializationModel with AbstractModel {
  bool get isSignedIn => _currentUser != null;

  List<Restaurant> get likedRestaurants => _likedRestaurants;
  List<Restaurant> _likedRestaurants = [];
  set likedRestaurants(List<Restaurant> value) {
    if (_likedRestaurants == value) return;
    _likedRestaurants = value;
    notifyListeners();
  }

  User get currentUser => _currentUser;
  User _currentUser;
  set currentUser(User value) {
    if (_currentUser == value) return;
    _currentUser = value;
    notifyListeners();
  }

  // Eventually other stuff would go here, notifications, friends, draft posts, etc
}
