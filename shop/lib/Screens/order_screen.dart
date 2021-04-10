import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/Widgets/order_item.dart' as ord;
import 'package:shop/Providers/order.dart';
class OrderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final providerData=Provider.of<Orders> (context);
    return Scaffold(
      appBar: AppBar(title: Text("Your Orders"),),
      body: ListView.builder(itemBuilder: (context, index)=> ord.OrderItem(), 
      itemCount: providerData.order.length,)
      
    );
  }
}