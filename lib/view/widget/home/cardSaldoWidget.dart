import 'package:adscoin/config/color_config.dart';
import 'package:adscoin/config/string_config.dart';
import 'package:adscoin/view/widget/general/touchWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';


class CardSaldoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenScaler scale= ScreenScaler()..init(context);
    return  Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      margin: EdgeInsets.all(0),
      child: Container(
        padding: scale.getPadding(0, 0),
        height: scale.getHeight(7),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(0),
        ),
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InTouchWidget(
                callback: (){
                  Navigator.of(context).pushNamed(RouteString.indexFintechComponent);
                },
                child: Container(
                  padding: scale.getPadding(0,0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child:Row(
                    children: [
                      Image.asset(GeneralString.imgLocalPng+"wallet.png",height: scale.getHeight(4),),
                      SizedBox(width: 5),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("1.230.0000",style: Theme.of(context).textTheme.headline1.copyWith(color: ColorConfig.blackSecondaryColor,fontWeight:FontWeight.w400)),
                          SizedBox(height: scale.getHeight(0.2),),
                          Text("Saldo AdsCoin",style: Theme.of(context).textTheme.subtitle1),
                        ],
                      )
                    ],
                  ),
                )
            ),
            Container(
              // padding: scale.getPadding(0,2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  cardWallet(
                      context: context,
                      title: "Top Up",
                      image: "topup",
                      callback: (){
                        Navigator.of(context).pushNamed(RouteString.topUp);
                      }
                  ),
                  SizedBox(width: scale.getWidth(3)),
                  cardWallet(
                      context: context,
                      title: "Penarikan",
                      image: "topup",
                      callback: (){
                        Navigator.of(context).pushNamed(RouteString.withdraw);
                      }
                  ),
                  SizedBox(width: scale.getWidth(3)),
                  cardWallet(
                      context: context,
                      title: "Mutasi",
                      image: "history",
                      callback: (){
                        Navigator.of(context).pushNamed(RouteString.historyMutation);
                      }
                  )

                ],
              ),
            )
          ],
        ),
      ),
    );
  }


  Widget cardWallet({BuildContext context,title,Function callback,String image}){
    ScreenScaler scale= ScreenScaler()..init(context);
    return InTouchWidget(
        callback: ()=>callback(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(GeneralString.imgLocalPng+"$image.png",height: scale.getHeight(1.5),),
            // Icon(FlutterIcons.plus_box_mco,color:ColorConfig.graySecondaryColor),
            SizedBox(height: scale.getHeight(0.2),),
            Text(title,style: Theme.of(context).textTheme.subtitle1,)
          ],
        )
    );
  }

}
