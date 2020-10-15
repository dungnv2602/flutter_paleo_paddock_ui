import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data.dart';
import '../widgets/index.dart';
import 'menu_items.dart';
import 'openable_change_notifier.dart';
import 'selected_menu_index_notifier.dart';
import 'zoom_scaffold.dart';

class HiddenMenu extends StatefulWidget {
  const HiddenMenu({Key key}) : super(key: key);

  @override
  _HiddenMenuState createState() => _HiddenMenuState();
}

class _HiddenMenuState extends State<HiddenMenu> with TickerProviderStateMixin {
  OpenableChangeNotifier _openableNotifier;
  SelectedMenuIndexNotifier _selectedIndexNotifier;

  @override
  void initState() {
    super.initState();
    _openableNotifier = OpenableChangeNotifier(vsync: this);
    _selectedIndexNotifier = SelectedMenuIndexNotifier(initialIndex: 2);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<OpenableChangeNotifier>(
          create: (_) => _openableNotifier,
        ),
        ChangeNotifierProvider<SelectedMenuIndexNotifier>(
          create: (_) => _selectedIndexNotifier,
        ),
      ],
      builder: (_, __) {
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
      },
    );
  }
}

class ZoomScaffoldScreen extends StatelessWidget {
  const ZoomScaffoldScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint('ZoomScaffoldScreen rebuild');

    // TODO: why can't do this?
    // final openable = context.read<OpenableChangeNotifier>();

    // while this work?
    final openable =
        Provider.of<OpenableChangeNotifier>(context, listen: false);

    return ZoomScaffold(
      child: Consumer<SelectedMenuIndexNotifier>(
        builder: (_, selectedIndex, __) {
          return ScreenRecipeBuilder(
            recipe: restaurantScreens[selectedIndex.value],
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

    // while this work?
    final openable =
        Provider.of<OpenableChangeNotifier>(context, listen: false);

    // TODO: why can't do this?
    // final selectedIndex = context.read<SelectedMenuIndexNotifier>();

    // while this work?
    final selectedIndex =
        Provider.of<SelectedMenuIndexNotifier>(context, listen: false);

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
