// provider centralised data collection
import 'package:flutter/foundation.dart';
import 'package:shop/Models/httpException.dart';
import 'package:shop/Providers/product.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Products with ChangeNotifier {
  List<Product> _items = [
    // Product(
    //   id: 'p1',
    //   title: 'Red Shirt',
    //   description: 'A red shirt - it is pretty red!',
    //   price: 200,
    //   imageUrl: 'https://static.iplt20.com/players/210/164.png',
    // ),
    // Product(
    //   id: 'p2',
    //   title: 'headphone',
    //   description: 'Wireless headphones',
    //   price: 2000,
    //   imageUrl:
    //       'https://media.croma.com/image/upload/f_auto,q_auto,d_Croma%20Assets:no-product-image.jpg,h_260,w_260/v1605129119/Croma%20Assets/Entertainment/Headphones%20and%20Earphones/Images/8944816816158.png',
    // ),
    // // Product(
    // //   id: 'p3',
    // //   title: 'Laptop',
    // //   description: 'I5 8 gen',
    // //   price: 50000,
    // //   imageUrl:
    // //       'https://lh3.googleusercontent.com/proxy/eBc5FuwRkHZWFoFTJnS2HNGZkGjsVRd1Tj8e1l4crPCPDw9GYPKVT7lnrG8-SpnQSnFB8YivQZHePmFt6sjdhthwTvJ0DBbTesFtLK95VeyWtyQl9CBU1GsrapiEBz0Y6582T0g',
    // // ),
  ];
  String token, userId;
  void updateToken(String token, userId) {
    this.token = token;
    this.userId = userId;
  }

  List<Product> get favList {
    return [..._items.where((element) => element.isFavorite == true).toList()];
  }

  List<Product> get items {
    return [..._items];
  }

  Product findById(String id) {
    return _items.firstWhere((element) => element.id == id);
  }

  Future<void> addProductListener(Product product) async {
    final url =
        'https://shop-app-169a7-default-rtdb.firebaseio.com/Products.json?auth=$token';
    try {
      final value = await http.post(
        Uri.parse(url),
        body: json.encode({
          'title': product.title,
          'description': product.description,
          'imageUrl': product.imageUrl,
          'price': product.price,
        }),
      );
      final productDummy = Product(
          description: product.description,
          title: product.title,
          imageUrl: product.imageUrl,
          id: json.decode(value.body)['name'],
          price: product.price);
      _items.insert(0, productDummy);

      //_items.add();
      //
      print(json.decode(value.body)['name']);
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> fetchData() async {
    final url =
        'https://shop-app-169a7-default-rtdb.firebaseio.com/Products.json?auth=$token';
    final response = await http.get(Uri.parse(url));
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    if (extractedData == null) return;
    final favUrl =
        'https://shop-app-169a7-default-rtdb.firebaseio.com/Favorites/$userId.json?auth=$token';
    final favResponse = await http.get(Uri.parse(favUrl));
    final Map<String, dynamic> valueGot =
        json.decode(favResponse.body) as Map<String, dynamic>;

    final List<Product> loadedProducts = [];
    extractedData.forEach((id, product) {
      var mapFinal = valueGot==null?{}: valueGot[id];
      loadedProducts.insert(
          0,
          Product(
              id: id,
              description: product['description'],
              imageUrl: product['imageUrl'],
              price: product['price'],
              title: product['title'],
              isFavorite: mapFinal==null?false:mapFinal['isFavorite']==null ? false :mapFinal['isFavorite']??false
              )
              );
      _items = loadedProducts;
      notifyListeners();
    });
  }

  Future<void> update(id, Product newProduct) async {
    final index = _items.indexWhere((element) => element.id == id);

    if (index >= 0) {
      final url =
          'https://shop-app-169a7-default-rtdb.firebaseio.com/Products/$id.json?auth=$token';
      await http.patch(Uri.parse(url),
          body: json.encode({
            'title': newProduct.title,
            'description': newProduct.description,
            'imageUrl': newProduct.imageUrl,
            'price': newProduct.price,
          }));
      _items[index] = newProduct;
    }
    notifyListeners();
  }

  Future<void> deleteProduct(id) async {
    final url =
        'https://shop-app-169a7-default-rtdb.firebaseio.com/Products/$id.json?auth=$token';
    int index = _items.indexWhere((element) => element.id == id);
    var removedProduct = _items[index];
    _items.removeAt(index);
    _items.removeWhere((element) => element.id == id);
    notifyListeners();
    final value = await http.delete(Uri.parse(url));
    if (value.statusCode >= 400) {
      _items.insert(index, removedProduct);
      notifyListeners();
      throw HttpException('Unable To Delete');
    }
    removedProduct = null;

    //.catchError((error){
  }
}
