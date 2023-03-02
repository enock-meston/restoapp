import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:restaurentapp/UserPreferences/current_user.dart';
import 'package:restaurentapp/controller/user_controller.dart';
import 'package:restaurentapp/screens/fragments/edit_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../UserPreferences/user_preferences.dart';
import '../../api_connection/api_connection.dart';
import '../../user/authentication/login_screen.dart';

class UserProfile extends StatelessWidget {

  final CurrentUser _currentUser = Get.put(CurrentUser());
  UserController _userController = Get.put(UserController());

  //logout
  signOutUser() async {
    var resultResponce = await Get.dialog(
      AlertDialog(
        backgroundColor: Colors.grey,
        title: const Text(
          "Logout",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: const Text(
          "Are you Sure?\nYou Want to logout from app?",
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text(
              "No",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Get.back(result: "loggedOut");
            },
            child: const Text(
              "Yes",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
    if (resultResponce == "loggedOut") {

      //  delete or remove user data from phone local storage
      RememberUserPrefs.removeUserInfo().then((value) {
        Get.offAll(Login_Screen());
      });
    }
  }

  Widget userInfoItemProfile(IconData iconData, String userData) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: Row(
        children: [
          Icon(
            iconData,
            size: 30,
            color: Colors.black,
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            userData,
            style: const TextStyle(
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Profile"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return EditFragment();
                  },
                ),
              );
            },
            icon: Icon(Icons.edit),
          ),
          IconButton(
            onPressed: () {
              signOutUser();
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: Scaffold(
        body: ListView(
          children: [
            Image.asset('images/607399.png', width: 240, height: 200),
            const SizedBox(height: 20),
            Center(
              child: Card(
                elevation: 50,
                shadowColor: Colors.black,
                color: Colors.white54,
                child: SizedBox(
                  width: 300,
                  height: 370,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child:ListView.builder(
                      itemCount: 1,
                      itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: [
                          userInfoItemProfile(Icons.person, "${_userController.userList[index].fname!} ${_userController.userList[index].lname!}"),
                          const SizedBox(height: 20),
                          userInfoItemProfile(Icons.email, _userController.userList[index].email!),
                          const SizedBox(height: 20),
                          userInfoItemProfile(Icons.phone, _userController.userList[index].phoneNumber!),
                          const SizedBox(height: 20),
                          userInfoItemProfile(Icons.merge_type, _userController.userList[index].userType!),
                        ],
                      );
                    },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
