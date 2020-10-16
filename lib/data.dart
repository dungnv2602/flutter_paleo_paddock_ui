import 'package:flutter/material.dart';

import 'shared/_shared.dart';
import 'widgets/_widgets.dart';

final restaurantScreens = [
  ScreenRecipe(
    title: 'THE PALEO PADDOCK',
    backgroundPath: 'assets/images/paddock/wood_bk.jpg',
    body: ListView(
      children: restaurants
          .map((e) => RestaurantCard(model: e))
          .toList(growable: false),
    ),
  ),
  ScreenRecipe(
    title: 'THE DARK GRUNGE',
    backgroundPath: 'assets/images/paddock/dark_grunge_bk.jpg',
    body: ListView(
      children: restaurants
          .map((e) => RestaurantCard(model: e))
          .toList(growable: false),
    ),
  ),
  ScreenRecipe(
    title: 'RECIPES',
    backgroundPath: 'assets/images/paddock/other_screen_bk.jpg',
    body: ListView(
      children: restaurants
          .map((e) => RestaurantCard(model: e))
          .toList(growable: false),
    ),
  ),
  const ScreenRecipe(
    title: 'SETTINGS',
    body: Center(child: Text('SETTINGS')),
  ),
];

const restaurants = [
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
