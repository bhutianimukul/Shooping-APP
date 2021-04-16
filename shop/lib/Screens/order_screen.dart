import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/Screens/drawer_screen.dart';
import 'package:shop/Widgets/order_item.dart' as ord;
import 'package:shop/Providers/order.dart';

class OrderScreen extends StatefulWidget {
  static const routeName = '/orderScreen';

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
    void initState() {
  Provider.of<Orders>(context, listen:false).fetchorderData();
      super.initState();
    }
  @override
  Widget build(BuildContext context) {
    final providerData = Provider.of<Orders>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text("Your Orders"),
        ),
        drawer: DrawerScreen(),
        body: ListView.builder(
          itemBuilder: (context, index) => ord.OrderItem(
            order: providerData.order[index],
          ),
          itemCount: providerData.order.length,
        ));
  }
}
