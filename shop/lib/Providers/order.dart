import 'package:flutter/foundation.dart';
import 'package:shop/Providers/cart.dart';

class OrderItem {
  final id;
  final amount;
  final List<CartItem> products;
  final DateTime time;

  OrderItem(
      {@required this.id,
      @required this.amount,
      @required this.products,
      @required this.time});
}

class Orders with ChangeNotifier {
  List<OrderItem> _order = [];
  List<OrderItem> get order {
    return [...order];
  }

  void addOrder(List<CartItem> cart, double total) {
    _order.insert(
        0,
        OrderItem(
            id: DateTime.now().toString(),
            amount: total,
            products: cart,
            time: DateTime.now()));
    notifyListeners();
  }
}
