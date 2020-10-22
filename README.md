# paleo_paddock_ui

![Gifs](assets/gifs/paleo_paddock_ui_cut.gif)

This is an attempt of evaluating several State Management approaches in tackling a UI implementation. I hope this will help you in choosing what to go with.

In this repo, I have gone through several, including:

1. InheritedWidget + ChangeNotifier
2. Provider + ChangeNotifier
3. Provider + StateNotifier
4. Cubit/Bloc
5. Riverpod (Thanks to [tbm98](https://github.com/tbm98) for his PRs on riverpod branch)
6. get_it + [get_it_mixin](https://pub.dev/packages/get_it_mixin) (Thanks to [escamoteur](https://github.com/escamoteur) for his PRs on get_it_mixin branch)
7. Provider + [WidgetView Pattern](https://blog.gskinner.com/archives/2020/02/flutter-widgetview-a-simple-separation-of-layout-and-logic.html)
8. [mvcs](https://pub.dev/packages/get_it_mixin) (experimenting)

You can check them out in different branches above.

## Credit

I wanna say thanks to [Stano Bagin](https://dribbble.com/staacopy) and his [design on dribble](https://dribbble.com/shots/2729372-Paleo-Paddock-ios-application-menu-animation) that this version took an inspiration from.
