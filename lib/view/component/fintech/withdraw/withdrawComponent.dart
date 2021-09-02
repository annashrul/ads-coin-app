import 'package:adscoin/helper/functionalWidgetHelper.dart';
import 'package:adscoin/view/component/fintech/methodChannel/methodChannelComponent.dart';
import 'package:adscoin/view/widget/fintech/formFintechWidget.dart';
import 'package:adscoin/view/widget/fintech/modalBankWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';

class WithdrawComponent extends StatefulWidget {
  @override
  _WithdrawComponentState createState() => _WithdrawComponentState();
}

class _WithdrawComponentState extends State<WithdrawComponent> {
  @override
  Widget build(BuildContext context) {
    ScreenScaler scale = ScreenScaler()..init(context);
    return Scaffold(
      appBar: FunctionalWidget.appBarHelper(context: context,title: "Penarikan"),
      body: FormFintechWidget(
        type: false,
        callback: (amount){
          if(amount<50000){
            FunctionalWidget.toast(context: context,msg: "top up minimal Rp 50,000");
          }
          else{
            FunctionalWidget.modal(
                context: context,
                child: ModalBankWidget()
            );
          }
        },
      ),
    );
  }
}
