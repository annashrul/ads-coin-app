import 'package:adscoin/config/color_config.dart';
import 'package:adscoin/config/string_config.dart';
import 'package:adscoin/view/widget/general/touchWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';

// ignore: must_be_immutable
class CardAction extends StatelessWidget {
  Function callback;
  IconData icon;
  String title;
  Color colorIcon;
  String img;
  Widget actionIcon;
  CardAction({this.icon,this.title,this.colorIcon,this.callback,this.img,this.actionIcon});
  @override
  Widget build(BuildContext context) {
    ScreenScaler scale= ScreenScaler()..init(context);

    return InTouchWidget(
        callback: (){callback();},
        child: Padding(
          padding: scale.getPadding(1,2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  icon==null?Image.asset(GeneralString.imgLocalPng+"$img.png",height: scale.getHeight(2)):Icon(icon,size: scale.getTextSize(10),color:colorIcon==null?ColorConfig.graySecondaryColor:colorIcon),
                  SizedBox(width: scale.getWidth(3)),
                  Text(title,style: Theme.of(context).textTheme.headline2),
                ],
              ),
              actionIcon!=null?actionIcon:Icon(Icons.arrow_forward_ios_outlined,size: scale.getTextSize(10),color: ColorConfig.graySecondaryColor,),
            ],
          ),
        )
    );
  }
}
