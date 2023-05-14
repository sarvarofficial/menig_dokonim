import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import '../models/product_model.dart';
import 'package:http/http.dart' as http;

class Products with ChangeNotifier {
   List<Product> _list = [
    // Product(
    //     id: "p1",
    //     title: "Macbook Pro",
    //     description: "Ajoyib Macbook Pro",
    //     imageUrl:
    //         'https://images.unsplash.com/photo-1580522154071-c6ca47a859ad?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80',
    //     price: 2000),
    // Product(
    //     id: "p2",
    //     title: "Iphone 14 Pro Max",
    //     description: "Ajoyib Macbook Pro",
    //     imageUrl:
    //         'https://images.unsplash.com/photo-1664478546384-d57ffe74a78c?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80',
    //     price: 2000),
    // Product(
    //     id: "p3",
    //     title: "Apple Watch 8",
    //     description: "Ajoyib Macbook Pro",
    //     imageUrl:
    //         'https://images.unsplash.com/photo-1542541864-0381470f4807?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=435&q=80',
    //     price: 2000),
  ];

  Products();

  List<Product> get list {
    return [..._list];
  }

  List<Product> get favorites {
    return list.where((product) => product.isFavorite).toList();
  }

  Future<void> getProducts() async {
    var url = Uri.parse(
        'https://fir-app-edb74-default-rtdb.firebaseio.com/products.json');
    try {
      final response = await http.get(url);

      if(jsonDecode(response.body)!=null){
          final data = jsonDecode(response.body) as Map<String, dynamic>;
          final List<Product> loadedProduct = [];

          data.forEach((productId, productData) {
            loadedProduct.add(Product(
                id: productId,
                title: productData['title'],
                description: productData['description'],
                imageUrl: productData['imageUrl'],
                price: productData['price'],
                isFavorite: productData['isFavourite']
            ),);
          });
          _list=loadedProduct;
          notifyListeners();
        }

    } catch (e) {
      rethrow;
    }
  }

  Future<void> addProduct(Product product) async {
    var url = Uri.parse(
        'https://fir-app-edb74-default-rtdb.firebaseio.com/products.json');

    try {
      final response = await http.post(
        url,
        body: jsonEncode(
          {
            "title": product.title,
            "description": product.description,
            "price": product.price,
            "imageUrl": product.imageUrl,
            "isFavourite": product.isFavorite
          },
        ),
      );
      final name = (jsonDecode(response.body) as Map<String, dynamic>)['name'];
      final newProduct = Product(
        id: name.toString(),
        title: product.title,
        description: product.description,
        imageUrl: product.imageUrl,
        price: product.price,
      );
      _list.add(newProduct);
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future  <void> updateProduct(Product updateProduct) async {
    final productIndex =
        _list.indexWhere((product) => product.id == updateProduct.id);
    if (productIndex >= 0) {
      var url = Uri.parse(
          'https://fir-app-edb74-default-rtdb.firebaseio.com/products/${updateProduct.id}.json');
      try{
      await  http.patch(url,
        body: jsonEncode(
            {

            'title': updateProduct.title,
            'description': updateProduct.description,
            'imageUrl': updateProduct.imageUrl,
            'price': updateProduct.price
          }),);
        _list[productIndex] = updateProduct;
        notifyListeners();
      }catch(e){
        rethrow;
      }


    }

  }

  Future<void> removeProduct(String id) async {
    var url = Uri.parse(
        'https://fir-app-edb74-default-rtdb.firebaseio.com/products/$id.json');
    try{
      final productId= _list.firstWhere((product) =>product.id==id );
      final productIndex=_list.indexWhere((product) => product.id==id);
      _list.removeWhere((element) => element.id == id);
      notifyListeners();

      final response=   await http.delete(url);
      if(response.statusCode>=400){
        _list.insert(productIndex, productId);
        notifyListeners();

        throw const HttpException("O'chirishda xatolik");
      }

    }catch(e){
      rethrow;
    }

  }

  Product findById(String productId) {
    return _list.firstWhere((product) => product.id == productId);
    notifyListeners();
  }
}
