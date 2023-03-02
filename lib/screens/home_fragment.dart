import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:restaurentapp/api_connection/api_connection.dart';
import 'package:restaurentapp/common/navigaton_drawer.dart';
import '../UserPreferences/current_user.dart';
import '../controller/product_controller.dart';

class HomeFragment extends StatelessWidget {
  CurrentUser _rememberUser = Get.put(CurrentUser());

  //instance of the controller

  ProductController _productController = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: CurrentUser(),
        initState: (currentState) {
          _rememberUser.getUserInfo();
        },
        builder: (controller) {
          return Scaffold(
            drawer: Navigation_Drawer(),
            appBar: AppBar(
              title: const Text('Home'),
            ),
            body: Card(
              child: Obx(
                () => _productController.isLoading.value
                    ? const CircularProgressIndicator()
                    : GridView.builder(
                        itemCount: _productController.photoList.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio:
                              1, //okay? yes it's done i like it thank  // Adjust this to match your element aspect ratio
                        ),
                        itemBuilder: (BuildContext context, int i) {
                          // print("=================http://192.168.1.64/restoweb/userAd/${_productController.photoList[i].productImagePath}");
                          return Card(
                            child: SizedBox(
                              // height: 100.0,
                              // width: 100.0,
                              child: Column(
                                children: [
                                  InkWell(
                                    onTap: (){
                                      // Get.toNamed('/product_details',arguments: _productController.photoList[i].productId);
                                    print('Product id Clicked is: ${_productController.photoList[i].productId}');
                                    },
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10)),
                                      child: Image.network(
                                        "${API.hostAdmin}${_productController.photoList[i].productImagePath}",
                                        //image is not good
                                        height: 140.0,
                                        width: 140.0,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    _productController
                                        .photoList[i].productTitle!,
                                    style: const TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    '${_productController.photoList[i].price!}\$',
                                    style: const TextStyle(
                                      color: Colors.blue,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
              ),
            ),
          );
        });
  }
}
