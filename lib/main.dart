import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:statsfl/statsfl.dart';

import 'commands/abstract_command.dart' as commands;
import 'models/_models.dart';
import 'models/abstract_model.dart' as models;
import 'services/_services.dart';
import 'views/menu/hidden_menu.dart';

// design: https://dribbble.com/shots/2729372-Paleo-Paddock-ios-application-menu-animation

void main() {
  runApp(
    StatsFl(
      isEnabled: true, //Toggle on/off
      width: 100, //Set size
      height: 30, //
      // maxFps: 90, // Support custom FPS target (default is 60)
      showText: true, // Hide text label
      sampleTime: 0.5, //Interval between fps calculations, in seconds.
      totalTime: 15, //Total length of timeline, in seconds.
      align: Alignment.topLeft, //Alignment of statsbox
      child: const Setup(),
    ),
  );
}

class Setup extends StatefulWidget {
  const Setup({Key key}) : super(key: key);

  @override
  _SetupState createState() => _SetupState();
}

class _SetupState extends State<Setup> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext _) {
    return MultiProvider(
      providers: [
        // models
        ChangeNotifierProvider(create: (_) => AppModel()),
        ChangeNotifierProvider(create: (_) => UserModel()),
        ChangeNotifierProvider(create: (_) => RestaurantModel()),
        ChangeNotifierProvider(
          create: (_) => MenuModel(vsync: this, initialMenuIndex: 2),
        ),

        // services
        Provider(create: (_) => UserService()),
        Provider(create: (_) => RestaurantService()),
      ],
      child: Builder(
        builder: (context) {
          // Save a context our Commands/Models can use to access provided Models and Services
          commands.init(context);
          models.init(context);
          return const MainApp();
        },
      ),
    );
  }
}

class MainApp extends StatelessWidget {
  const MainApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      theme: ThemeData(
        textTheme: GoogleFonts.bebasNeueTextTheme(),
      ),
      home: const HiddenMenu(),
    );
  }
}
