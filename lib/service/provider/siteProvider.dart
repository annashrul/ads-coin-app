
import 'package:adscoin/model/site/allBankModel.dart';
import 'package:adscoin/model/site/bankCompanyModel.dart';
import 'package:adscoin/service/httpService.dart';
import 'package:flutter/cupertino.dart';

class SiteProvider with ChangeNotifier{
  BankCompanyModel bankCompanyModel;
  AllBankModel allBankModel;
  bool isLoadingBank=true,isLoadingAllBank=true;
  int indexAllBank=0;
  setIndexAllBank(input){
    indexAllBank=input;
    notifyListeners();
  }


  Future getBank({BuildContext context})async{
    if(bankCompanyModel==null) isLoadingBank=true;
    final res = await HttpService().get(url: "bank",context: context);
    isLoadingBank=false;
    if(res["result"].length>0){
      BankCompanyModel result=BankCompanyModel.fromJson(res);
      bankCompanyModel=result;
      notifyListeners();
    }else{
      bankCompanyModel=null;
      notifyListeners();
    }
  }
  Future getAllBank({BuildContext context})async{
    if(allBankModel==null) isLoadingAllBank=true;
    final res = await HttpService().get(url: "bank/data",context: context);
    isLoadingAllBank=false;
    if(res["result"].length>0){
      AllBankModel result=AllBankModel.fromJson(res);
      allBankModel=result;
      notifyListeners();
    }else{
      allBankModel=null;
      notifyListeners();
    }
  }

}