import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import "package:http/http.dart" as http;
import 'package:restaurentapp/common/navigaton_drawer.dart';
import 'package:restaurentapp/user/authentication/sign_up_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../UserPreferences/user_preferences.dart';
import '../../api_connection/api_connection.dart';
import '../../model/user.dart';
import '../../screens/home_fragment.dart';


class Login_Screen extends StatelessWidget {
  // form key declaration
  var formKey = GlobalKey<FormState>();

  //text field controllers
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var isObsecure = true.obs;

  loginUserNow() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try{
      var res= await http.post(
        Uri.parse(API.login),
        body: {
          'user_email': emailController.text.trim(),
          'user_password': passwordController.text.trim(),
        },
      );

      if(res.statusCode == 200){ // from flutter app the connection with API to server --- success

        var resBodyOfLogin = jsonDecode(res.body);
        if(resBodyOfLogin['success'] == true){
          prefs.setString("user_email", resBodyOfLogin['userData']['email'].toString());
          prefs.setString("user_id", resBodyOfLogin['userData']['user_Id'].toString());
          User userInfo = User.fromJson(resBodyOfLogin["userData"]); // this comes from user.dart as model

          // save userInfo to local Storage using shared Preferences
          await RememberUserPrefs.storeUserInfo(userInfo);
          //  send user to the main screen
          //  if i want to add some delay of two or three seconds do this

          Future.delayed(Duration(microseconds: 20000),(){
            Get.off(HomeFragment());
          });
          Fluttertoast.showToast(msg: "You are Logged in Successfully");

        }else if(resBodyOfLogin['successPassword'] == true){
          Fluttertoast.showToast(msg: "Please Write Correct Password.\n Try Again !");
        }
        else{
          Fluttertoast.showToast(msg: "Please Write Correct email.\n Try Again !");
        }
      }else{
        Fluttertoast.showToast(msg: "Something went wrong");
      }

    }catch(errorMsg){
      print("Error ::" + errorMsg.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: LayoutBuilder(builder: (context, cons) {
          return ConstrainedBox(
            constraints: BoxConstraints(maxHeight: cons.maxHeight),
            child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 285,
                      child: Image.asset("images/logo.png", height: 10.0,),
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    // loging screen form
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.white54,
                            borderRadius: BorderRadius.all(
                              Radius.circular(60),
                            ),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 8,
                                color: Colors.black26,
                                offset: Offset(0, -3),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 8.0),
                            child: Column(
                              children: [
                                //email - password - login btn
                                Form(
                                  key: formKey,
                                  child: Column(
                                    children: [
                                      //email
                                      TextFormField(
                                        controller: emailController,
                                        validator: (val) =>
                                        val == "" ? "Please write Email" : null,
                                        decoration: InputDecoration(
                                          prefixIcon: const Icon(
                                            Icons.email,
                                            color: Colors.black,
                                          ),
                                          hintText: "email ...",
                                          label: const Text(
                                            "Email",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18,
                                            ),
                                          ),
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(10),
                                              borderSide: const BorderSide(
                                                color: Colors.white60,
                                              )),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(10),
                                              borderSide: const BorderSide(
                                                color: Colors.white60,
                                              )),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(10),
                                              borderSide: const BorderSide(
                                                color: Colors.white60,
                                              )),
                                          disabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(10),
                                              borderSide: const BorderSide(
                                                color: Colors.white60,
                                              )),
                                          contentPadding: const EdgeInsets.symmetric(
                                            horizontal: 14,
                                            vertical: 6,
                                          ),
                                          fillColor: Colors.white,
                                          filled: true,
                                        ),
                                      ),

                                      const SizedBox(
                                        height: 18,
                                      ),
                                      //password
                                      Obx(
                                            () => TextFormField(
                                          controller: passwordController,
                                          obscureText: isObsecure.value,
                                          validator: (val) => val == ""
                                              ? "Please write Password"
                                              : null,
                                          decoration: InputDecoration(
                                            prefixIcon: const Icon(
                                              Icons.vpn_key_sharp,
                                              color: Colors.black,
                                            ),
                                            suffixIcon: Obx(
                                                  () => GestureDetector(
                                                onTap: () {
                                                  isObsecure.value =
                                                  !isObsecure.value;
                                                },
                                                child: Icon(
                                                  isObsecure.value
                                                      ? Icons.visibility_off
                                                      : Icons.visibility,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                            hintText: "Password ...",
                                            label: const Text(
                                              "Password",
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                              ),
                                            ),
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                BorderRadius.circular(10),
                                                borderSide: const BorderSide(
                                                  color: Colors.white60,
                                                )),
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                BorderRadius.circular(10),
                                                borderSide: const BorderSide(
                                                  color: Colors.white60,
                                                )),
                                            focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                BorderRadius.circular(10),
                                                borderSide: const BorderSide(
                                                  color: Colors.white60,
                                                )),
                                            disabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                BorderRadius.circular(10),
                                                borderSide: const BorderSide(
                                                  color: Colors.white60,
                                                )),
                                            contentPadding:
                                            const EdgeInsets.symmetric(
                                              horizontal: 14,
                                              vertical: 6,
                                            ),
                                            fillColor: Colors.white,
                                            filled: true,
                                          ),
                                        ),
                                      ),

                                      const SizedBox(
                                        height: 18,
                                      ),

                                      //button
                                      Material(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.circular(30),
                                        child: InkWell(
                                          onTap: () {
                                            if (formKey.currentState!.validate()) {
                                              loginUserNow();
                                            }

                                          },
                                          borderRadius: BorderRadius.circular(30),
                                          child: const Padding(
                                            padding: EdgeInsets.symmetric(
                                              vertical: 10,
                                              horizontal: 28,
                                            ),
                                            child: Text(
                                              "Login",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                const SizedBox(
                                  height: 16.0,
                                ),
                                // don't have an account and register btn
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "Don't have an Account?",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Get.to(SingUpScreen());
                                      },
                                      child: const Text(
                                        "Register Here",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )),
                    ),
                    // end of login form
                  ],
                )),
          );
        }),
      ),
    );
  }
}