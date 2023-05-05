import 'package:flutter/material.dart';
import 'package:menig_dokonim/screens/home_page.dart';
import 'package:menig_dokonim/screens/manage_roduct_screen.dart';
import 'package:menig_dokonim/screens/order_screen.dart';
class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return  Drawer(


          child: Column(

            children: [
            AppBar(
              centerTitle: true,
              automaticallyImplyLeading: false,
              title:const Text("Salom do'stim",style: TextStyle(fontSize: 20),),
            ),
              ListTile(
                onTap: (){Navigator.of(context).pushReplacementNamed(HomePage.routName);},
                leading: const Icon(Icons.shop),
                title: const Text("Mahsulotlar"),
              ),
             const Divider(),
              ListTile(
                onTap: (){Navigator.of(context).pushReplacementNamed(OrderScreen.routName);},
                leading: const Icon(Icons.shopping_bag_outlined),
                title: const Text("Buyurtmalar"),
              ),
              const Divider(),

              ListTile(
                onTap: (){Navigator.of(context).pushNamed(ManageProductScreen.routName);},
                leading: const Icon(Icons.apps),
                title: const Text("Mahsulotlar boshqaruvi"),
              ),
              const Divider(),
            ],
          ),
    );
  }
}
