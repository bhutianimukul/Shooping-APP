import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/Providers/cart.dart';
import 'package:shop/Providers/order.dart';
import 'package:shop/Widgets/cart_item.dart' as ci;

class CartScreen extends StatelessWidget {
  static const routeName = '/cartScreen';
  @override
  Widget build(BuildContext context) {
    final providerData = Provider.of<Cart>(context);

    final double sum = providerData.getSum();

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
              child: Container(
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Total"),
                    SizedBox(
                      width: 10,
                    ),
                    Chip(label: Text("₹$sum")),
                  ],
                ),
              ),
            ),
          ),
          Container(
              child: RaisedButton(
            onPressed: () {
              Provider.of<Orders>(context, listen: false)
                  .addOrder(providerData.items.values.toList(), sum);
              providerData.clearCart();
            },
            child: Text("Order"),
          )),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) => ci.CartItem(
                  productId: providerData.items.keys.toList()[index],
                  id: providerData.items.values.toList()[index].id,
                  quantity: providerData.items.values.toList()[index].quantity,
                  price: providerData.items.values.toList()[index].price,
                  title: providerData.items.values.toList()[index].title),
              itemCount: providerData.items.length,
            ),
          )
        ],
      ),
    );
  }
}
