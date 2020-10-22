import '../services/_services.dart';
import 'abstract_command.dart';

class GetLikedRestaurantsCommand with AbstractCommand {
  Future<List<Restaurant>> execute(User user) async {
    final likedRestaurants = await restaurantService.getLikedRestaurants(user);
    userModel.likedRestaurants = likedRestaurants;
    return likedRestaurants;
  }
}

class GetRestaurantsByStreetCommand with AbstractCommand {
  Future<List<Restaurant>> execute(String streetName) async {
    final restaurants =
        await restaurantService.getRestaurantsByStreet(streetName);
    userModel.likedRestaurants = restaurants;
    return restaurants;
  }
}
