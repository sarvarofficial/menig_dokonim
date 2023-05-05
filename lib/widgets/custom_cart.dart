import 'package:flutter/material.dart';
class CustomCart extends StatelessWidget {
  final String number;
  final Widget child;


  const CustomCart({Key? key, required this.number, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
      child,
        Positioned(
          top: 8,
            right: 16,
            child: Container(
              alignment: Alignment.center,
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: Colors.red,
            shape: BoxShape.circle
          ),
              child: Text(number,style: TextStyle(fontSize: 10),),
        )
        )
      ],
    );
  }
}
