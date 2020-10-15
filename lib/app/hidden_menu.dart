import 'package:flutter/material.dart';

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
  HiddenMenuNotifier _hiddenMenuNotifier;

  @override
  void initState() {
    super.initState();
    _hiddenMenuNotifier = HiddenMenuNotifier(
      vsync: this,
      initialIndex: 2,
    );
  }

  @override
  void dispose() {
    _hiddenMenuNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return HiddenMenuProvider(
      controller: _hiddenMenuNotifier,
      child: Stack(
        children: const [
          SafeArea(
            top: false,
            child: MenuScreen(),
          ),
          SafeArea(
            child: ZoomScaffoldScreen(),
          ),
        ],
      ),
    );
  }
}

class ZoomScaffoldScreen extends StatelessWidget {
  const ZoomScaffoldScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint('ZoomScaffoldScreen rebuild');

    final hiddenMenu = HiddenMenuProvider.of(context);
    final openable = hiddenMenu.openableChangeNotifier;
    final selectedIndex = hiddenMenu.selectedIndexNotifier;

    return ZoomScaffold(
      notifier: openable,
      child: ValueListenableBuilder<int>(
        valueListenable: selectedIndex,
        builder: (_, selectedIndex, __) {
          return ScreenRecipeBuilder(
            recipe: restaurantScreens[selectedIndex],
            onMenuPressed: openable.toggle,
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

    final hiddenMenu = HiddenMenuProvider.of(context);
    final openable = hiddenMenu.openableChangeNotifier;
    final selectedIndex = hiddenMenu.selectedIndexNotifier;

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
