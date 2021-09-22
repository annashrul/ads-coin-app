import 'package:adscoin/model/generalModel.dart';
import 'package:adscoin/model/product/promoModel.dart';
import 'package:adscoin/service/httpService.dart';
import 'package:flutter/cupertino.dart';

class PromoProvider with ChangeNotifier{
  bool isLoadingPromo=true;
  PromoModel promoModel;

  Future checkPromo({BuildContext context})async{
    if(promoModel==null) isLoadingPromo=true;
    final res=await HttpService().get(url: "promo/check",context: context);
    print("######################## PROMO =$res");

    if(res is GeneralModel){
      promoModel=null;
    }else{
      PromoModel result=PromoModel.fromJson(res);
      promoModel = result;
    }
    isLoadingPromo=false;
    notifyListeners();
    print(res);

  }
}