
import 'dart:convert';

import 'package:get/get.dart';
import 'package:restaurentapp/api_connection/api_connection.dart';

import '../model/category_model.dart';
import 'package:http/http.dart' as http;

class CategoryController extends GetxController {
  var categoryList = <CategoryModel>[].obs;
  var loading = false.obs;


  @override
  void onInit() {
    super.onInit();
    fetchCategory();
  }

  void fetchCategory() async {
    loading.value = true;
    var response = await http.get(Uri.parse(API.getCategories));
    // print( "category data are : ${response.body} ");
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);


      for(var i in jsonData){

        CategoryModel _categoryModel = CategoryModel.fromJson(i);
        categoryList.add(
            _categoryModel
        );
        loading.value = false;
      }
    }
  }
}