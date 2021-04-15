// for gridview builder new file because of provider
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/Providers/products_provider.dart';
import 'package:shop/Widgets/product_item.dart';

class ProductsGrid extends StatelessWidget {
  var isFav;
  ProductsGrid(this.isFav);
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final loadedProducts = isFav ? productsData.favList : productsData.items;
    if (loadedProducts.length == 0) {
      return Center(child: Text('No Items'));
    }
    return GridView.builder(
        itemCount: loadedProducts.length,
        padding: const EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            childAspectRatio: 1.5,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20),
        itemBuilder: (context, index) => ChangeNotifierProvider.value(
              value: loadedProducts[index],
              child: ProductItem(),
            )

        // create: (_) => loadedProducts[index],

        );
  }
}
