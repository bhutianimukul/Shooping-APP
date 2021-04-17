import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shop/Models/httpException.dart';
class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product(
      {@required this.id,
      @required this.title,
      @required this.description,
      @required this.price,
      @required this.imageUrl,
      this.isFavorite = false});
  Future<void> toggleFavorite() async{
    final oldStatus=isFavorite;
    isFavorite = !isFavorite;
     notifyListeners();
     final url =
        'https://shop-app-169a7-default-rtdb.firebaseio.com/Products/$id.json';
try{
final response =await http.patch(Uri.parse(url),
body: json.encode({
  'isFavorite' :isFavorite,
}),
  );
  if(response.statusCode>=400){

 isFavorite=oldStatus;
   notifyListeners();
    throw HttpException('error found');
  }
  }
  catch(error){
 
      throw error;
  }
    
    
   
  }
}
