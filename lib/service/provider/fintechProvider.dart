
import 'package:adscoin/config/string_config.dart';
import 'package:adscoin/helper/functionalWidgetHelper.dart';
import 'package:adscoin/model/fintech/topUp/detailTopUpModel.dart';
import 'package:adscoin/service/httpService.dart';
import 'package:adscoin/view/component/successComponent.dart';
import 'package:flutter/cupertino.dart';

class FintechProvider with ChangeNotifier{
  DetailTopUpModel detailTopUpModel;
  Future createTopUp({BuildContext context,dynamic data})async{
    final store = {
      "payment_channel":data["paymentCode"],
      "amount":data["amount"].toString(),
      "member_pin":data["pin"].toString()
    };
    final res = await HttpService().post(url: "transaction/deposit",data: store,context: context);
    if(res!=null){
      DetailTopUpModel result = DetailTopUpModel.fromJson(res.toJson());
      detailTopUpModel = result;
      Navigator.of(context).pushNamed(RouteString.detailTopUp);
      notifyListeners();
    }
  }
  Future createWithDraw({BuildContext context,dynamic data})async{
    final res = await HttpService().post(url: "transaction/withdrawal",data: data,context: context);
    if(res!=null){
      FunctionalWidget.modal(
        context: context,
        child: SuccessComponent(
          callback: ()=>Navigator.of(context).pushNamedAndRemoveUntil(RouteString.main, (route) => false,arguments: TabIndexString.tabHome),
        )
      );
      notifyListeners();
    }
  }
}
