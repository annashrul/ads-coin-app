import 'package:adscoin/config/color_config.dart';
import 'package:adscoin/helper/ScreenScaleHelper.dart';
import 'package:adscoin/view/widget/general/touchWidget.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CardAction extends StatelessWidget {
  Function callback;
  IconData icon;
  String title;
  Color colorIcon;
  CardAction({this.icon,this.title,this.colorIcon,this.callback});
  @override
  Widget build(BuildContext context) {
    ScreenScaleHelper scale= ScreenScaleHelper()..init(context);
    return InTouchWidget(
        callback: (){callback();},
        child: Padding(
          padding: scale.getPadding(1,2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(icon,size: scale.getTextSize(10),color:colorIcon==null?ColorConfig.graySecondaryColor:colorIcon),
                  SizedBox(width: scale.getWidth(3)),
                  Text(title,style: Theme.of(context).textTheme.headline2),
                ],
              ),
              Icon(Icons.arrow_forward_ios_outlined,size: scale.getTextSize(10),color: ColorConfig.graySecondaryColor,),
            ],
          ),
        )
    );
  }
}
