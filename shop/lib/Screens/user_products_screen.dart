import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/Providers/products_provider.dart';
import 'package:shop/Screens/drawer_screen.dart';
import 'package:shop/Widgets/user_product_item.dart';
class UserProductsScreen extends StatelessWidget {
  static const routeName="/route";
  @override
  Widget build(BuildContext context) {
    final providerData=Provider.of<Products>(context);
    return Scaffold(
drawer: DrawerScreen(),
      appBar: AppBar(title: Text("Managing Products"),
      actions: [
        IconButton(icon: Icon(Icons.add), onPressed: (){})
      ],),
      body: Padding(
        padding: EdgeInsets.all(8),
     child:ListView.builder(
          itemBuilder: (ctx, index)=>UserProductItem(title: providerData.items[index].title, imageUrl: providerData.items[index].imageUrl,),
           itemCount:providerData.items.length),
      ),
      
    );
  }
}