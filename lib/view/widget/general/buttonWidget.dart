import 'package:adscoin/config/color_config.dart';
import 'package:adscoin/helper/ScreenScaleHelper.dart';
import 'touchWidget.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class RedButtonWidget extends StatelessWidget {
  Function callback;
  Widget child;
  RedButtonWidget({@required this.callback,@required this.child});
  @override
  Widget build(BuildContext context) {
    ScreenScaleHelper scale = ScreenScaleHelper()..init(context);
    return  Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: ColorConfig.redColor
      ),
      child: InTouchWidget(
          callback:this.callback,
          child: Container(
            padding: scale.getPadding(0.8, 3),
            child: this.child
          )
      ),
    );
  }
}
