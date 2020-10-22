import 'package:time/time.dart';
import 'package:uuid/uuid.dart';

import 'models/_models.dart';

class UserService {
  Future<User> login(String name, String pass) async {
    // Fake a network service call, and return true
    await Future<void>.delayed(1.seconds);
    // for demo purpose only, in reality this will be achieved from json conversion
    return User(
      id: Uuid().v4(),
      name: name,
    );
  }

}

