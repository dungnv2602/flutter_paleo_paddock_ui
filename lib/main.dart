import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app/hidden_menu.dart';

// design: https://dribbble.com/shots/2729372-Paleo-Paddock-ios-application-menu-animation

void main() => runApp(MyApp());

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
