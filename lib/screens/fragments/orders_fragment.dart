import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurentapp/common/navigaton_drawer.dart';

class OrderFragment extends StatefulWidget {
  const OrderFragment({Key? key}) : super(key: key);

  @override
  State<OrderFragment> createState() => _OrderFragmentState();
}

class _OrderFragmentState extends State<OrderFragment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Navigation_Drawer(),
      appBar: AppBar(
        title: const Text('Orders'),
      ),
      body: const Center(
        child: Text(
          'Orders',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
