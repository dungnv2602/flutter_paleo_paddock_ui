import 'package:flutter/material.dart';
import 'package:get_it_mixin/get_it_mixin.dart';

import '../data.dart';
import '../widgets/index.dart';
import 'menu_items.dart';
import 'notifiers/index.dart';
import 'zoom_scaffold.dart';

class HiddenMenu extends StatefulWidget with GetItStatefulWidgetMixin {
  HiddenMenu({Key key}) : super(key: key);

  @override
  _HiddenMenuState createState() => _HiddenMenuState();
}

class _HiddenMenuState extends State<HiddenMenu>
    with TickerProviderStateMixin, GetItStateMixin {
  @override
  Widget build(BuildContext context) {
    pushScope(
        init: (sl) => sl.registerSingleton(
            HiddenMenuNotifier(
              vsync: this,
              initialIndex: 1,
            ),
            dispose: (HiddenMenuNotifier x) => x.dispose()));

    return Stack(
      children: [
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

class ZoomScaffoldScreen extends StatelessWidget with GetItMixin {
  ZoomScaffoldScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint('ZoomScaffoldScreen rebuild');

    final selectedIndex =
        watchX((HiddenMenuNotifier x) => x.selectedIndexNotifier);
    final openable = get<HiddenMenuNotifier>().openableChangeNotifier;

    return ZoomScaffold(
      notifier: openable,
      child: ScreenRecipeBuilder(
        recipe: restaurantScreens[selectedIndex],
        onMenuPressed: openable.toggle,
      ),
    );
  }
}

class MenuScreen extends StatelessWidget with GetItMixin {
  MenuScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint('MenuScreen rebuild');

    final openable = get<HiddenMenuNotifier>().openableChangeNotifier;
    final selectedIndex = get<HiddenMenuNotifier>().selectedIndexNotifier;

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
                selectedIndex.value = index;
                openable.toggle();
              },
              initialSelected: selectedIndex.value,
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
