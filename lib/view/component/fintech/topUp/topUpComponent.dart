import 'package:adscoin/config/string_config.dart';
import 'package:adscoin/helper/functionalWidgetHelper.dart';
import 'package:adscoin/service/provider/fintechProvider.dart';
import 'package:adscoin/view/component/fintech/methodChannel/methodChannelComponent.dart';
import 'package:adscoin/view/widget/fintech/formFintechWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:provider/provider.dart';

class TopUpComponent extends StatefulWidget {
  @override
  _TopUpComponentState createState() => _TopUpComponentState();
}

class _TopUpComponentState extends State<TopUpComponent> {
  @override
  Widget build(BuildContext context) {
    ScreenScaler scale = ScreenScaler()..init(context);
    final fintech = Provider.of<FintechProvider>(context);

    return Scaffold(
      appBar: FunctionalWidget.appBarHelper(context: context,title: "Top up"),
      body: FormFintechWidget(
        callback: (amount){
          if(amount<50000){
            FunctionalWidget.toast(context: context,msg: "top up minimal Rp 50,000");
          }
          else{
            FunctionalWidget.modal(
              context: context,
              child: Container(
                height: scale.getHeight(80),
                child: MethodChannelComponent(callback: (code){
                  // topUp.create(context: context);
                  Navigator.of(context).pushNamed(RouteString.pin,arguments: (pin){
                    print(pin);
                    fintech.createTopUp(context: context,data: {
                      "paymentCode":code,
                      "pin":pin,
                      "amount":amount
                    });
                  });
                  // Navigator.of(context).pushNamed(RouteString.detailTopUp);
                }),
              )
            );
          }
        },
      ),
    );
  }
}
