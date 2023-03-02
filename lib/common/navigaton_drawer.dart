import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurentapp/UserPreferences/user_preferences.dart';
import 'package:restaurentapp/controller/category_controller.dart';
import 'package:restaurentapp/screens/fragments/orders_fragment.dart';
import 'package:restaurentapp/screens/fragments/profile_fragment.dart';
import 'package:restaurentapp/screens/fragments/quick_order_fragment.dart';
import 'package:restaurentapp/screens/fragments/stock_status_fragment.dart';
import 'package:restaurentapp/screens/fragments/table_orders_fragment.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../UserPreferences/current_user.dart';
import '../screens/home_fragment.dart';

class Navigation_Drawer extends StatefulWidget {
  @override
  State<Navigation_Drawer> createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<Navigation_Drawer> {

  final CurrentUser _currentUser = Get.put(CurrentUser());
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Container(
            child: ListView(
      children: [
        buildDrawerHeader(),
        buildDrawerItem(
            text: "Products",
            iconColor: Colors.blue,
            icon: Icons.fastfood,
            textIconColor: Colors.blue,
            tileColor: Colors.white,
            onTap: () => nagivateMethod(0)),
        Divider(
          color: Colors.blue,
        ),
        buildDrawerItem(
            text: "Quick Order",
            iconColor: Colors.blue,
            icon: Icons.lock_clock,
            textIconColor: Colors.blue,
            tileColor: Colors.white,
            onTap: () => nagivateMethod(1)),
        buildDrawerItem(
            text: "Table Orders",
            iconColor: Colors.blue,
            icon: Icons.table_restaurant,
            textIconColor: Colors.blue,
            tileColor: Colors.white,
            onTap: () => nagivateMethod(2)),
        buildDrawerItem(
            text: "Orders",
            iconColor: Colors.blue,
            icon: Icons.list_alt,
            textIconColor: Colors.blue,
            tileColor: Colors.white,
            onTap: () => nagivateMethod(3)),
        buildDrawerItem(
            text: "Stock Status",
            iconColor: Colors.blue,
            icon: Icons.shopping_basket,
            textIconColor: Colors.blue,
            tileColor: Colors.white,
            onTap: () => nagivateMethod(4)),
      ],
    )));
  }

  Widget buildDrawerHeader() {
    return UserAccountsDrawerHeader(
      accountName: FutureBuilder(
        future: SharedPreferences.getInstance(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final prefs = snapshot.data;
            // return Text(prefs!.getString("user_email")!);
            return Text(prefs!.getString("user_username") == null
                ? "you need to edit your Profile"
                : prefs.getString("user_email")!);
          } else {
            return AppBar(
              title: Text("Loading..."),
            );
          }
        },
      ),
      accountEmail: FutureBuilder(
        future: RememberUserPrefs.readUserInfo(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final prefs = snapshot.data;
            // return Text(prefs!.getString("user_email")!);
            return Text(prefs!.user_email == "null"
                ? "Your email"
                : prefs.user_email!);
          } else {
            return Text("Loading...");
          }
        },
      ),
      currentAccountPicture: CircleAvatar(
        backgroundImage: AssetImage('images/logo.png'),
      ),
      currentAccountPictureSize: Size.square(72),
      otherAccountsPictures: [
        CircleAvatar(
          backgroundColor: Colors.white,
          child: IconButton(
            onPressed: () {

              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => UserProfile()));

            },
            icon: Icon(
              Icons.logout,
              color: Colors.blue,
            ),
          ),
        )
      ],
      otherAccountsPicturesSize: Size.square(50),
    );
  }

  // drawer item
  Widget buildDrawerItem(
      {required String text,
      required Color iconColor,
      required IconData icon,
      required Color textIconColor,
      required Color? tileColor,
      required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(icon, color: textIconColor),
      title: Text(
        text,
        style: TextStyle(color: textIconColor),
      ),
      tileColor: tileColor,
      onTap: () => onTap(),
    );
  }

  nagivateMethod(int index) {
    switch (index) {
      case 0:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeFragment()));
        break;
      case 1:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => QuickOrder()));
        break;
      case 2:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) =>
            TableOrders()));
        break;
      case 3:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => OrderFragment()));
        break;
      case 4:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => StockStatusFragment()));
        break;
    }
  }
}
