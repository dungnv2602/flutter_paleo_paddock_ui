import 'package:flutter/material.dart';
import 'package:time/time.dart';

import 'models/_models.dart';

class RestaurantService {
  Future<List<Restaurant>> getRestaurantsByStreet(String streetName) async {
    // Fake a network service call, and return true
    await Future<void>.delayed(1.seconds);
    // for demo purpose only, in reality this will be achieved from json conversion
    return _restaurants;
  }

  Future<List<Restaurant>> getLikedRestaurants(User user) async {
    // Fake a network service call, and return true
    await Future<void>.delayed(1.seconds);
    // for demo purpose only, in reality this will be achieved from json conversion
    return _likedRestaurants;
  }
}

const _likedRestaurants = [
  Restaurant(
    imagePath: 'assets/images/paddock/spoons_of_spices.jpg',
    icon: Icons.fastfood,
    iconColor: Colors.purpleAccent,
    title: 'Sugar & Spice',
    subtitle: '79 5TH AVENUE, NEW YORK',
    likes: 19,
  ),
];

const _restaurants = [
  Restaurant(
    imagePath: 'assets/images/paddock/eggs_in_skillet.jpg',
    icon: Icons.fastfood,
    iconColor: Colors.orange,
    title: 'il domacca',
    subtitle: '77 5TH AVENUE, NEW YORK',
    likes: 17,
  ),
  Restaurant(
    imagePath: 'assets/images/paddock/steak_on_cooktop.jpg',
    icon: Icons.local_dining,
    iconColor: Colors.red,
    title: 'McGrady',
    subtitle: '78 5TH AVENUE, NEW YORK',
    likes: 18,
  ),
  Restaurant(
    imagePath: 'assets/images/paddock/spoons_of_spices.jpg',
    icon: Icons.fastfood,
    iconColor: Colors.purpleAccent,
    title: 'Sugar & Spice',
    subtitle: '79 5TH AVENUE, NEW YORK',
    likes: 19,
  ),
];
