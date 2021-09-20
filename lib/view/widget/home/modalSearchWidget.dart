import 'package:adscoin/config/color_config.dart';
import 'package:adscoin/view/widget/general/buttonWidget.dart';
import 'package:adscoin/view/widget/general/cardAction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';

class ModalSearchWidget extends StatefulWidget {
  Function(String key) callback;
  String any;
  ModalSearchWidget({this.callback,this.any});
  @override
  _ModalSearchWidgetState createState() => _ModalSearchWidgetState();
}

class _ModalSearchWidgetState extends State<ModalSearchWidget> {

  void handleCallback(searchBy){
    widget.callback(searchBy);
    setState(() {
      widget.any = searchBy;
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    ScreenScaler scale = ScreenScaler()..init(context);
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: scale.getPaddingLTRB(2, 1, 2, 0),
            child: Text("Pencarian berdasarkan",style: Theme.of(context).textTheme.headline2,),
          ),
          CardAction(
            title: "produk",
            icon:FlutterIcons.filter_ant,
            callback: ()=>handleCallback("produk"),
            actionIcon: Icon(FlutterIcons.check_ant,color: widget.any=="produk"?ColorConfig.blackSecondaryColor:Colors.transparent),
          ),
          SizedBox(height: scale.getHeight(0)),
          CardAction(
            title: "Kontributor",
            icon: FlutterIcons.filter_ant,
            callback: ()=>handleCallback("kontributor"),
            actionIcon: Icon(FlutterIcons.check_ant,color:widget.any=="kontributor"?ColorConfig.blackSecondaryColor:Colors.transparent),
          )
        ],
      ),
    );
  }
}
