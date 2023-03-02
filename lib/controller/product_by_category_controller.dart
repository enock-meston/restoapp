import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:restaurentapp/api_connection/api_connection.dart';
import 'package:restaurentapp/model/product_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductBYCategoryController extends GetxController {
  var photoList = <AlbumModel>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
  }

  // get data by cat id

  Future<void> fetchProductDataByCat(int id) async {
    print('fetchProduct function is called');
    final response = await http
        .get(Uri.parse('${API.getProductByCategory}?categoryId=$id'));
    if (response.statusCode == 200) {
      // print('status code is '+response.statusCode.toString());
      var jsonData = json.decode(response.body);
      // print( "data are : ${jsonData} ");
      for (var i in jsonData) {
        AlbumModel _albumModel = AlbumModel.fromJson(i);
        photoList.add(
          AlbumModel(
            addedBy: _albumModel.addedBy,
            buyingPrice: _albumModel.buyingPrice,
            categoryId: _albumModel.categoryId,
            createdOn: _albumModel.createdOn,
            discountedPrice: _albumModel.discountedPrice,
            discription: _albumModel.discription,
            price: _albumModel.price,
            preparationTime: _albumModel.preparationTime,
            productId: _albumModel.productId,
            productImagePath: _albumModel.productImagePath,
            productReference: _albumModel.productReference,
            productStatus: _albumModel.productStatus,
            productTitle: _albumModel.productTitle,
            udatedOn: _albumModel.udatedOn,
            unitId: _albumModel
                .unitId, // yes // one so can you please fetch it ib ==n card please as list mean?
          ),
        );
      }


      isLoading.value = false;
      update();
    } else {
      Get.snackbar('Error Loading data!',
          'Sever responded: ${response.statusCode}:${response.reasonPhrase
              .toString()}');
    }
  }


  MakeRequestMethod(String ProId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print('make request method is called with product id ' + ProId);

    var resultResponce = await Get.dialog(
        AlertDialog(
          title: Text('Make Request'),
          content: Text(
              'Are you sure you want to make request for this product?'),
          actions: [
            TextButton(
              onPressed: () {
                Get.back(result: true);
              },
              child: Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Get.back(result: false);
              },
              child: Text('No'),
            ),
          ],
        )
    );
    if (resultResponce == true) {
      // print('yes is pressed');
      // make request

      // get user id
      String? userId = prefs.getString('user_id');
      // print('user id is ' + userId.toString());
      final response = await http.post(
          Uri.parse('${API.makeQuickOrder}'),
          body: {
            'productId': ProId,
            'userId': userId.toString(),
          }
      );

      if (response.statusCode == 200) {
        var ResponseDataOfInsert = jsonDecode(response.body);
        if (ResponseDataOfInsert['success'] == true) {
          Get.snackbar('Success', 'Request is sent successfully');
          print('request is sent successfully');
        } else {
          Get.snackbar('Error', 'Request is not sent');
          print('request is not sent');
        }
      }
    }
  }
}