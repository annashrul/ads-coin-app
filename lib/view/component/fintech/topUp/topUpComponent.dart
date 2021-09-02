import 'package:adscoin/config/color_config.dart';
import 'package:adscoin/helper/formatCurrencyHelper.dart';
import 'package:adscoin/helper/functionalWidgetHelper.dart';
import 'package:adscoin/view/component/fintech/methodChannel/methodChannelComponent.dart';
import 'package:adscoin/view/widget/fintech/formFintechWidget.dart';
import 'package:adscoin/view/widget/fintech/modalBankWidget.dart';
import 'package:adscoin/view/widget/fintech/nominalWidget.dart';
import 'package:adscoin/view/widget/general/buttonWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';

class TopUpComponent extends StatefulWidget {
  @override
  _TopUpComponentState createState() => _TopUpComponentState();
}

class _TopUpComponentState extends State<TopUpComponent> {
  @override
  Widget build(BuildContext context) {
    ScreenScaler scale = ScreenScaler()..init(context);
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
                child: MethodChannelComponent(),
              )
            );
          }
        },
      ),
    );
  }
}
