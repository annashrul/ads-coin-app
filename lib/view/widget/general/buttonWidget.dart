import 'package:adscoin/config/color_config.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'touchWidget.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class RedButtonWidget extends StatelessWidget {
  Function callback;
  Widget child;
  RedButtonWidget({@required this.callback,@required this.child});
  @override
  Widget build(BuildContext context) {
    ScreenScaler scale= ScreenScaler()..init(context);
    return  Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: ColorConfig.redColor
      ),
      child: InTouchWidget(
          callback:(){this.callback();},
          child: Container(
              padding: scale.getPadding(0.8, 3),
              child: this.child
          )
      ),
    );
  }
}


class BorderButtonWidget extends StatelessWidget {
  final Function callback;
  final Color borderColor;
  final String title;
  BorderButtonWidget({this.callback,this.borderColor,this.title});

  @override
  Widget build(BuildContext context) {
    ScreenScaler scale= ScreenScaler()..init(context);
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color:borderColor )
      ),
      child: InTouchWidget(
        radius: 10,
        callback: (){callback();},
        child: Container(
          width: scale.getWidth(100),
          padding: scale.getPadding(1, 3),
          child: Center(
            child: Text(title,style: Theme.of(context).textTheme.headline1.copyWith(color:borderColor)),
          ),
        ),
      ),
    );
  }
}



class BackroundButtonWidget extends StatelessWidget {
  final Function callback;
  final Color color;
  final Color backgroundColor;
  final String title;
  EdgeInsetsGeometry padding;
  BackroundButtonWidget({this.callback,this.color,this.title,this.backgroundColor,this.padding});

  @override
  Widget build(BuildContext context) {
    ScreenScaler scale= ScreenScaler()..init(context);
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color:backgroundColor )
      ),
      child: InTouchWidget(
        radius: 10,
        callback: (){callback();},
        child: Container(
          width: scale.getWidth(100),
          padding: padding==null?scale.getPadding(1, 3):padding,
          child: Text(title,style: Theme.of(context).textTheme.headline1.copyWith(color:color==null?ColorConfig.graySecondaryColor:color),textAlign: TextAlign.center,),
        ),
      ),
    );
  }
}


