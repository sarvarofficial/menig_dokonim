import 'package:flutter/material.dart';
import 'package:menig_dokonim/provider/cart.dart';
import 'package:menig_dokonim/screens/product_details.dart';
import 'package:provider/provider.dart';

import '../models/product_model.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context)
              .pushNamed(ProductDetails.routName, arguments: product.id);
        },
        child: GridTile(
          footer: GridTileBar(
            leading: Consumer<Product>(
              builder: (context, pro, child) {
                return IconButton(
                  onPressed: () {
                    pro.toggleFavorite();
                  },
                  icon: pro.isFavorite
                      ? const Icon(
                          Icons.favorite,
                          color: Colors.teal,
                        )
                      : const Icon(
                          Icons.favorite_outline,
                          color: Colors.teal,
                        ),
                );
              },
            ),
            title: Text(
              product.title,
              textAlign: TextAlign.center,
            ),
            trailing: IconButton(
              onPressed: () {
                cart.addToCart(
                    product.id, product.title, product.imageUrl, product.price);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      "Savatchaga qo'shildi",
                    ),
                    action: SnackBarAction(
                        label: "BEKOR QILISH",
                        onPressed: () {
                          cart.singleItemsRemove(product.id,
                              isCartButton: true);
                        }),
                  ),
                );
              },
              icon: const Icon(
                Icons.shopping_cart,
                color: Colors.teal,
              ),
            ),
            backgroundColor: Colors.black87,
          ),
          child: Image(
            image: NetworkImage(product.imageUrl),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
