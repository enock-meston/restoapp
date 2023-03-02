
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurentapp/controller/location_controller.dart';
import 'package:restaurentapp/model/category_model.dart';

import '../../common/navigaton_drawer.dart';

class TableOrders extends StatelessWidget {

   final LocationController locationController = Get.put(LocationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Navigation_Drawer(),
      appBar: AppBar(
        title: const Text('Table Orders'),
      ),
      body: GetX<LocationController>(builder: (context) {
        return DefaultTabController(
          length: locationController.locationList.length,
          child: Scaffold(
            body: Column(
              children: [
                TabBar(
                    tabs: locationController.locationList
                        .map((e) => my_tab(
                      title: e.title.toString(),
                    ))
                        .toList(),
                    isScrollable: true),
                Expanded(
                  child: TabBarView(

                    children: [
                      Container(
                        color: Colors.red,
                      ),
                      Container(
                        color: Colors.green,
                      ),
                      Container(
                        color: Colors.yellow,
                      ),
                      Container(
                        color: Colors.pink,
                      ),
                    ],
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