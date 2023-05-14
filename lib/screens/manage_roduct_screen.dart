import 'package:flutter/material.dart';
import 'package:menig_dokonim/provider/products.dart';
import 'package:menig_dokonim/screens/edit_product_screen.dart';
import 'package:menig_dokonim/widgets/user_product_item.dart';
import 'package:provider/provider.dart';
import '../widgets/app_drawer.dart';

class ManageProductScreen extends StatelessWidget {
  const ManageProductScreen({Key? key}) : super(key: key);
  static const routName='/product-mange-screen';
  Future<void> refresh(BuildContext context) async{
    await Provider.of<Products>(context,listen:  false).getProducts();

  }

  @override
  Widget build(BuildContext context) {
    final productsProvider=Provider.of<Products>(context);
    return Scaffold(

      appBar: AppBar(

        title:const Text("Mahsulotlarni boshqarish"),
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){
            Navigator.of(context).pushNamed(EditProductScreen.routName);
          }, icon: const Icon(Icons.add))
        ],
      ),

      body: RefreshIndicator(
        onRefresh: ()async {
          refresh(context);
        },
        child: ListView.builder(
          itemCount: productsProvider.list.length,
            itemBuilder: (context,index){
           final products=productsProvider.list[index];

          return ChangeNotifierProvider.value(value: products,
          child:const UserProductItem());
        }),
      ),
    );
  }
}
