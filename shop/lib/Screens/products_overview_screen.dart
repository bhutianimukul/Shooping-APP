//list of products available
import 'package:flutter/material.dart';
import 'package:shop/Widgets/products_grid.dart';
import '../Providers/product.dart';

class ProductOverviewScreen extends StatelessWidget {
  final List<Product> loadedProducts = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Shop Now",
          style: Theme.of(context).textTheme.title,
        ),
      ),
      body: ProductsGrid(),
    );
  }
}
