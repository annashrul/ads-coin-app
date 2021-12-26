import 'package:adscoin/helper/functionalWidgetHelper.dart';
import 'package:adscoin/service/provider/fintechProvider.dart';
import 'package:adscoin/service/provider/siteProvider.dart';
import 'package:adscoin/view/component/auth/pinComponent.dart';
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
  void initState() {
    super.initState();
    final config = Provider.of<SiteProvider>(context, listen: false);
    config.getConfig(context: context);
  }

  @override
  Widget build(BuildContext context) {
    ScreenScaler scale = ScreenScaler()..init(context);
    final fintech = Provider.of<FintechProvider>(context);
    final config = Provider.of<SiteProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: FunctionalWidget.appBarHelper(context: context, title: "Top up"),
      body: FormFintechWidget(
        callback: (amount) {
          if (amount < int.parse(config.configModel.result[0].dpMin)) {
            FunctionalWidget.toast(
                context: context,
                msg:
                    "top up minimal ${config.configModel.result[0].dpMin} coin");
          } else {
            FunctionalWidget.modal(
                context: context,
                child: Container(
                  height: scale.getHeight(80),
                  child: MethodChannelComponent(callback: (code) {
                    FunctionalWidget.modal(
                        context: context,
                        child: PinComponent(callback: (pin) async {
                          await fintech.createTopUp(context: context, field: {
                            "paymentCode": code,
                            "pin": pin,
                            "amount": amount
                          });
                        }));
                  }),
                ));
          }
        },
      ),
    );
  }
}
