import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:restaurentapp/controller/user_controller.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../api_connection/api_connection.dart';

class EditFragment extends  GetView<UserController> {


  // user controller instance
  // UserController _userController = Get.put(UserController());

  init(){
    firstNameController.text = controller.userList[0].fname!;
    lastNameController.text = controller.userList[0].lname!;
    emailController.text = controller.userList[0].email!;
    phoneController.text = controller.userList[0].phoneNumber!;
  }

  //declare text editing controller
   TextEditingController firstNameController =TextEditingController();
   TextEditingController lastNameController =TextEditingController();
   TextEditingController emailController =TextEditingController();
  TextEditingController phoneController =TextEditingController();

  editUser() async{

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String myId = prefs.getString('user_id')!;

    // show a loading dialog
    // showDialog(
    //   context: context,
    //   builder: (context) {
    //     return const Center(
    //       child: CircularProgressIndicator(),
    //     );
    //   },
    // );

    try{
      var res= await http.post(
        Uri.parse("${API.editProfile}?myid=$myId"),
        body: {
          "fname": firstNameController.text,
          "lname": lastNameController.text,
          "email": emailController.text,
          "phone_number": phoneController.text,
        },

      );

      if(res.statusCode == 200){ // from flutter app the connection with API to server --- success
        var resBodyOfSignUp = jsonDecode(res.body);

        if(resBodyOfSignUp['success'] == true){
          Fluttertoast.showToast(msg: "Congratulations, Your Data are Successfully Updated");
        }else{
          Fluttertoast.showToast(msg: "Error Occurred, Try Again !");
        }
        //to stop showDialog from showing
      }
    }catch(e){
      print(e.toString());
      Fluttertoast.showToast(msg:  "${e.toString()} Error in catch register ");
    }
  }

  @override
  Widget build(BuildContext context) {
    init();
    //get user data from user controller
    // firstNameController.text = _userController.userList[0].fname!;
    // lastNameController.text = _userController.userList[0].lname!;
    // emailController.text = _userController.userList[0].email!;
    // phoneController.text = _userController.userList[0].phoneNumber!;

    return controller.obx(
            (state) {
              return Scaffold(
                appBar: AppBar(
                  title: const Text("Edit Profile"),
                ),
                body: GetX<UserController>(
                  // () =>
                  //   _userController.isLoading.value
                  //       ? const Center(
                  //     child: CircularProgressIndicator(),
                  //   )
                  //
                  //       :
                    builder: (context)=> SingleChildScrollView(
                      child: Center(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    "Edit Profile",
                                    style: TextStyle(
                                      fontSize: 20.0,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 100,
                                  height: 100,
                                  child: Image.asset('images/607399.png'),
                                ),
                                const SizedBox(
                                  height: 20.0,
                                ),
                                TextFormField(
                                  controller: controller.firstNameEditingController.value,
                                  decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.person),
                                    border: OutlineInputBorder(),
                                  ),
                                  // initialValue: controller.userList[0].fname??"",
                                  onChanged: (value) {
                                    controller.userList[0].fname = value;
                                  },
                                ),

                                const SizedBox(
                                  height: 20.0,
                                ),
                                TextFormField(
                                  controller: controller.lastNameEditingController.value,
                                  decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.person),
                                    border: OutlineInputBorder(),
                                  ),
                                  // initialValue: controller.userList[0].lname,
                                  onChanged: (value) {
                                    controller.userList[0].lname = value;
                                  },
                                ),
                                const SizedBox(
                                  height: 20.0,
                                ),
                                TextFormField(
                                  controller: controller.emailEditingController.value,
                                  decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.email),
                                    border: OutlineInputBorder(),
                                  ),
                                  // initialValue: controller.userList[0].email,
                                  onChanged: (value) {
                                    controller.userList[0].email = value;
                                  },
                                ),
                                const SizedBox(
                                  height: 20.0,
                                ),
                                TextFormField(
                                  controller: controller.phoneEditingController.value,
                                  decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.phone),
                                    border: OutlineInputBorder(),
                                  ),
                                  // initialValue: controller.userList[0].phoneNumber,
                                  onChanged: (value) {
                                    controller.userList[0].phoneNumber = value;
                                  },
                                ),
                                const SizedBox(
                                  height: 20.0,
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    //edit user method
                                    editUser();
                                  },
                                  child: const Text("Edit"),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                ),
              );
            },onLoading:const Center(child: CircularProgressIndicator(),));
  }
}

//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../controller/user_controller.dart';
//
// class OtherClass extends GetView<UserController> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//
//       body: controller.obx(
//             (state)=>Text(state.name),
//
//         // here you can put your custom loading indicator, but
//         // by default would be Center(child:CircularProgressIndicator())
//         onLoading: Center(child: CircularProgressIndicator()),
//         onEmpty: Text('No data found'),
//
//         // here also you can set your own error widget, but by
//         // default will be an Center(child:Text(error))
//         onError: (error)=>Text(error),
//       ),
//     );
//   }