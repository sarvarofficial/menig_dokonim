import 'package:flutter/material.dart';
import 'package:menig_dokonim/provider/cart.dart';
import 'package:menig_dokonim/provider/orders.dart';
import 'package:menig_dokonim/provider/products.dart';
import 'package:menig_dokonim/screens/cart_screen.dart';
import 'package:menig_dokonim/screens/edit_product_screen.dart';
import 'package:menig_dokonim/screens/manage_roduct_screen.dart';
import 'package:menig_dokonim/screens/order_screen.dart';
import 'package:menig_dokonim/screens/product_details.dart';
import 'package:provider/provider.dart';
import '../screens/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Products>(
          create: (context) => Products(),
        ),
        ChangeNotifierProvider<Cart>(create: (context)=>Cart(),),
        ChangeNotifierProvider<Orders>(create: (context)=>Orders(),),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.teal,
          primaryColor: Colors.teal,
        ),
        // home: HomePage(),
        initialRoute:HomePage.routName,
        routes: {
          HomePage.routName: (context)=>HomePage(),
          ProductDetails.routName: (context) =>const ProductDetails(),
          CartScreen.routeName: (context)=>const CartScreen(),
          OrderScreen.routName:(context)=>const OrderScreen(),
          ManageProductScreen.routName:(context)=>const ManageProductScreen(),
          EditProductScreen.routName:(context)=>const EditProductScreen(),
        },
      ),
    );
  }
}
