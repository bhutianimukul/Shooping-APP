import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/Providers/auth.dart';
import 'package:shop/Screens/user_products_screen.dart';

import 'order_screen.dart';

class DrawerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text("Drawer"),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: ListTile(
              title: Text("Shop"),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/');
              },
              leading: CircleAvatar(
                child: Icon(Icons.shop),
              ),
            ),
          ),
          Divider(),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: ListTile(
              onTap: () {
                Navigator.pushReplacementNamed(context, OrderScreen.routeName);
              },
              title: Text("Orders"),
              leading: CircleAvatar(
                child: Icon(Icons.history),
              ),
            ),
          ),
           Divider(),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: ListTile(
              onTap: () {
                Navigator.pushReplacementNamed(context, UserProductsScreen.routeName);
              },
              title: Text("Manage Products"),
              leading: CircleAvatar(
                child: Icon(Icons.edit),
              ),
            ),
          ),
          Divider(),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: ListTile(
              onTap: () {
                Navigator.of(context).pop();
             Provider.of<Auth>(context, listen :false).logOut();
              },
              title: Text("LOG OUT"),
              leading: CircleAvatar(
                child: Icon(Icons.logout),
              ),
            ),
          )
        ],
      ),
    );
  }
}
