import 'package:adscoin/config/string_config.dart';
import 'package:adscoin/helper/functionalWidgetHelper.dart';
import 'package:adscoin/view/widget/general/cardTitleSubtileAction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';

class MethodChannelComponent extends StatefulWidget {
  @override
  _MethodChannelComponentState createState() => _MethodChannelComponentState();
}

class _MethodChannelComponentState extends State<MethodChannelComponent> {
  @override
  Widget build(BuildContext context) {
    ScreenScaler scale = ScreenScaler()..init(context);

    return Scaffold(
      appBar: FunctionalWidget.appBarHelper(context: context,title: "Metode pembayaran"),
      body: ListView.separated(
        padding: scale.getPadding(1,2.5),
          itemBuilder: (context,index){
            return CardTitleSubtitleAction(
              image: GeneralString.dummyImgProduct,
              title: "Bank mandiri",
              subtitle: "Ads coin",
              callback: (){
                Navigator.of(context).pushNamed(RouteString.detailTopUp);
              },
            );
          },
          separatorBuilder: (context,index){return Divider();},
          itemCount: 100
      )
    );
  }
}
