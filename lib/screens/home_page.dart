import 'package:flutter/material.dart';
import 'package:menig_dokonim/provider/cart.dart';
import 'package:menig_dokonim/screens/cart_screen.dart';
import 'package:menig_dokonim/widgets/app_drawer.dart';
import 'package:menig_dokonim/widgets/custom_cart.dart';
import 'package:menig_dokonim/widgets/product_grid.dart';
import 'package:provider/provider.dart';

import '../provider/products.dart';

class HomePage extends StatefulWidget {
  HomePage({
    Key? key,
  }) : super(key: key);
  static const routName='/';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _showOnlyFavorite = false;


  @override
  Widget build(BuildContext context) {


    return Scaffold(

        appBar: AppBar(
          centerTitle: true,
          title:const Text("Mening do'konim"),
          actions: [
            PopupMenuButton<FilterOption>(
              onSelected: (FilterOption filter) {
                return setState(() {
                  if (filter == FilterOption.All) {
                    _showOnlyFavorite = false;
                  } else {
                    _showOnlyFavorite = true;
                  }
                });
              },
              itemBuilder: (context) {
                return const [
                  PopupMenuItem(
                    child: Text("Barchasi"),
                    value: FilterOption.All,
                  ),
                  PopupMenuItem(
                    child: Text("Fovorite"),
                    value: FilterOption.Favorite,
                  ),
                ];
              },
            ),
            Consumer<Cart>(
              builder: (context, cart, child) {
                return CustomCart(
                  number: cart.itemsCount().toString(),
                  child: child!,
                );
              },
              child: IconButton(onPressed: (){Navigator.of(context).pushNamed(CartScreen.routeName);},icon:const Icon(Icons.shopping_cart),)
            )
          ],
        ),
        drawer:const AppDrawer(),

        body: ProductGrid(showOnlyFavorite: _showOnlyFavorite));
  }
}

enum FilterOption {
  All,
  Favorite,
}
