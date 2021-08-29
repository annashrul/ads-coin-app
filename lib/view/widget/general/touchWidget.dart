import 'package:adscoin/helper/touchEffectHelper.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class InTouchWidget extends StatelessWidget {
  Function callback;
  double radius;
  Widget child;
  InTouchWidget({@required this.callback,this.radius,@required this.child});

  @override
  Widget build(BuildContext context) {
    return TouchRippleEffect(
      backgroundColor: Colors.transparent,
      borderRadius: BorderRadius.circular(radius!=null?radius:0),
      rippleColor: Color(0xFFD3D3D3),
      onTap: callback,
      child: child,
    );
  }
}
