import 'package:flutter/material.dart';
import 'package:menig_dokonim/widgets/product_item.dart';
import 'package:provider/provider.dart';

import '../models/product_model.dart';
import '../provider/products.dart';

class ProductGrid extends StatelessWidget {
  final bool showOnlyFavorite;
  const ProductGrid({Key? key, required this.showOnlyFavorite}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context,listen: false,);
    final product = productData.list;
    return
    Consumer<Products>(builder: (context,product,child){
      final ps=showOnlyFavorite?product.favorites:product.list;
      return
      ps.isNotEmpty?
        GridView.builder(

          padding:const EdgeInsets.all(16),
          itemCount: ps.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: 50,
            crossAxisSpacing: 200,
            childAspectRatio: 3 / 2,
            crossAxisCount: 1,
          ),
          itemBuilder: (context, index) => ChangeNotifierProvider<Product>.value(
            value: ps[index],
            child:const ProductItem(),
          ),
        ):const Center(child: Text("Sevimlilar yo'q"),);
    });



  }
}
