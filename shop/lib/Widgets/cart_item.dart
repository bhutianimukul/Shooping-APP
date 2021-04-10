import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/Providers/cart.dart';

class CartItem extends StatelessWidget {
  final id;
  final productId;
  final price;
  final quantity;
  final title;

  const CartItem({this.id, this.price, this.quantity, this.title, this.productId});
  @override
  Widget build(BuildContext context) {
    final providerData=Provider.of<Cart>(context , listen: false);
    return Dismissible(
      key: ValueKey(id),
      background: Container(color: Colors.red,
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.only(right: 10),
      child: Icon(Icons.delete, size: 30,),),
    direction: DismissDirection.endToStart,
onDismissed: (direction){
providerData.removeItem(productId);

},
    
      child: Card(
        color: Colors.white,
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 15),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              child: Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: FittedBox(child: Text("₹$price")
),
              ),
            ),
            title: Text(
              title,
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
            subtitle: Text(
              "Total ₹${price * quantity}",
              style: TextStyle(fontSize: 15, color: Colors.black),
            ),
            trailing: Text("X$quantity"),
          ),
        ),
      ),
    );
  }
}
