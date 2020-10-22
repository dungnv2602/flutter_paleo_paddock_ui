import '../services/models/_models.dart';
import 'abstract_model.dart';
import 'serialization_model.dart';

class RestaurantModel extends SerializationModel with AbstractModel{
  List<Restaurant> get restaurants => _restaurants;
  List<Restaurant> _restaurants = [];
  set restaurants(List<Restaurant> value) {
    if (_restaurants == value) return;
    _restaurants = value;
    notifyListeners();
  }

  // Eventually other stuff regarding restaurant would go here.
}
