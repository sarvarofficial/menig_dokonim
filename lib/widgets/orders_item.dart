import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/cart_item.dart';

class OrdersItem extends StatefulWidget {
  final double totalPrice;
  final DateTime date;
  final List<CartItem> product;

  const OrdersItem({
    Key? key,
    required this.totalPrice,
    required this.date,
    required this.product,
  }) : super(key: key);

  @override
  State<OrdersItem> createState() => _OrdersItemState();
}

class _OrdersItemState extends State<OrdersItem> {
  bool _extendItem = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            title: Text("\$${widget.totalPrice}"),
            subtitle: Text(DateFormat("dd/MM/yyyy/hh:mm").format(widget.date)),
            trailing: IconButton(
              onPressed: () {
                setState(() {
                  _extendItem = !_extendItem;
                });
              },
              icon: Icon(_extendItem ? Icons.expand_less : Icons.expand_more),
            ),
          ),
          if (_extendItem)
            Container(
              padding: const EdgeInsets.all(16),
              height:min(widget.product.length*70+10,100),
              child: ListView.builder(
                itemExtent: 40,
                  itemCount: widget.product.length,
                  itemBuilder: (ctx, i) {
                    final products=widget.product[i];
                    return ListTile(
                      title: Text("${products.title}"),
                      trailing: Text("${products.quantity}x\$${products.price}",style:const TextStyle(color: Colors.grey),),
                    );
                  }),
            )
        ],
      ),
    );
  }
}
