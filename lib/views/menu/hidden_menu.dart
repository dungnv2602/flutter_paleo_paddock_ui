import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../app_extensions.dart';
import '../widgets/_widgets.dart';
import 'menu_items.dart';
import 'menu_title.dart';
import 'zoom_scaffold.dart';
import '../../models/_models.dart';
import '../../commands/_commands.dart';

class HiddenMenu extends StatefulWidget {
  const HiddenMenu({Key key}) : super(key: key);

  @override
  _HiddenMenuState createState() => _HiddenMenuState();
}

class _HiddenMenuState extends State<HiddenMenu> with TickerProviderStateMixin, 
  AutomaticKeepAliveClientMixin

 {
  OpenableController _openableController;
  SelectedMenuIndexNotifier _selectedIndex;

  @override
  void initState() {
    super.initState();
    _openableController = OpenableController(vsync: this);
    _selectedIndex = SelectedMenuIndexNotifier(initialIndex: 2);
  }

  @override
  void dispose() {
    _openableController.dispose();
    _selectedIndex.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Provider.value(
      value: this,
      child: _HiddenMenuView(this),
    );
  }
}

class _HiddenMenuView extends StatefulView<HiddenMenu, _HiddenMenuState> {
  const _HiddenMenuView(_HiddenMenuState state, {Key key})
      : super(state, key: key);

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

    final state = context.watch<_HiddenMenuState>();
    final openable = state._openableController;

    return ZoomScaffold(
      notifier: openable,
      child: ValueListenableBuilder<int>(
        valueListenable: state._selectedIndex,
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

    final state = context.watch<_HiddenMenuState>();
    final openable = state._openableController;
    final selectedIndex = state._selectedIndex;

    final isSignedIn =
        context.select<UserModel, bool>((user) => user.isSignedIn);

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
              models: getRestaurantScreenRecipes(isSignedIn: isSignedIn)
                  .map((screen) => HiddenMenuItemModel(title: screen.title))
                  .toList(growable: false),
            ),
          ],
        ),
      ),
    );
  }
}
