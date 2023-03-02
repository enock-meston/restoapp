
import 'package:flutter/material.dart';
import 'package:restaurentapp/common/navigaton_drawer.dart';

class StockStatusFragment extends StatefulWidget {
  const StockStatusFragment({Key? key}) : super(key: key);

  @override
  State<StockStatusFragment> createState() => _StockStatusFragmentState();
}

class _StockStatusFragmentState extends State<StockStatusFragment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Navigation_Drawer(),
      appBar: AppBar(
        title: const Text('Stock Status'),
      ),
      body: const Center(
        child: Text(
          'Stock Status',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}