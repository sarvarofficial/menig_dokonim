import 'package:flutter/material.dart';

import '../models/product_model.dart';

class Products with ChangeNotifier {
  final List<Product> _list = [
    Product(
        id: "p1",
        title: "Macbook Pro",
        description: "Ajoyib Macbook Pro",
        imageUrl:
            'https://images.unsplash.com/photo-1580522154071-c6ca47a859ad?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80',
        price: 2000),
    Product(
        id: "p2",
        title: "Iphone 14 Pro Max",
        description: "Ajoyib Macbook Pro",
        imageUrl:
            'https://images.unsplash.com/photo-1664478546384-d57ffe74a78c?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80',
        price: 2000),
    Product(
        id: "p3",
        title: "Apple Watch 8",
        description: "Ajoyib Macbook Pro",
        imageUrl:
            'https://images.unsplash.com/photo-1542541864-0381470f4807?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=435&q=80',
        price: 2000),
  ];

  Products();

  List<Product> get list {
    return [..._list];
  }

  List<Product> get favorites {
    return list.where((product) => product.isFavorite).toList();
  }

  void addProduct(Product product) {
    final newProduct = Product(
      id: UniqueKey().toString(),
      title: product.title,
      description: product.description,
      imageUrl: product.imageUrl,
      price: product.price,
    );
    _list.add(newProduct);
    notifyListeners();
  }

  void updateProduct(Product updateProduct) {
    final productIndex =
        _list.indexWhere((product) => product.id == updateProduct.id);
    if (productIndex >=0) {
      _list[productIndex] = updateProduct;
    }
    notifyListeners();
  }
void removeProduct(String id){
    _list.removeWhere((element) => element.id==id);
    notifyListeners();
}
  Product findById(String productId){
    return _list.firstWhere((product) => product.id==productId);
    notifyListeners();
  }
}
