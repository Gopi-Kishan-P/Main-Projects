import 'package:flutter/material.dart';
import 'package:shop_app_v2/providers/cart.dart';
import 'package:shop_app_v2/providers/orders.dart';
import 'package:shop_app_v2/providers/products.dart';
import 'package:shop_app_v2/providers/products.dart';
import 'package:shop_app_v2/screens/cart_screen.dart';
import 'package:shop_app_v2/screens/edit_product_screen.dart';
import 'package:shop_app_v2/screens/orders_screen.dart';
import 'package:shop_app_v2/screens/product_details_screen.dart';
import 'package:shop_app_v2/screens/products_overview_screen.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_v2/screens/user_products_screen.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
    statusBarBrightness: Brightness.light,
    systemNavigationBarColor: Colors.white,
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Products(),
        ),
        ChangeNotifierProvider(
          create: (_) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (_) => Orders(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Shopp App',
        theme: ThemeData(
          primaryColor: Colors.blue,
          accentColor: Colors.orange,
          scaffoldBackgroundColor: Colors.white,
          fontFamily: 'Lato',
        ),
        home: ProductsOverviewScreen(),
        routes: {
          ProductDetailsScreen.routeName: (ctx) => ProductDetailsScreen(),
          CartScreen.routeName: (ctx) => CartScreen(),
          OrderScreen.routeName: (ctx) => OrderScreen(),
          UserProductScreen.routeName: (ctx) => UserProductScreen(),
          EditProductScreen.routeName: (ctx) => EditProductScreen(),
        },
      ),
    );
  }
}
