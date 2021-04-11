import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shop/Providers/order.dart' as ord;
import 'package:intl/intl.dart';

class OrderItem extends StatefulWidget {
  final ord.OrderItem order;
  const OrderItem({this.order});

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  var expanded = false;
  Widget data(val) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        //Text( style: TextStyle(fontSize: 20, fontFamily: " ", color: Colors.black,)),
        Text(val.title,
            style: TextStyle(
              fontSize: 20,
              fontFamily: " ",
              color: Colors.black,
            )),
        Text(val.price.toString(),
            style: TextStyle(
              fontSize: 20,
              fontFamily: " ",
              color: Colors.black,
            )),
        Text("X${val.quantity.toString()}",
            style: TextStyle(
              fontSize: 20,
              fontFamily: " ",
              color: Colors.black,
            )),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
//    final providerData=Provider.of<Cart>(context , listen: false);

    return Card(
        color: Colors.white,
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            ListTile(
              title: Text(
                "₹${widget.order.amount}",
                style: TextStyle(color: Colors.black),
              ),
              subtitle: Text(
                  DateFormat('dd/MM/yyyy hh:mm').format(
                    widget.order.time,
                  ),
                  style: TextStyle(
                      color: Colors.black, fontFamily: " ", fontSize: 10)),
              trailing: IconButton(
                  icon: expanded == false
                      ? Icon(
                          Icons.expand_more,
                          color: Colors.black,
                        )
                      : Icon(Icons.expand_less, color: Colors.black),
                  onPressed: () {
                    setState(() {
                      expanded = !expanded;
                    });
                  }),
            ),
            if (expanded)
              Container(
                height: min(widget.order.products.length * 20.0 + 100, 100),
                child: ListView.builder(
                  itemBuilder: (ctx, i) => Column(
                    children: [
                      data(widget.order.products[i]),
                      Divider(),
                    ],
                  ),
                  itemCount: widget.order.products.length,
                ),
              )
          ],
        ));
  }
}
