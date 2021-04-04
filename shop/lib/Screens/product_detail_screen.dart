// loaded when a specific item is tap display info of the product
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/Providers/products_provider.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = '/productDetail';
  @override
  Widget build(BuildContext context) {
    final String id = ModalRoute.of(context).settings.arguments as String;
    final providerData = Provider.of<Products>(context,listen: false);
    final loadedProduct=providerData.findById(id);

    return Scaffold(
      appBar: AppBar(title: Text(loadedProduct.title)),
    );
  }
}
