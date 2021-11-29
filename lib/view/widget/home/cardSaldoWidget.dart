import 'package:adscoin/config/color_config.dart';
import 'package:adscoin/config/string_config.dart';
import 'package:adscoin/helper/formatCurrencyHelper.dart';
import 'package:adscoin/helper/functionalWidgetHelper.dart';
import 'package:adscoin/service/provider/historyProvider.dart';
import 'package:adscoin/service/provider/userProvider.dart';
import 'package:adscoin/view/component/loadingComponent.dart';
import 'package:adscoin/view/widget/general/touchWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:provider/provider.dart';


class CardSaldoWidget extends StatefulWidget {
  @override
  _CardSaldoWidgetState createState() => _CardSaldoWidgetState();
}

class _CardSaldoWidgetState extends State<CardSaldoWidget> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    ScreenScaler scale= ScreenScaler()..init(context);
    final user = Provider.of<UserProvider>(context);
    final history = Provider.of<HistoryProvider>(context);

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
                          Row(
                            children: [
                              user.isLoadingDetailMember?BaseLoading(height: 1.5, width:5):Text("${MoneyFormat.toFormat(double.parse(user.saldo))}",style: Theme.of(context).textTheme.headline2.copyWith(color: ColorConfig.blackSecondaryColor,fontWeight:FontWeight.w400)),
                              Text(" coin",style: Theme.of(context).textTheme.subtitle2.copyWith(color: ColorConfig.blackSecondaryColor,fontWeight:FontWeight.w400)),
                            ],
                          ),
                          SizedBox(height: scale.getHeight(0.2),),
                          Text("Saldo AdsCoin",style: Theme.of(context).textTheme.subtitle1),
                        ],
                      )
                    ],
                  ),
                )
            ),
            Container(
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
                        Navigator.of(context).pushNamed(RouteString.historyMutation).then((value) =>  history.getHistoryMutation(context: context,isNow: true));
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
