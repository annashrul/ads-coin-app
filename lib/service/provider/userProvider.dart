

import 'package:adscoin/config/string_config.dart';
import 'package:adscoin/database/databaseInit.dart';
import 'package:adscoin/database/table.dart';
import 'package:adscoin/helper/functionalWidgetHelper.dart';
import 'package:adscoin/helper/validateFormHelper.dart';
import 'package:adscoin/model/member/detailMemberModel.dart';
import 'package:adscoin/model/member/leaderBoardModel.dart';
import 'package:adscoin/service/httpService.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider with ChangeNotifier{
  int id;
  dynamic isLogin="0";
  dynamic idUser="";
  dynamic token="";
  dynamic havePin="";
  dynamic photo="";
  dynamic name="";
  dynamic mobileNo="";
  dynamic referral="";
  dynamic status="";
  dynamic type="";
  DatabaseInit db = new DatabaseInit();
  bool isLoadingLeaderBoard=true,isLoadingDetailMember=true;
  LeaderBoardModel leaderBoardModel;
  DetailMemberModel detailMemberModel;
  Future getDetailMember({BuildContext context})async{
    if(detailMemberModel==null) isLoadingDetailMember=true;
    final res = await HttpService().get(url: "member/get/$idUser",context: context);
    isLoadingDetailMember=false;
    DetailMemberModel result=DetailMemberModel.fromJson(res);
    detailMemberModel=result;
    notifyListeners();
  }
  Future getLeaderBoard({BuildContext context})async{
    if(leaderBoardModel==null) isLoadingLeaderBoard=true;
    final res = await HttpService().get(url: "member/top_kontributor?page=1&type=penjualan",context: context);
    isLoadingLeaderBoard=false;
    if(res["result"].length>0){
      LeaderBoardModel result=LeaderBoardModel.fromJson(res);
      leaderBoardModel=result;
    }else{
      leaderBoardModel=null;
    }
    notifyListeners();
  }
  Future getDataUser()async{
    final getUser = await db.getData(UserTable.TABLE_NAME);
    if(getUser.length>0){
      id = getUser[0]["id"];
      isLogin = getUser[0][SessionString.sessIsLogin];
      idUser =getUser[0][SessionString.sessId];
      token =getUser[0][SessionString.sessToken];
      havePin =getUser[0][SessionString.sessHavePin];
      photo =getUser[0][SessionString.sessPhoto];
      name =getUser[0][SessionString.sessName];
      mobileNo =getUser[0][SessionString.sessMobileNo];
      referral =getUser[0][SessionString.sessReferral];
      status =getUser[0][SessionString.sessStatus];
      type =getUser[0][SessionString.sessType];
    }
    notifyListeners();
  }
  ValidateFormHelper valid = new ValidateFormHelper();
  Future store({BuildContext context,fields})async{
    final isValid = valid.validateEmptyForm(context: context,field:fields);
    if(isValid){
      final res = await HttpService().put(url: "member/$idUser",data: fields,context:context);
      print("horeeeeeee $res");
      FunctionalWidget.toast(context: context,msg: res["msg"]);
      getDetailMember(context: context);
      notifyListeners();
    }
    notifyListeners();
  }
}