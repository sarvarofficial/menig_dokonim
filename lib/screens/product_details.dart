import 'package:flutter/material.dart';
import 'package:menig_dokonim/models/product_model.dart';
import 'package:menig_dokonim/provider/cart.dart';
import 'package:provider/provider.dart';

import '../provider/products.dart';
import 'cart_screen.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({Key? key}) : super(key: key);
  static const routName = "product-details";

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)!.settings.arguments;
    final productData = Provider.of<Products>(context)
        .list
        .firstWhere((product) => product.id == productId);

    return Scaffold(
      appBar: AppBar(
        title: Text(productData.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: 250,
              child: Image.network(
                productData.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding:const EdgeInsets.all(16),
              child: Text(productData.description),
            )
          ],
        ),
      ),
      bottomSheet: BottomAppBar(
        height: 72,
        padding:const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [const Text("Narxi:"), Text("\$${productData.price}")],
            ),
            Consumer<Cart>(
              builder: (context, cart, child) {
                final isProductAdded = cart.items.containsKey(productId);
                return isProductAdded
                    ? ElevatedButton.icon(
                        onPressed: () {
                          Navigator.of(context).pushReplacementNamed(CartScreen.routeName);
                        },
                        icon: const Icon(
                          Icons.shopping_bag,
                          color: Colors.black,
                          size: 16,
                        ),
                        label: const Text(
                          "Savatchaga borish",
                          style: TextStyle(color: Colors.black),
                        ),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey.shade200,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 10)),
                      )
                    : ElevatedButton.icon(
                        onPressed: () {
                          cart.addToCart(productData.id, productData.title,
                              productData.imageUrl, productData.price);
                        },
                        icon: const Icon(Icons.shopping_bag),
                        label: const Text("Savatchaga qo'shish"),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black87,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 10)),
                      );
              },
            )
          ],
        ),
      ),
    );
  }
}
