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
  Map<String, CartItem> items = {};
  Map<String, CartItem> get cart {
    return {...items};
  }

  int get getlength {
    return items == null ? 0 : items.length;
  }

  double getSum() {
    double sum = 0.0;
    items.forEach((key, cartItem) {
      sum += cartItem.price * cartItem.quantity;
    });
    return sum;
  }

  void removeItem(String id) {
    items.remove(id);
    notifyListeners();
  }

  void clearCart() {
    items = {};
    notifyListeners();
  }
  void removeSingleItem(id){
    if(!items.containsKey(id)) return ;
    else if(items[id].quantity==1){
      items.removeWhere((key, value) => key==id);
    }else{
      items.update(id, (value) => CartItem(id: id, quantity: value.quantity-1, price:value.price, title: value.title));
    }
    notifyListeners();

  }

  void addToCart(String productid, double price, String title) {
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
