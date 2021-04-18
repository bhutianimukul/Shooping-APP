// widget to show the  grid tile
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/Providers/auth.dart';
import 'package:shop/Providers/cart.dart';
import 'package:shop/Providers/product.dart';
import 'package:shop/Screens/product_detail_screen.dart';

class ProductItem extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
      final scaffold=Scaffold.of(context);
    final providerData = Provider.of<Cart>(context, listen: false);
    final product = Provider.of<Product>(context);
     final auth = Provider.of<Auth>(context ,listen:false );
     

    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: GridTile(
        footer: GridTileBar(
          trailing: IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              providerData.addToCart(product.id, product.price, product.title);
     ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Added to Cart"),
      duration: Duration(seconds: 2),
      action: SnackBarAction(label: "Undo", onPressed: (){
        providerData.removeSingleItem(product.id);
      }),));
            }
          ),
          leading: IconButton(
            icon: Icon(product.isFavorite == false
                ? Icons.favorite_outline_outlined
                : Icons.favorite),
            onPressed: ()async {
try{

            await  product.toggleFavorite(auth.token,auth.userId);
        
}catch(error){
scaffold.showSnackBar(SnackBar(content: Text('error in Favorites'), duration: Duration(seconds: 1),));
}
            },
          ),
          backgroundColor: Colors.white60,
          title: Text(
            product.title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.body1,
          ),
        ),
        child: InkWell(
            onTap: () => Navigator.pushNamed(
                context, ProductDetailScreen.routeName,
                arguments: product.id),
            child: Image.network(
              product.imageUrl,
              fit: BoxFit.contain,
            )),
      ),
    );
  }
}
