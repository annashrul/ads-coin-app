import 'package:adscoin/service/provider/productProvider.dart';
import 'package:adscoin/view/widget/general/cardAction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';

class ModalStatusFormProductWidget extends StatefulWidget {
  @override
  _ModalStatusFormProductWidgetState createState() => _ModalStatusFormProductWidgetState();
}

class _ModalStatusFormProductWidgetState extends State<ModalStatusFormProductWidget> {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<ProductProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        CardAction(
          colorIcon: Colors.black,
          img: "Paper",
          title: "Draft",
          callback: ()async{
            product.setStatusProduct(0);
            Navigator.of(context).pop();
          },
        ),
        CardAction(
          colorIcon: Colors.black,
          img: "TickSquare",
          title: "Publish",
          callback: ()async{
            product.setStatusProduct(1);
            Navigator.of(context).pop();

          },
        ),
      ],
    );
  }
}
