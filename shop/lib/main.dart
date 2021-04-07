import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/Providers/cart.dart';
import 'package:shop/Providers/products_provider.dart';
import 'package:shop/Screens/product_detail_screen.dart';
import 'package:shop/Screens/products_overview_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
        create: (_)=> Products(),),
        ChangeNotifierProvider(create: (_)=>Cart(),),
      ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          darkTheme: ThemeData(brightness: Brightness.dark, 
          textTheme: ThemeData.dark().textTheme.copyWith(
            title: TextStyle(fontFamily: 'PermanentMarker', fontWeight: FontWeight.bold, fontSize: 50),
            body1: TextStyle(fontFamily: 'PermanentMarker', fontSize: 30,color: Colors.black),
          )),
        
          themeMode: ThemeMode.dark,
          theme: ThemeData(primaryColor: Colors.red,
          ),
          home:  App(),
          routes: {
            ProductDetailScreen.routeName : (_)=>ProductDetailScreen()
          },
          
        ),
      );
  }
}
class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProductOverviewScreen(
      
    );
  }
}
