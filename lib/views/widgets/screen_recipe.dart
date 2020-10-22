import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:paleo_paddock_ui/commands/restaurant_commands.dart';

import '../../app_extensions.dart';

List<ScreenRecipe> getRestaurantScreenRecipes({bool isSignedIn}) {
  final recipes = <ScreenRecipe>[];

  recipes.add(
    ScreenRecipe(
      title: 'THE PALEO PADDOCK',
      backgroundPath: 'assets/images/paddock/wood_bk.jpg',
    ),
  );

  recipes.add(
    ScreenRecipe(
      title: 'THE DARK GRUNGE',
      backgroundPath: 'assets/images/paddock/dark_grunge_bk.jpg',
    ),
  );

  recipes.add(
    ScreenRecipe(
      title: 'RECIPES',
      backgroundPath: 'assets/images/paddock/other_screen_bk.jpg',
    ),
  );

  if (isSignedIn) {
    recipes.add(
      ScreenRecipe(
        title: 'MY FAVOURITE',
        backgroundPath: 'assets/images/paddock/other_screen_bk.jpg',
      ),
    );
  }

  recipes.add(
    const ScreenRecipe(
      title: 'SETTINGS',
      body: Center(child: Text('SETTINGS')),
    ),
  );

  return List.unmodifiable(recipes);
}

class RestaurantListView extends StatefulWidget {
  const RestaurantListView({
    Key key,
    @required this.streetName,
  }) : super(key: key);

  final String streetName;

  @override
  _RestaurantListViewState createState() => _RestaurantListViewState();
}

class _RestaurantListViewState extends State<RestaurantListView> {
  @override
  void initState() {
    super.initState();
    GetRestaurantsByStreetCommand().execute(widget.streetName);
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class ScreenRecipe {
  const ScreenRecipe({
    @required this.body,
    @required this.title,
    this.backgroundPath,
  });
  final Widget body;
  final String title;
  final String backgroundPath;
}

class ScreenRecipeBuilder extends StatelessWidget {
  const ScreenRecipeBuilder({
    Key key,
    @required this.recipe,
    this.onMenuPressed,
  }) : super(key: key);

  final ScreenRecipe recipe;
  final VoidCallback onMenuPressed;

  static const _kDefaultBackground = 'assets/images/paddock/wood_bk.jpg';

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(recipe.backgroundPath ?? _kDefaultBackground),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            recipe.title,
            style: context.headline5.textColor(Colors.white),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.sort),
            onPressed: onMenuPressed,
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.map_outlined),
              onPressed: () {},
            ),
          ],
        ),
        body: recipe.body,
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<ScreenRecipe>('recipe', recipe));
  }
}
