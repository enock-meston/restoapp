import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../api_connection/api_connection.dart';
import '../../model/user.dart';
import 'login_screen.dart';

class SingUpScreen extends StatefulWidget {
  @override
  State<SingUpScreen> createState() => _SingUpScreenState();
}

class _SingUpScreenState extends State<SingUpScreen> {
  // form key declaration
  var formKey = GlobalKey<FormState>();
  //text field controllers
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var isObsecure = true.obs;

  validateUserEmail() async {

    try{
      // var url = "http://192.168.1.64/api_clothes_store/user/validate_email.php";
      var res= await http.post(
        Uri.parse(API.validateEmail),
        body: {
          'user_email': emailController.text.trim(),
        },
      );

      if(res.statusCode == 200){ // from flutter app the connection with API to server --- success
        var resBodyOfValidateEmail=jsonDecode(res.body);
        if(resBodyOfValidateEmail['emailFound'] == true){ //success is true // record is exist
          Fluttertoast.showToast(msg: "Email is already in Someone else use. try another email");
        }else{
          // register & save new user record to the database
          registerAndSaveUserRecord();
        }
      }
    }catch(e){
      print(e.toString());
      Fluttertoast.showToast(msg: "${e.toString()} Error in catch validateEmail");
    }
  }

  registerAndSaveUserRecord() async {
    // show a loading dialog
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    User userModel = User(
      emailController.text.trim(),
      passwordController.text.trim(),
    );

    try{
      var res= await http.post(
        Uri.parse(API.signUp),
        body: userModel.toJson(),

      );

      if(res.statusCode == 200){ // from flutter app the connection with API to server --- success
        var resBodyOfSignUp = jsonDecode(res.body);

        if(resBodyOfSignUp['success'] == true){
          Fluttertoast.showToast(msg: "Congratulations, You are SignUp Successfully");
          //clear textField after data successfully added
          setState(() {
            emailController.clear();
            passwordController.text = "";
          });

        }else{
          Fluttertoast.showToast(msg: "Error Occurred, Try Again !");
        }
        //to stop showDialog from showing
        Navigator.of(context).pop();
      }
    }catch(e){
      print(e.toString());
      Fluttertoast.showToast(msg:  "${e.toString()} Error in catch register ");
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
                      height: 250,
                      child: Image.asset("images/logo.png", height: 10.0,),
                    ),
                    const SizedBox(height: 18,),
                    Text("New Account Here", style: TextStyle(color: Colors.white, fontSize: 30, ),),
                    const SizedBox(height: 18,),
                    // signup screen form
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.white24,
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
                            padding: const EdgeInsets.fromLTRB(30.0,30.0,30.0,8.0),
                            child: Column(
                              children: [
                                //email - password - login btn
                                Form(
                                  key: formKey,
                                  child: Column(
                                    children: [
                                      const SizedBox(height: 18,),
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

                                      const SizedBox(height: 18,),
                                      //password
                                      Obx(() => TextFormField(
                                        controller: passwordController,
                                        obscureText: isObsecure.value,
                                        validator: (val) =>
                                        val == "" ? "Please write Password" : null,
                                        decoration: InputDecoration(
                                          prefixIcon: const Icon(
                                            Icons.vpn_key_sharp,
                                            color: Colors.black,
                                          ),
                                          suffixIcon: Obx(()=>GestureDetector(
                                            onTap: (){
                                              isObsecure.value = !isObsecure.value;
                                            },
                                            child: Icon(
                                              isObsecure.value ? Icons.visibility_off : Icons.visibility,
                                              color: Colors.black,
                                            ),
                                          ),),
                                          hintText: "Password ...",
                                          label: const Text(
                                            "Password",
                                            style: TextStyle(
                                              color: Colors.black,
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

                                      ),),

                                      const SizedBox(height: 18,),

                                      //button
                                      Material(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.circular(30),
                                        child: InkWell(
                                          onTap: (){
                                            if(formKey.currentState!.validate()){
                                              //validate the email
                                              validateUserEmail();
                                            }
                                          },
                                          borderRadius: BorderRadius.circular(30),
                                          child: const Padding(
                                            padding: EdgeInsets.symmetric(
                                              vertical: 10,
                                              horizontal: 28,
                                            ),
                                            child: Text("Add Me",
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

                                const SizedBox(height: 16.0,),
                                // Already have  account and register btn
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text("Already have an Account?",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    TextButton(
                                      onPressed: (){
                                        Get.to(Login_Screen());
                                       },
                                      child: const Text(
                                        "Click to LogIn ",
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