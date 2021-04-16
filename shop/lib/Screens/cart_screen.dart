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
              child: OrderButton(sum: sum, providerData: providerData)),
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

class OrderButton extends StatefulWidget {
  const OrderButton({
    Key key,
    @required this.sum,
    @required this.providerData,
  }) : super(key: key);

  final double sum;
  final Cart providerData;

  @override
  _OrderButtonState createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  var isLoading=false;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      
            onPressed: (widget.sum<=0|| isLoading )?null: () async {
              setState(() {
                              isLoading=true;
                            });
    try{
    await Provider.of<Orders>(context, listen: false)
        .addOrder(widget.providerData.items.values.toList(), widget.sum);
       setState(() {
                              isLoading=false;
                            });
    widget.providerData.clearCart();
    }catch(error){

    }
            },
            child: isLoading? CircularProgressIndicator(): Text("Order"),
          );
  }
}
