import 'package:flutter/material.dart';
import 'package:menig_dokonim/widgets/product_item.dart';
import 'package:provider/provider.dart';

import '../models/product_model.dart';
import '../provider/products.dart';

class ProductGrid extends StatefulWidget {
  final bool showOnlyFavorite;

  const ProductGrid({Key? key, required this.showOnlyFavorite})
      : super(key: key);

  @override
  State<ProductGrid> createState() => _ProductGridState();
}

class _ProductGridState extends State<ProductGrid> {
  var _init = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    if (_init) {
    setState(() {
      _isLoading = true;

    });
      Provider.of<Products>(context, listen: false).getProducts().then(
            (value) {
              setState(() {
                _isLoading = false;
              });
            }
          );
    }
    _init = false;

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(
      context,
      listen: false,
    );
    final product = productData.list;
    return Consumer<Products>(builder: (context, product, child) {
      final ps = widget.showOnlyFavorite ? product.favorites : product.list;
      return _isLoading? const Center(child: CircularProgressIndicator(),) :ps.isNotEmpty
          ? GridView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: ps.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 50,
                crossAxisSpacing: 200,
                childAspectRatio: 3 / 2,
                crossAxisCount: 1,
              ),
              itemBuilder: (context, index) =>
                  ChangeNotifierProvider<Product>.value(
                value: ps[index],
                child: const ProductItem(),
              ),
            )
          : const Center(
              child: Text("Mahsulotlar yo'q"),
            );
    });
  }
}
