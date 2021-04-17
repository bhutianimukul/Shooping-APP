import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop/Widgets/order_item.dart';
import 'dart:convert';
import 'cart.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime time;

  OrderItem({
    @required this.id,
    @required this.amount,
    @required this.products,
    @required this.time,
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> _order = [];
  List<OrderItem> get order {
    return [..._order];
  }
  Future<void> fetchorderData() async{
        final url =
        'https://shop-app-169a7-default-rtdb.firebaseio.com/Orders.json';
final response= await http.get(Uri.parse(url));
 List<OrderItem>loadedOrder=[];
final extractedData=json.decode(response.body) as Map<String , dynamic>;
if(extractedData==null) return ; 
extractedData.forEach((key, orderData) { 
  loadedOrder.add(
    OrderItem(id: key , amount: orderData['total'], 
    products: (orderData['products'] as List<dynamic>).map((e) => CartItem(id: e['id'].toString(), quantity: e['quantity'], price: e['price'], title: e['title'])).toList(),
    time: DateTime.parse(orderData['time']))
  );
}

);
_order=loadedOrder.reversed.toList();
notifyListeners();
  }

  Future<void> addOrder(List<CartItem> cart, double total) async {
    final time = DateTime.now();
    final url =
        'https://shop-app-169a7-default-rtdb.firebaseio.com/Orders.json';
        try{
    final response = await http.post(Uri.parse(url),
        body: json.encode({
          'time': time.toIso8601String(),
          'total': total,
          'products': cart
              .map((e) => {
                    'id': e.id,
                    'price': e.price,
                    'quantity': e.quantity,
                    'title': e.title
                  })
              .toList(),
        }));
    _order.insert(
      0,
      OrderItem(
          id: json.decode(response.body)['name'],
          amount: total,
          products: cart,
          time: DateTime.now()),
    );
    notifyListeners();
        }catch(error){
          throw error;
        }
  }
}
