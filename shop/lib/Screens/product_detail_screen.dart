// loaded when a specific item is tap display info of the product
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/Providers/products_provider.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = '/productDetail';
  @override
  Widget build(BuildContext context) {
    final String id = ModalRoute.of(context).settings.arguments as String;
    final providerData = Provider.of<Products>(context, listen: false);
    final loadedProduct = providerData.findById(id);

    return Scaffold(
      appBar: AppBar(title: Text(loadedProduct.title)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 400,
              width: double.infinity,
              child: Image.network(
                loadedProduct.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text("₹${loadedProduct.price}",
                style: TextStyle(
                    fontSize: 40, fontFamily: " ", color: Colors.white)),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                loadedProduct.description,
                softWrap: true,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20, fontFamily: " ", color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
