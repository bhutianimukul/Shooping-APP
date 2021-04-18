import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/Providers/cart.dart';
import 'package:shop/Providers/order.dart';
import 'package:shop/Providers/products_provider.dart';
import 'package:shop/Screens/cart_screen.dart';
import 'package:shop/Screens/edit_product_Screen.dart';
import 'package:shop/Screens/product_detail_screen.dart';
import 'package:shop/Screens/products_overview_screen.dart';
import 'package:shop/Screens/splash_screen.dart';
import 'package:shop/Screens/user_products_screen.dart';

import 'Providers/auth.dart';
import 'Screens/auth_screen.dart';
import 'Screens/order_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value:  Auth(),),
         ChangeNotifierProxyProvider<Auth, Products>(
         create: (_)=>Products(),
          update: (_, auth , product) => product..updateToken(auth.token,auth.userId)
          
        ),
        ChangeNotifierProxyProvider<Auth,Orders>(
          create: (_) => Orders(),
          update: (_, auth , order)=>order..getToken(auth.token,auth.userId),
        ),
       
        ChangeNotifierProvider(
          create: (_) => Cart(),
        ),
      ],
      child: Consumer<Auth>(builder: ( context, auth,child )=> MaterialApp(
        debugShowCheckedModeBanner: false,
        darkTheme: ThemeData(
            brightness: Brightness.dark,
            textTheme: ThemeData.dark().textTheme.copyWith(
                  title: TextStyle(
                      fontFamily: 'PermanentMarker',
                      fontWeight: FontWeight.bold,
                      fontSize: 50),
                  body1: TextStyle(
                      fontFamily: 'PermanentMarker',
                      fontSize: 30,
                      color: Colors.black),
                )),
        themeMode: ThemeMode.dark,
        theme: ThemeData(
          primaryColor: Colors.red,
        ),
      home: auth.isAuth
                  ? ProductOverviewScreen()
                  : FutureBuilder(
                      future: auth.autoLogin(),
                      builder: (context, authResultSnapshot) {
                   

                       return   authResultSnapshot.connectionState ==
                                  ConnectionState.waiting
                              ? SplashScreen()
                              :
                   AuthScreen();
                      }),
        routes: {
          EditProductScreen.routeName: (_)=>EditProductScreen(),
          UserProductsScreen.routeName: (_)=>UserProductsScreen(),
          OrderScreen.routeName: (_) => OrderScreen(),
          ProductDetailScreen.routeName: (_) => ProductDetailScreen(),
          CartScreen.routeName: (_) => CartScreen()
        },
      ),) ,
     
    );
  }
}
