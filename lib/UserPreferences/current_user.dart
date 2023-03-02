
import 'package:get/get.dart';
import 'package:restaurentapp/UserPreferences/user_preferences.dart';

import '../model/user.dart';

class CurrentUser extends GetxController{
  Rx<User> _currentUser = User('','').obs;

  User get user => _currentUser.value;

  getUserInfo() async{
    User? getUserInfoFromLocalStorage = await RememberUserPrefs.readUserInfo();
    _currentUser.value = getUserInfoFromLocalStorage!;
  }
}