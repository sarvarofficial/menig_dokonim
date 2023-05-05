import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:menig_dokonim/widgets/orders_item.dart';
import 'package:provider/provider.dart';

import '../provider/orders.dart';
import '../widgets/app_drawer.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({Key? key}) : super(key: key);
  static const routName='order-screen';

  @override
  Widget build(BuildContext context) {

    final orders=Provider.of<Orders>(context,listen: false);

    return Scaffold(
      drawer:const AppDrawer(),
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Buyurtmalar"),
      ),
      body: ListView.builder(
          itemCount: orders.list.length,
          itemBuilder: (context,index){
        final order=orders.list[index];
        return OrdersItem(totalPrice: order.totalPrice, date: order.date, product: order.products, );
      }),
    );
  }
}
