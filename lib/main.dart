import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:restaurentapp/user/authentication/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'UserPreferences/user_preferences.dart';
import 'screens/home_fragment.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // SharedPreferences prefs = await SharedPreferences.getInstance();
  // String? user_id = prefs.getString("user_id");
  // print("my user id Login is $user_id");
  runApp(GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Restaurant App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder(
        future: RememberUserPrefs.readUserInfo(),
        builder: (context, dataSnapshot) {
          if(dataSnapshot.data == null){
            return Login_Screen();
          } else {
            return HomeFragment();
          }
        },
      )));
}
