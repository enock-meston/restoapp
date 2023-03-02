import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../api_connection/api_connection.dart';
import '../../../controller/product_by_category_controller.dart';

Widget itemContainer(ProductBYCategoryController productApi) {
  return Card(
    child: Obx(
      () => productApi.isLoading.value
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : GridView.builder(
              itemCount: productApi.photoList.length,
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

                        InkWell(
                          onTap: () {
                            productApi.MakeRequestMethod(productApi.photoList[i].productId!);
                            // print('Product id Clicked is: ${productApi.photoList[i].productId}');
                          },
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10)),
                            child: Image.network(
                              "${API.hostAdmin}${productApi.photoList[i].productImagePath}",
                              //image is not good
                              height: 140.0,
                              width: 140.0,
                            ),
                          ),
                        ),
                        Text(
                          productApi.photoList[i].productTitle!,
                          style: const TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '${productApi.photoList[i].price!}\$',
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
  );
}
