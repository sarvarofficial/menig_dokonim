import 'package:flutter/material.dart';

import '../models/cart_item.dart';

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int itemsCount() {
    return _items.length;
  }


  void addToCart(
      String productId,
      String title,
      String image,
      double price,
      ) {
    if (_items.containsKey(productId)) {
      // ... sonini ko'paytir
      _items.update(
        productId,
            (currentProduct) => CartItem(
          id: currentProduct.id,
          title: currentProduct.title,
          quantity: currentProduct.quantity + 1,
          price: currentProduct.price,
          image: currentProduct.image,
        ),
      );
    } else {
      // yangi mahsulot savatchaga qushilmoqda
      _items.putIfAbsent(
        productId,
            () => CartItem(
          id: UniqueKey().toString(),
          title: title,
          quantity: 1,
          price: price,
          image: image,
        ),
      );
    }
    notifyListeners();
  }


  double totalPrice() {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void singleItemsRemove(String productId,{bool isCartButton=false}) {
    if (!_items.containsKey(productId)) {
      return;
    }
    if (_items[productId]!.quantity > 1) {
      _items.update(
        productId,
        (currentProduct) => CartItem(
          id: currentProduct.id,
          title: currentProduct.title,
          image: currentProduct.image,
          price: currentProduct.price,
          quantity: currentProduct.quantity - 1,
        ),
      );

    }else if(isCartButton){
      _items.remove(productId);
    }
    notifyListeners();
  }
  void removeItem(String productId){
    _items.remove(productId);
    notifyListeners();
  }
  void clearItems(){
    _items.clear();
    notifyListeners();
  }
}
