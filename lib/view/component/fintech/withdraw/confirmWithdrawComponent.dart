import 'package:adscoin/config/color_config.dart';
import 'package:adscoin/config/string_config.dart';
import 'package:adscoin/helper/borderDashedHelper.dart';
import 'package:adscoin/helper/formatCurrencyHelper.dart';
import 'package:adscoin/helper/functionalWidgetHelper.dart';
import 'package:adscoin/view/component/successComponent.dart';
import 'package:adscoin/view/widget/general/buttonWidget.dart';
import 'package:adscoin/view/widget/general/cardTitleAction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';

class ConfirmWithdrawComponent extends StatefulWidget {
  @override
  _ConfirmWithdrawComponentState createState() =>
      _ConfirmWithdrawComponentState();
}

class _ConfirmWithdrawComponentState extends State<ConfirmWithdrawComponent> {
  @override
  Widget build(BuildContext context) {
    ScreenScaler scale = ScreenScaler()..init(context);
    return Scaffold(
      appBar: FunctionalWidget.appBarHelper(
          context: context, title: "Konfirmasi penarikan"),
      body: ListView(
        padding: scale.getPadding(1, 2.5),
        children: [
          Text("Total pengurangan",
              style: Theme.of(context)
                  .textTheme
                  .headline2
                  .copyWith(color: ColorConfig.grayPrimaryColor)),
          Text(MoneyFormat.toCurrency(double.parse("10000")),
              style: Theme.of(context)
                  .textTheme
                  .headline1
                  .copyWith(color: ColorConfig.bluePrimaryColor)),
          SizedBox(height: scale.getHeight(1)),
          Text("Tarik tunai",
              style: Theme.of(context)
                  .textTheme
                  .headline2
                  .copyWith(color: ColorConfig.grayPrimaryColor)),
          SizedBox(height: scale.getHeight(0.5)),
          CardTitleAction(
            image: GeneralString.dummyImgProduct,
            title: "Bank mandiri",
          ),
          SizedBox(height: scale.getHeight(1)),
          FunctionalWidget.wrapContent(
              child: Padding(
            padding: scale.getPadding(1, 2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Ringkasan penarikan",
                    style: Theme.of(context).textTheme.headline2),
                SizedBox(height: scale.getHeight(1)),
                FunctionalWidget.betweenText(
                    context: context, title: "Jumlah", desc: "Rp 500000"),
                SizedBox(height: scale.getHeight(0.5)),
                FunctionalWidget.betweenText(
                    context: context, title: "Admin", desc: "Rp 500000"),
                SizedBox(height: scale.getHeight(0.5)),
                SizedBox(
                  width: double.infinity,
                  height: scale.getHeight(0.1),
                  child: DashedRect(
                    color: ColorConfig.graySecondaryColor,
                    strokeWidth: 1.0,
                    gap: 3.0,
                  ),
                ),
                SizedBox(height: scale.getHeight(0.5)),
                FunctionalWidget.betweenText(
                    context: context,
                    title: "Subtotal",
                    desc: "Rp 500000",
                    color: ColorConfig.blackPrimaryColor),
              ],
            ),
          )),
          SizedBox(height: scale.getHeight(1)),
          BackroundButtonWidget(
            color: ColorConfig.graySecondaryColor,
            backgroundColor: ColorConfig.redColor,
            title: "Lanjut",
            callback: () async {
              FunctionalWidget.modal(
                  context: context,
                  child: SuccessComponent(
                    callback: () => Navigator.of(context)
                        .pushNamedAndRemoveUntil(
                            RouteString.main, (route) => false,
                            arguments: TabIndexString.tabHome),
                  ));
            },
          )
        ],
      ),
    );
  }
}
