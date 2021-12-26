import 'package:adscoin/config/string_config.dart';
import 'package:adscoin/helper/functionalWidgetHelper.dart';
import 'package:adscoin/model/fintech/topUp/detailTopUpModel.dart';
import 'package:adscoin/service/httpService.dart';
import 'package:adscoin/view/component/successComponent.dart';
import 'package:flutter/cupertino.dart';

class FintechProvider with ChangeNotifier {
  DetailTopUpModel detailTopUpModel;
  Future createTopUp({BuildContext context, dynamic field}) async {
    final store = {
      "payment_channel": field["paymentCode"],
      "amount": field["amount"].toString(),
      "member_pin": field["pin"].toString()
    };
    final res = await HttpService().post(
        url: "transaction/deposit",
        data: store,
        context: context,
        callback: () {
          Navigator.of(context).pop();
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        });
    if (res != null) {
      DetailTopUpModel result = DetailTopUpModel.fromJson(res);
      detailTopUpModel = result;
      Navigator.of(context).pushNamed(RouteString.detailTopUp);
      notifyListeners();
    }
  }

  Future createWithDraw({BuildContext context, dynamic data}) async {
    final res = await HttpService().post(
        url: "transaction/withdrawal",
        data: data,
        context: context,
        callback: () {
          Navigator.of(context).pop();
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        });
    if (res != null) {
      FunctionalWidget.modal(
          context: context,
          child: SuccessComponent(
            callback: () => Navigator.of(context).pushNamedAndRemoveUntil(
                RouteString.main, (route) => false,
                arguments: TabIndexString.tabHome),
          ));
      notifyListeners();
    }
  }

  Future refreshStatus({BuildContext context}) async {
    FunctionalWidget.loadingDialog(context);
    final res = await HttpService().get(
        url:
            "transaction/payment/check/${FunctionalWidget.btoa(detailTopUpModel.result.invoiceNo)}",
        context: context);
    print(res["result"]);
    Navigator.of(context).pop();
    if (res["result"]["status"] == 1) {
      FunctionalWidget.nofitDialog(
          context: context,
          msg: res["msg"],
          callback2: () => FunctionalWidget.backToHome(context),
          label2: "Beranda");
    } else {
      FunctionalWidget.toast(context: context, msg: res["msg"]);
    }
    notifyListeners();
  }

  Future uploadBuktiTransfer({BuildContext context, dynamic data}) async {
    final store = {"bukti": data};
    await HttpService().put(
        url:
            "transaction/deposit/${FunctionalWidget.btoa(detailTopUpModel.result.invoiceNo)}",
        data: store,
        context: context);

    FunctionalWidget.nofitDialog(
        context: context,
        msg: "upload bukti transfer berhasil",
        callback2: () => FunctionalWidget.backToHome(context),
        label2: "Beranda");
    notifyListeners();
  }

  Future getPayment({BuildContext context, dynamic invoiceCode}) async {
    FunctionalWidget.loadingDialog(context);
    final res = await HttpService().get(
        url: "transaction/get_payment/${FunctionalWidget.btoa(invoiceCode)}",
        context: context);
    Navigator.of(context).pop();
    DetailTopUpModel result = DetailTopUpModel.fromJson(res);
    detailTopUpModel = result;
    Navigator.of(context).pushNamed(RouteString.detailTopUp);
    notifyListeners();
  }
}
