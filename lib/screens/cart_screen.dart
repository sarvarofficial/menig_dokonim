import 'package:flutter/material.dart';
import 'package:menig_dokonim/provider/cart.dart';
import 'package:menig_dokonim/provider/orders.dart';
import 'package:menig_dokonim/widgets/cart_list_item.dart';
import 'package:provider/provider.dart';

import '../models/product_model.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);
  static const routeName = '/cart-screen';

  @override
  Widget build(BuildContext context) {


    final cart = Provider.of<Cart>(context, );
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:const Text("Sizning savatchangiz"),
      ),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.all(10),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                 const Text(
                    "Umumiy: ",
                    style: TextStyle(fontSize: 18),
                  ),
                 const Spacer(),
                  Chip(
                    label: Text("\$${(cart.totalPrice()).toStringAsFixed(2)}",
                        style:const TextStyle(
                          color: Colors.white,
                        )),
                    backgroundColor: Colors.teal,
                  ),
                  TextButton(onPressed: () {
                    Provider.of<Orders>(context,listen: false).addToOrders(cart.items.values.toList(), cart.totalPrice());
                    cart.clearItems();
                  }, child:const Text("BUYURTMA QILISH"))
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: cart.items.length,
                  itemBuilder: (ctx, i) {

                    final cartItem = cart.items.values.toList()[i];
                    return CartListItem(
                      productId: cart.items.keys.toList()[i],
                      image: cartItem.image,
                      title: cartItem.title,
                      price: cartItem.price,
                      quantity: cartItem.quantity,


                    );
                  }))
        ],
      ),
    );
  }
}
