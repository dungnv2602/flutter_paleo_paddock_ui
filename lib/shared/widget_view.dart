import 'package:flutter/material.dart';

/// This Design Pattern comes from: https://blog.gskinner.com/archives/2020/02/flutter-widgetview-a-simple-separation-of-layout-and-logic.html

abstract class StatefulView<T1 extends StatefulWidget, T2 extends State<T1>>
    extends StatelessWidget {
  const StatefulView(this.state, {Key key}) : super(key: key);

  final T2 state;

  T1 get widget => state.widget;
}

abstract class StatelessView<T1> extends StatelessWidget {
  const StatelessView(this.widget, {Key key}) : super(key: key);

  final T1 widget;
}
