import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/Providers/cart.dart' ;
import 'package:shop/Providers/order.dart' as ord;

class OrderItem extends StatelessWidget {
  final ord.OrderItem order;

  const OrderItem(this.order);
  @override
  Widget build(BuildContext context) {
    final providerData=Provider.of<Cart>(context , listen: false);
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 15),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: ListTile(
        ),
      ),
    );
  }
}
