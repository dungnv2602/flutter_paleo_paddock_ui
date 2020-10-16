import 'package:bloc/bloc.dart';

class SelectedMenuIndexCubit extends Cubit<int> {
  SelectedMenuIndexCubit({int initialIndex}) : super(initialIndex ?? 0);

  void notifySelectedIndex(int value) {
    if (state == value) return;
    emit(value);
  }
}
