import 'abstract_command.dart';
import 'restaurant_commands.dart';

class LoginCommand with AbstractCommand {
  Future<bool> execute(String name, String pass) async {
    // Await some service call
    final user = await userService.login(name, pass);

    final loginSuccess = user != null;

    if (loginSuccess) {
      userModel.currentUser = user;
      // get user's liked restaurants
      await GetLikedRestaurantsCommand().execute(user);
    } else {
      // show error command
    }

    return loginSuccess;
  }
}
