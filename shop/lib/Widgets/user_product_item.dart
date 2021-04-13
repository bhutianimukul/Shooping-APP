import 'package:flutter/material.dart';
import 'package:shop/Screens/edit_product_Screen.dart';
class UserProductItem extends StatelessWidget {
  final title;
  final imageUrl;

  const UserProductItem({ this.title, this.imageUrl});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(backgroundImage: NetworkImage(imageUrl),),
      trailing: Container(
        width: 100,
        child: Row(children: [
IconButton(icon: Icon(Icons.edit), onPressed: (){
  Navigator.of(context).pushNamed(EditProductScreen.routeName);
}),

IconButton(icon: Icon(Icons.delete), onPressed: (){}),

        ],),
      ),
    );
  }
}