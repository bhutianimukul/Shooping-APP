import 'package:flutter/foundation.dart';

class CartItem {
  @override
  final String id;
  final int quantity;
  final double price;
  final String title;

  CartItem(
      {@required this.id,
      @required this.quantity,
      @required this.price,
      @required this.title});
}

class Cart with ChangeNotifier {
  Map<String, CartItem> items={};
  Map<String, CartItem> get cart {
    return {...items};
  }
  int get getlength{
   return items==null ?   0 : items.length; 
  }

  void addToCart(String productid,  double price, String title) {
    if (items.containsKey(productid)) {
      items.update(
          productid,
          (value) => CartItem(
              id: productid,
              quantity: value.quantity + 1,
              price: price,
              title: title));
    } else {
      items.putIfAbsent(
          productid,
          () => CartItem(
              id: DateTime.now().toString(),
              quantity: 1,
              price: price,
              title: title));
    }
    notifyListeners();
  }
}
