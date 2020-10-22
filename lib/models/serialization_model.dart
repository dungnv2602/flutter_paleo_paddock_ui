import 'package:flutter/foundation.dart';

abstract class SerializationModel extends ChangeNotifier {
  Map<String, dynamic> toJson() {
    // This should be over-ridden in concrete class to enable serialization
    throw UnimplementedError();
  }

  dynamic copyFromJson(Map<String, dynamic> json) {
    // This should be over-ridden in concrete class to enable serialization
    throw UnimplementedError();
  }

  List<T> toList<T>(dynamic json, Function(dynamic) fromJson) {
    final List<T> list = (json as Iterable<T>)?.map<T>((e) {
      return e == null ? null : fromJson(e) as T;
    })?.toList();
    return list;
  }
}
