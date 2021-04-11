import 'package:flutter/material.dart';

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
          )
        ],
      ),
    );
  }
}
