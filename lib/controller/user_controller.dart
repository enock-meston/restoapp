import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurentapp/api_connection/api_connection.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

import '../model/user_model.dart';

class UserController extends GetxController with StateMixin{
  var userList = <UserModel>[].obs;
  var isLoading = true.obs;
  var firstNameEditingController = TextEditingController().obs;
  var lastNameEditingController = TextEditingController().obs;
  // i see
  var emailEditingController = TextEditingController().obs;
  var phoneEditingController = TextEditingController().obs;


  @override
  void onInit() {
    fetchUserData().then((value) {
      firstNameEditingController.value.text =userList[0].fname!;
      lastNameEditingController.value.text =userList[0].lname!;
      emailEditingController.value.text =userList[0].email!;
      phoneEditingController.value.text =userList[0].phoneNumber!;
    });


    super.onInit();
  }



  //fetch user method

  Future<void> fetchUserData() async {

    change(null, status: RxStatus.loading());
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userID = prefs.getString('user_id');
    final response = await http.get(Uri.parse('${API.getUser}?id=$userID'));

    if(response.statusCode == 200){

      var jsonData = json.decode(response.body);
      print("my datta: ${jsonData[0]}");
      for(var i in jsonData){
        UserModel _userModel = UserModel.fromJson(i);
        userList.add(_userModel);

        // userList.add(UserModel(
        //   userId: _userModel.userId,
        //   fname: _userModel.fname,
        //   lname: _userModel.lname,
        //   phoneNumber: _userModel.phoneNumber,
        //   email: _userModel.email,
        //   username: _userModel.username,
        //   userType: _userModel.userType,
        //   password: _userModel.password,
        //   createdOn: _userModel.createdOn,
        //   updatedOn: _userModel.updatedOn,
        //   activeStatus: _userModel.activeStatus,
        // ));
      }
      isLoading.value = false;
      change(null, status: RxStatus.success());
      // update();
    }else {
      Get.snackbar('Error Loading data!',
          'Sever responded: ${response.statusCode}:${response.reasonPhrase.toString()}');
    }
  }


}
