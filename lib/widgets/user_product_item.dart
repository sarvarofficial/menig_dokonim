import 'package:flutter/material.dart';
import 'package:menig_dokonim/provider/products.dart';
import 'package:menig_dokonim/screens/edit_product_screen.dart';
import 'package:provider/provider.dart';

import '../models/product_model.dart';

class UserProductItem extends StatelessWidget {
  const UserProductItem({Key? key}) : super(key: key);

  void _notifyUserAbout(BuildContext context, Function() removeItem) {
    showDialog(context: context, builder: (ctx) {
      return AlertDialog(
        title: const Text("Ishonchingiz komilmi ?"),
        content: const Text("Savatchadan mahsulot o'chmoqda"),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(),
              child: const Text("BEKOR QILSH")),
          ElevatedButton(onPressed: () {
            removeItem();
            Navigator.of(context).pop();
          }, child: const Text("O'chirish"))
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      child: Card(
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(product.imageUrl),
          ),
          title: Text(product.title),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(onPressed: () {
                Navigator.of(context).pushNamed(
                    EditProductScreen.routName, arguments: product.id);
              }, icon: const Icon(Icons.edit), color: Theme
                  .of(context)
                  .primaryColor,),
              IconButton(onPressed: () {
                _notifyUserAbout(context, () =>
                    Provider.of<Products>(context, listen: false).removeProduct(
                        product.id)
                );
              }, icon: const Icon(Icons.delete), color: Theme
                  .of(context)
                  .colorScheme
                  .error,)

            ],
          ),
        ),
      ),
    );
  }
}
