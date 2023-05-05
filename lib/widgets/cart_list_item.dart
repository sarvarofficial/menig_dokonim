import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:menig_dokonim/provider/cart.dart';
import 'package:provider/provider.dart';

class CartListItem extends StatelessWidget {
  final String productId;
  final String image;
  final String title;
  final double price;
  final int quantity;

  const CartListItem(
      {Key? key,
        required this.productId,
        required this.image,
        required this.title,
        required this.price,
        required this.quantity,
      })
      : super(key: key);

  void _notifyUserAbout(BuildContext context,Function() removeItem){
    showDialog(context: context, builder: (ctx){
      return  AlertDialog(
        title:const Text("Ishonchingiz komilmi ?"),
        content: const Text("Savatchadan mahsulot o'chmoqda"),
        actions: [
          TextButton(onPressed: ()=>Navigator.of(context).pop(), child:const Text("BEKOR QILSH")),
          ElevatedButton(onPressed: (){removeItem();Navigator.of(context).pop();}, child: const Text("O'chirish"))
        ],
      );
    });

  }

  @override
  Widget build(BuildContext context) {
    final cart=Provider.of<Cart>(context,listen: false );
    return Slidable(
      endActionPane: ActionPane(
        motion: ScrollMotion(),

        extentRatio: 0.3,
        children: [
          ElevatedButton(onPressed: (){
            _notifyUserAbout(context,
                ()=>cart.removeItem(productId)

            );
          }, child: Text("O'chirish"),style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.error,
            padding: EdgeInsets.symmetric(vertical: 24,horizontal: 24)
          ),)
        ],
      ),

      key: ValueKey(productId),

      child: Card(
        child: ListTile(
          leading: CircleAvatar(backgroundImage: NetworkImage(image),),
          title:Text(title),
          subtitle:Text("Umumiy: \$${(price*quantity).toStringAsFixed(2)}"),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(onPressed: (){cart.singleItemsRemove(productId);}, icon: Icon(Icons.remove)),
              Container(
                alignment: Alignment.center,
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey.shade100
                ),
                child: Text("$quantity"),
              ),
              IconButton(onPressed: (){cart.addToCart(productId, title, image, price);}, icon: Icon(Icons.add)),

            ],
          ),
        ),
      ),
    );
  }
}
