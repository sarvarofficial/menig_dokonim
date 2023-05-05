import 'package:flutter/material.dart';

import '../models/cart_item.dart';
import '../models/order.dart';

class Orders with ChangeNotifier {
  List<Order> _list = [];

  List<Order> get list {
    return [..._list];
  }

  void addToOrders(List<CartItem> products, double totalPrice) {
    _list.insert(
        0,
        Order(
            id: UniqueKey().toString(),
            totalPrice: totalPrice,
            date: DateTime.now(),
            products: products));
    notifyListeners();
  }
}
