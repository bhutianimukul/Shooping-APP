import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/Providers/cart.dart';
class CartScreen extends StatelessWidget {
    
  static const routeName ='/cartScreen';
  @override
  Widget build(BuildContext context) {
    final double sum=Provider.of<Cart>(context).getSum();
  
    return Scaffold(
      appBar: AppBar(
        title: Text("CART"),
      ),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(15),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(children: [
Text("Total"),
SizedBox(
  width: 10,
),
Chip(label: Text("$sum")),
              ],),),
          )
        ],
      ),
      
    );
  }
}