import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:textstyle_extensions/textstyle_extensions.dart';

import '../shared/index.dart';

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
