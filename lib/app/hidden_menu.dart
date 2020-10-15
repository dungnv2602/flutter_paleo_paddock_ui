import 'package:flutter/material.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:provider/provider.dart';

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

    final openable = context.watch<OpenableStateNotifier>();

    return ZoomScaffold(
      child: StateNotifierBuilder<int>(
        stateNotifier: context.watch<SelectedMenuIndexNotifier>(),
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

    final openable = context.watch<OpenableStateNotifier>();
    final selectedIndex = context.watch<SelectedMenuIndexNotifier>();

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
              initialSelected: selectedIndex.state, // TODO: how to fix this?
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
