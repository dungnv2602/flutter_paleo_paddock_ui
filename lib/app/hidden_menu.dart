import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data.dart';
import '../widgets/index.dart';
import 'menu_items.dart';
import 'notifiers/index.dart';
import 'zoom_scaffold.dart';

class HiddenMenu extends StatefulWidget {
  const HiddenMenu({Key key}) : super(key: key);

  @override
  _HiddenMenuState createState() => _HiddenMenuState();
}

class _HiddenMenuState extends State<HiddenMenu> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    context.read(openableProvider).vsync(this);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: const [
        SafeArea(
          top: false,
          child: MenuScreen(),
        ),
        SafeArea(
          child: ZoomScaffoldScreen(),
        ),
      ],
    );
  }
}

class ZoomScaffoldScreen extends StatelessWidget {
  const ZoomScaffoldScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint('ZoomScaffoldScreen rebuild');

    return ZoomScaffold(
      child: Consumer(
        builder: (context, watch, child) {
          debugPrint('ScreenRecipeBuilder rebuild');

          return ScreenRecipeBuilder(
            recipe: restaurantScreens[watch(selectedMenuIndexNotifier.state)],
            onMenuPressed: () {
              context.read(openableProvider).toggle();
            },
          );
        },
      ),
    );
  }
}

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint('MenuScreen rebuild');

    final openable = context.read(openableProvider);
    final selectedIndex = context.read(selectedMenuIndexNotifier);

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/paddock/dark_grunge_bk.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: Column(
          children: [
            MenuTitle(
              animation: openable.animation,
            ),
            HiddenMenuItems(
              controller: openable,
              onItemSelected: (index) {
                selectedIndex.notifySelectedIndex(index);
                openable.toggle();
              },
              initialSelected: context.read(selectedMenuIndexNotifier.state),
              models: restaurantScreens
                  .map((screen) => HiddenMenuItemModel(title: screen.title))
                  .toList(growable: false),
            ),
          ],
        ),
      ),
    );
  }
}
