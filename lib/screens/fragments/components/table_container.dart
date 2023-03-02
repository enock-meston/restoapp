import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../api_connection/api_connection.dart';
import '../../../controller/table_controller.dart';

Widget tableContainer(TableController tableApi) {
  return Card(
    child: Obx(
          () => tableApi.isLoading.value
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : GridView.builder(
          itemCount: tableApi.tableList.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                    Padding(
                      padding: const EdgeInsets.all(50.0),
                      child: InkWell(
                        onTap: () {
                          print('Table id Clicked is: ${tableApi.tableList[i].tabId}');
                        },
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10)),
                          child: Text(
                              tableApi.tableList[i].title!,
                              style: const TextStyle(
                                  color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 30,backgroundColor: Colors.black12),
                            ),
                          ),
                        ),
                    ),
                    SizedBox(height: 10,),
                    Text(
                      tableApi.tableList[i].tabInformation!,
                      style: const TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            );
          }),
    ),
  );
}
