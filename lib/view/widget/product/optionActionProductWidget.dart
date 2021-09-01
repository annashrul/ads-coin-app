import 'package:adscoin/view/widget/general/cardAction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';

class OptionActionProductWidget extends StatefulWidget {
  @override
  _OptionActionProductWidgetState createState() => _OptionActionProductWidgetState();
}

class _OptionActionProductWidgetState extends State<OptionActionProductWidget> {
  @override
  Widget build(BuildContext context) {
    ScreenScaler scale = ScreenScaler()..init(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        CardAction(
          title: "Edit",
          callback: ()async{
          },
          img: "Edit",
        ),
        CardAction(
          title: "Hapus",
          callback: ()async{
          },
          img: "Delete1",
        ),
        CardAction(
          title: "Ubah menjadi draft",
          callback: ()async{
          },
          img: "analytics1",
          // img: "TickSquare",

        ),
      ],
    );
  }
}
