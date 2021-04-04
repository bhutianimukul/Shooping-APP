// widget to show the  grid tile
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/Providers/product.dart';
import 'package:shop/Screens/product_detail_screen.dart';

class ProductItem extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
  final providerData=  Provider.of<Product>(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: GridTile(
        footer: GridTileBar(
          trailing: IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {},
          ),
          leading: IconButton(
          
            icon: Icon(
              providerData.isFavorite==false?
              Icons.favorite_outline_outlined: Icons.favorite),
            onPressed: () { providerData.toggleFavorite();},
          ),
          backgroundColor: Colors.white60,
          title: Text(
            providerData.title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.body1,
          ),
        ),
        child: InkWell(
            onTap: () => Navigator.pushNamed(
                context, ProductDetailScreen.routeName,
                arguments: providerData.id),
            child: Image.network(
             providerData. imageUrl,
              fit: BoxFit.contain,
            )),
      ),
    );
  }
}
