
import 'package:adscoin/model/site/allBankModel.dart';
import 'package:adscoin/model/site/bankCompanyModel.dart';
import 'package:adscoin/model/site/configInfoModel.dart';
import 'package:adscoin/model/site/configModel.dart';
import 'package:adscoin/service/httpService.dart';
import 'package:flutter/cupertino.dart';

class SiteProvider with ChangeNotifier{
  BankCompanyModel bankCompanyModel;
  AllBankModel allBankModel;
  ConfigModel configModel;
  ConfigInfoModel configInfoModel;
  bool isLoadingBank=true,isLoadingAllBank=true,isLoadingConfig=true,isLoadingConfigInfo=true;
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
  Future getConfig({BuildContext context})async{
    if(configModel==null) isLoadingConfig=true;
    final res = await HttpService().get(url: "site/config",context: context);
    print(res);
    isLoadingConfig=false;
    ConfigModel result=ConfigModel.fromJson(res);
    configModel=result;
    notifyListeners();
  }
  Future getConfigInfo({BuildContext context})async{
    if(configInfoModel==null) isLoadingConfigInfo=true;
    final res = await HttpService().get(url: "site/config/info",context: context);
    print(res);
    isLoadingConfigInfo=false;
    ConfigInfoModel result=ConfigInfoModel.fromJson(res);
    configInfoModel=result;
    notifyListeners();
  }


}