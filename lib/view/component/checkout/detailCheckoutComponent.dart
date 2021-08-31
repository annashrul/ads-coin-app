import 'package:adscoin/config/color_config.dart';
import 'package:adscoin/config/string_config.dart';
import 'package:adscoin/helper/functionalWidgetHelper.dart';
import 'package:adscoin/view/widget/general/buttonWidget.dart';
import 'package:adscoin/view/widget/general/touchWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';


class DetailCheckoutComponent extends StatefulWidget {
  @override
  _DetailCheckoutComponentState createState() => _DetailCheckoutComponentState();
}

class _DetailCheckoutComponentState extends State<DetailCheckoutComponent> {




  @override
  Widget build(BuildContext context) {
    ScreenScaler scale= ScreenScaler()..init(context);
    return Scaffold(
      body: Padding(
        padding: scale.getPadding(1,2),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: scale.getPadding(2,4),
                decoration: BoxDecoration(
                    color: ColorConfig.yellowColor,
                    shape: BoxShape.circle
                ),
                child: Icon(FlutterIcons.check_outline_mco,size: scale.getTextSize(20),color: ColorConfig.graySecondaryColor,),
              ),
              SizedBox(height:scale.getHeight(2)),
              Text("CopyWriting berhasil dipesan",style: Theme.of(context).textTheme.headline1),
              SizedBox(height:scale.getHeight(2)),
              SmoothStarRating(
                  allowHalfRating: false,
                  onRated: (v) {
                    // rateWithCaption(v);
                  },
                  starCount: 5,
                  rating: 5,
                  size: scale.getTextSize(20),
                  isReadOnly:false,
                  color:ColorConfig.yellowColor,
                  borderColor:ColorConfig.yellowColor,
                  spacing:0.0
              ),

              SizedBox(height:scale.getHeight(8)),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: ColorConfig.redColor,
                    border: Border.all(color: ColorConfig.redColor)

                ),
                child: InTouchWidget(
                  radius: 10,
                  callback:(){},
                  child: Container(
                    width: scale.getWidth(100),
                    padding: scale.getPadding(0.8, 3),
                    child: Center(
                      child: Text("Detail pembelian",style: Theme.of(context).textTheme.headline1.copyWith(color: ColorConfig.graySecondaryColor)),
                    )
                  )
                ),
              ),
              SizedBox(height:scale.getHeight(1)),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Color(0xFF2D9CDB))
                ),
                child: InTouchWidget(
                  radius: 10,
                  callback: ()=>FunctionalWidget.backToHome(context),
                  child: Container(
                    width: scale.getWidth(100),
                    padding: scale.getPadding(0.8, 3),
                    child: Center(
                      child: Text("Selesai",style: Theme.of(context).textTheme.headline1.copyWith(color: Color(0xFF2D9CDB))),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
