

import 'package:get/get.dart';

import '../model/location_model.dart';
import '../api_connection/api_connection.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class LocationController extends GetxController {
 var locationList = <LocationModel>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchLocationData();
  }

  Future<void> fetchLocationData() async {
    final response = await http
        .get(Uri.parse(API.getLocations));
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      // print( "data are : ${jsonData[0]} ");

      for(var i in jsonData){
        LocationModel _locationModel = LocationModel.fromJson(i);
        locationList.add(
          LocationModel(
            locId: _locationModel.locId,
            locReference: _locationModel.locReference,
            title: _locationModel.title,
            locStatus: _locationModel.locStatus,
            createdOn: _locationModel.createdOn,
            udatedOn: _locationModel.udatedOn,
            addedBy: _locationModel.addedBy,
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