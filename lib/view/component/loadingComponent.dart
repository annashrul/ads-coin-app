import 'package:adscoin/config/color_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:shimmer/shimmer.dart';


class BaseLoading extends StatelessWidget {
  final double height;
  final double width;
  final double radius;

  BaseLoading({@required this.height,@required this.width,this.radius=10});
  @override
  Widget build(BuildContext context) {
    ScreenScaler scale = ScreenScaler()..init(context);
    return Shimmer.fromColors(
      baseColor: Theme.of(context).unselectedWidgetColor,
      highlightColor: Colors.grey[100],
      enabled: true,
      child: Container(
        width:scale.getWidth(this.width),
        height: scale.getHeight(this.height),
        decoration: BoxDecoration(
          color:Colors.grey[200],
          borderRadius: BorderRadius.all(Radius.circular(this.radius))
        ),
      ),
    );

  }
}


class LoadingProduct extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenScaler scale = ScreenScaler()..init(context);
    return Container(
      margin: scale.getMarginLTRB(0,0,1,0),
      width: scale.getWidth(35),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          BaseLoading(width:42,height:13),
          SizedBox(height: scale.getHeight(0.5)),
          BaseLoading(width:42,height:1),
          SizedBox(height: scale.getHeight(0.5)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BaseLoading(width:20,height:1),
              BaseLoading(width:10,height:1),
            ],
          ),
        ],
      ),
    );

  }
}
