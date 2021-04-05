//list of products available
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shop/Providers/products_provider.dart';
import 'package:shop/Widgets/products_grid.dart';
import '../Providers/product.dart';
enum filterOption{
favorites , 
all
}
class ProductOverviewScreen extends StatefulWidget {
  @override
  _ProductOverviewScreenState createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  var isFavorite=false;
  final List<Product> loadedProducts = [];

  @override
  Widget build(BuildContext context) {
 
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Shop Now",
          style: Theme.of(context).textTheme.title,
          
        ),
        actions: [
          
          PopupMenuButton(onSelected: (selectedValue)=> {
             setState(() {
      if(selectedValue==filterOption.favorites) {
isFavorite=true;
}
else if(selectedValue==filterOption.all) {
isFavorite=false;
}

    })


          },
            icon: Icon(Icons.more_vert), itemBuilder: (_)=> [PopupMenuItem(child:Text('Favorites'),
  value: filterOption.favorites,        ),
  PopupMenuItem(child:Text('Show All'),
  value: filterOption.all,        ),
   
  ] ),
        ],
      ),
      body: ProductsGrid(isFavorite),
    );
  }
}
