import 'package:get/get.dart';

import '../model/table_model.dart';
import '../api_connection/api_connection.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TableController extends GetxController{

  var tableList = <TableModel>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchTableData();
  }

  Future<void> fetchTableData() async {
    final response = await http
        .get(Uri.parse(API.getTables));
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      // print( "data are : ${jsonData[0]} ");

      for(var i in jsonData){
        TableModel _tableModel = TableModel.fromJson(i);
        tableList.add(
          TableModel(
            tabId: _tableModel.tabId,
            tabReference: _tableModel.tabReference,
            title: _tableModel.title,
            tabLocation: _tableModel.tabLocation,
            tabInformation: _tableModel.tabInformation,
            tabStatus: _tableModel.tabStatus,
            createdOn: _tableModel.createdOn,
            udatedOn: _tableModel.udatedOn,
            addedBy: _tableModel.addedBy,
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