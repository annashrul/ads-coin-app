import 'package:adscoin/config/color_config.dart';
import 'package:adscoin/config/string_config.dart';
import 'package:adscoin/helper/formatCurrencyHelper.dart';
import 'package:adscoin/helper/functionalWidgetHelper.dart';
import 'package:adscoin/model/fintech/topUp/detailTopUpModel.dart';
import 'package:adscoin/service/provider/fintechProvider.dart';
import 'package:adscoin/view/widget/general/buttonWidget.dart';
import 'package:adscoin/view/widget/general/cardTitleAction.dart';
import 'package:adscoin/view/widget/general/imageRoundedWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:provider/provider.dart';

import '../../successComponent.dart';

class DetailTopUpComponent extends StatefulWidget {
  @override
  _DetailTopUpComponentState createState() => _DetailTopUpComponentState();
}

class _DetailTopUpComponentState extends State<DetailTopUpComponent> with TickerProviderStateMixin  {
  AnimationController _controller;
  int levelClock = 86400;
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this,
        duration: Duration(seconds:levelClock)
    );
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    ScreenScaler scale = ScreenScaler()..init(context);
    final fintech = Provider.of<FintechProvider>(context);

    return Scaffold(
      appBar: FunctionalWidget.appBarHelper(context: context,title: "Informasi pembayaran"),
      body: ListView(
        padding: scale.getPadding(1,2.5),
        children: [
          Image.asset( GeneralString.imgLocalPng+"paymentInfo.png",height:  scale.getHeight(20),),
          FunctionalWidget.wrapContent(
            child: Padding(
              padding: scale.getPadding(1,2),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Bank tujuan",style: Theme.of(context).textTheme.subtitle1),
                  SizedBox(height: scale.getHeight(1)),
                  CardTitleAction(
                    image: GeneralString.dummyImgProduct,
                    title: "Bank mandiri",
                  ),
                  SizedBox(height: scale.getHeight(1)),
                  Text("Nomor rekening",style: Theme.of(context).textTheme.subtitle1),
                  Text("13800110101010",style: Theme.of(context).textTheme.headline2),
                  Divider(),
                  Text("Nama pemilik",style: Theme.of(context).textTheme.subtitle1),
                  Text("Ads Coin",style: Theme.of(context).textTheme.headline2),
                  Divider(),
                  Text("Jumlah rupiah",style: Theme.of(context).textTheme.subtitle1),
                  Text("Rp "+MoneyFormat.toCurrency(double.parse("1000000")),style: Theme.of(context).textTheme.headline2.copyWith(color: ColorConfig.bluePrimaryColor,fontWeight: FontWeight.bold)),
                  Divider(),
                  Text("Jumlah coin",style: Theme.of(context).textTheme.subtitle1),
                  Text(MoneyFormat.toCurrency(double.parse("50"))+" coin",style: Theme.of(context).textTheme.headline2.copyWith(color: ColorConfig.bluePrimaryColor,fontWeight: FontWeight.bold)),
                ],
              ),
            )
          ),
          SizedBox(height: scale.getHeight(1)),
          FunctionalWidget.wrapContent(
            child: Padding(
              padding: scale.getPadding(1,2),
              child: Column(
                children: [
                  Text("Lakukan pembayaran sebelum 12 Agustus 2021",style: Theme.of(context).textTheme.subtitle1),
                  SizedBox(height: scale.getHeight(1)),
                  Countdown(animation: StepTween(begin: levelClock, end: 0).animate(_controller))
                ],
              ),
            )
          ),
        ],
      ),
      bottomNavigationBar:Container(
        padding: scale.getPadding(1, 2.5),
        child:BackroundButtonWidget(
          backgroundColor: ColorConfig.redColor,
          color:ColorConfig.graySecondaryColor,
          title: "Bayar",
          callback: (){
            FunctionalWidget.modal(
                context: context,
                child: SuccessComponent(
                  callback: ()=>Navigator.of(context).pushNamedAndRemoveUntil(RouteString.main, (route) => false,arguments: TabIndexString.tabHome),
                )
            );
          },
        ),
      )
    );
  }
}
// ignore: must_be_immutable
class Countdown extends AnimatedWidget {
  Countdown({Key key, this.animation}) : super(key: key, listenable: animation);
  Animation<int> animation;

  @override
  build(BuildContext context) {
    Duration clockTimer = Duration(seconds: animation.value);
    String timerText = '${clockTimer.inHours.remainder(60).toString()} : ${clockTimer.inMinutes.remainder(60).toString()} : ${clockTimer.inSeconds.remainder(60).toString().padLeft(2, '0')}';
    // return config.MyFont.title(context: context,text:"$timerText",fontSize: 12);
    return Text("$timerText",style: Theme.of(context).textTheme.headline1.copyWith(color: ColorConfig.yellowColor,fontSize: 24));
  }
}
