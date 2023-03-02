import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:restaurentapp/api_connection/api_connection.dart';
import 'package:restaurentapp/model/product_model.dart';

class ProductController extends GetxController {
  var photoList = <AlbumModel>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAlbumData();
  }

  Future<void> fetchAlbumData() async {
    final response = await http
        .get(Uri.parse(API.getProduct));
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      // print( "data are : ${jsonData[0]} ");

      for(var i in jsonData){
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
            unitId: _albumModel.unitId, // yes // one so can you please fetch it ib ==n card please as list mean?
          ),
        );
      }
      isLoading.value = false;
      update();
    } else {
      Get.snackbar('Error Loading data!',
          'Sever responded: ${response.statusCode}:${response.reasonPhrase.toString()}');
    }
  }

}
