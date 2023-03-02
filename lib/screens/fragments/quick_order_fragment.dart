import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:restaurentapp/controller/product_by_category_controller.dart';
import 'package:restaurentapp/screens/fragments/components/item_container.dart';

import '../../api_connection/api_connection.dart';
import '../../common/navigaton_drawer.dart';
import '../../controller/category_controller.dart';

class QuickOrder extends StatefulWidget {
  @override
  State<QuickOrder> createState() => _QuickOrderState();
}

class _QuickOrderState extends State<QuickOrder> {
  //create controller class // oke
  final CategoryController categoryController = Get.put(CategoryController());

  ProductBYCategoryController productApi=ProductBYCategoryController();

  @override
  Widget build(BuildContext context) {
    productApi.fetchProductDataByCat(1);
    return Scaffold(
      drawer: Navigation_Drawer(),
      appBar: AppBar(
        title: const Text('Quick Order'),
      ),
      body: GetX<CategoryController>(builder: (context) {
        return DefaultTabController(
          length: categoryController.categoryList.length,
          child: Scaffold(
            body: Column(
              children: [
                TabBar(
                  onTap:(int id){
                    productApi.photoList.clear();
                    productApi.fetchProductDataByCat(id+1);
                    print('tab is clicked');
                    print('id is '+id.toString());

                  },
                    tabs: categoryController.categoryList
                        .map((e) => my_tab(
                              title: e.title.toString(),
                            ))
                        .toList(),
                    isScrollable: true),
                Expanded(
                  child: TabBarView(
                    children:
                      categoryController.categoryList
                          .map((e) => itemContainer(
                          productApi
                      ))
                         .toList(),


                  ),
                ),
              ],
            ),

            // tab bar view
          ),
        );
      }),
    );
  }
}

class my_tab extends StatelessWidget {
  const my_tab({super.key, required this.title});

  final String title;



  @override
  Widget build(BuildContext context) {
    return Tab(
      height: 60,
      child: Container(
        padding: const EdgeInsets.all(0.0),
        decoration: const BoxDecoration(color: Colors.white),
        child: Text(title,
            style: const TextStyle(fontSize: 10, color: Colors.blue)),
      ),
    );
  }
}
