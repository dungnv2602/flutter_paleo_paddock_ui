import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:statsfl/statsfl.dart';

import 'app/hidden_menu.dart';

// design: https://dribbble.com/shots/2729372-Paleo-Paddock-ios-application-menu-animation

void main() {
  runApp(StatsFl(
    isEnabled: true, //Toggle on/off
    width: 100, //Set size
    height: 30, //
    // maxFps: 90, // Support custom FPS target (default is 60)
    showText: true, // Hide text label
    sampleTime: 0.5, //Interval between fps calculations, in seconds.
    totalTime: 15, //Total length of timeline, in seconds.
    align: Alignment.topLeft, //Alignment of statsbox
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
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
