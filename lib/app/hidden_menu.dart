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
    // I think there are two ways to solve this problem,
    // first is to initialize the AnimationController and pass
    // it to the Provider, the child widgets will get
    // the Animation's data through the Provider.
    // The second is to Initialize AnimationController and pass
    // it directly to the Widgets that need data.

    // this implement just done to work, you can improve by split state/logic
    // to more providers, it's my idea :D
    context.read(openableProvider).initAnimation(
          controller: AnimationController(
            duration: const Duration(milliseconds: 600),
            reverseDuration: const Duration(milliseconds: 300),
            vsync: this,
          ),
        );

    super.initState();
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
    return Consumer(builder: (ctx, watch, child) {
      debugPrint('ZoomScaffoldScreen rebuild');

      final selectedIndex = watch(menuItemSelectedProvider).state;

      return ZoomScaffold(
          child: ScreenRecipeBuilder(
        recipe: restaurantScreens[selectedIndex],
        onMenuPressed: () {
          context.read(openableProvider).toggle();
        },
      ));
    });
  }
}

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (ctx, watch, child) {
        debugPrint('MenuScreen rebuild');
        final selectedIndex = watch(menuItemSelectedProvider).state;

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
                  animation: watch(openableProvider).animation,
                ),
                HiddenMenuItems(
                  controller: watch(openableProvider),
                  onItemSelected: (index) {
                    context.read(menuItemSelectedProvider).state = index;
                    context.read(openableProvider).toggle();
                  },
                  initialSelected: selectedIndex,
                  models: restaurantScreens
                      .map((screen) => HiddenMenuItemModel(title: screen.title))
                      .toList(growable: false),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
