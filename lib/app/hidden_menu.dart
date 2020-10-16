import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  OpenableCubit _openableNotifier;
  SelectedMenuIndexCubit _selectedIndexNotifier;

  @override
  void initState() {
    super.initState();
    _openableNotifier = OpenableCubit(vsync: this);
    _selectedIndexNotifier = SelectedMenuIndexCubit(initialIndex: 2);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => _openableNotifier,
        ),
        BlocProvider(
          create: (_) => _selectedIndexNotifier,
        ),
      ],
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

    final openable = context.bloc<OpenableCubit>();

    return ZoomScaffold(
      child: BlocBuilder<SelectedMenuIndexCubit, int>(
        builder: (_, selectedIndex) {
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

    final openable = context.bloc<OpenableCubit>();
    final selectedIndex = context.bloc<SelectedMenuIndexCubit>();

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
              initialSelected: selectedIndex.state,
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
