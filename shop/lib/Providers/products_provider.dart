// provider centralised data collection
import 'package:flutter/foundation.dart';
import 'package:shop/Providers/product.dart';

class Products with ChangeNotifier {
  List<Product> _items = [
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 200,
      imageUrl: 'https://static.iplt20.com/players/210/164.png',
    ),
    Product(
      id: 'p2',
      title: 'headphone',
      description: 'Wireless headphones',
      price: 2000,
      imageUrl:
          'https://media.croma.com/image/upload/f_auto,q_auto,d_Croma%20Assets:no-product-image.jpg,h_260,w_260/v1605129119/Croma%20Assets/Entertainment/Headphones%20and%20Earphones/Images/8944816816158.png',
    ),
    // Product(
    //   id: 'p3',
    //   title: 'Laptop',
    //   description: 'I5 8 gen',
    //   price: 50000,
    //   imageUrl:
    //       'https://lh3.googleusercontent.com/proxy/eBc5FuwRkHZWFoFTJnS2HNGZkGjsVRd1Tj8e1l4crPCPDw9GYPKVT7lnrG8-SpnQSnFB8YivQZHePmFt6sjdhthwTvJ0DBbTesFtLK95VeyWtyQl9CBU1GsrapiEBz0Y6582T0g',
    // ),
  ];
  List<Product> get favList {
    return [..._items.where((element) => element.isFavorite == true).toList()];
  }

  List<Product> get items {
    return [..._items];
  }

  Product findById(String id) {
    return _items.firstWhere((element) => element.id == id);
  }

  void addProductListener() {
    //_items.add();
    notifyListeners();
  }
}
