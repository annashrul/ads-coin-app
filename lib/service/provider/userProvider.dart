

import 'package:adscoin/config/string_config.dart';
import 'package:adscoin/database/databaseInit.dart';
import 'package:adscoin/database/table.dart';
import 'package:adscoin/helper/functionalWidgetHelper.dart';
import 'package:adscoin/helper/validateFormHelper.dart';
import 'package:adscoin/model/member/detailMemberModel.dart';
import 'package:adscoin/model/member/leaderBoardModel.dart';
import 'package:adscoin/model/member/listReferralMember.dart';
import 'package:adscoin/model/member/memberSearchModel.dart';
import 'package:adscoin/model/member/profilePerMemberModel.dart';
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
  dynamic idType="";
  dynamic saldo="";

  String anySearchMember="";

  DatabaseInit db = new DatabaseInit();
  bool isLoadingLeaderBoard=true,isLoadingDetailMember=true,isLoadingListReferral=true,isLoadingSearchMember=true;
  bool isLoadMoreSearchMember=false,isLoadMoreListReferral=false;
  int perPageSearchMember=10,perPageListReferral=10;
  LeaderBoardModel leaderBoardModel;
  DetailMemberModel detailMemberModel;
  ListReferralMember listReferralMember;
  MemberSearchModel memberSearchModel;

  getDetailMember({BuildContext context})async{
    if(detailMemberModel==null) isLoadingDetailMember=true;
    final res = await HttpService().get(url: "member/get/$idUser",context: context);
    DetailMemberModel result=DetailMemberModel.fromJson(res);
    detailMemberModel=result;
    idUser = detailMemberModel.result.id;
    photo =detailMemberModel.result.foto;
    name =detailMemberModel.result.fullname;
    mobileNo =detailMemberModel.result.mobileNo;
    referral =detailMemberModel.result.referral;
    status =detailMemberModel.result.status;
    type =detailMemberModel.result.type;
    idType =detailMemberModel.result.idType;
    saldo =detailMemberModel.result.saldo;
    isLoadingDetailMember=false;
    notifyListeners();
  }
  getLeaderBoard({BuildContext context})async{
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
  Future<void> getDataUser()async{
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
      notifyListeners();
    }
  }
  ValidateFormHelper valid = new ValidateFormHelper();
  store({BuildContext context,fields})async{
    final res = await HttpService().put(url: "member/$idUser",data: fields,context:context);
    if(res!=null){
      FunctionalWidget.toast(context: context,msg: res["msg"]);
      getDetailMember(context: context);
    }
    notifyListeners();
  }
  Future getListReferral({BuildContext context})async{
    if(listReferralMember==null) isLoadingListReferral=true;
    final res = await HttpService().get(url: "member/referral?page=1&perpage=$perPageListReferral",context: context);
    print("TOTAL ${res["meta"]["total"]}");
    if(res["result"].length>0){
      ListReferralMember result=ListReferralMember.fromJson(res);
      listReferralMember=result;
    }else{
      listReferralMember=null;
    }
    isLoadingListReferral=false;
    isLoadMoreListReferral=false;
    notifyListeners();
  }
  Future getSearchMember({BuildContext context})async{
    String url = "member?kontributor=true";
    if(memberSearchModel==null) isLoadingSearchMember=true;
    if(anySearchMember!="") url+="&q=$anySearchMember";
    final res = await HttpService().get(url: url,context: context);

    if(res["result"].length>0){
      MemberSearchModel result=MemberSearchModel.fromJson(res);
      memberSearchModel=result;
    }else{
      memberSearchModel=null;
    }
    isLoadingSearchMember=false;
    isLoadMoreSearchMember=false;
    notifyListeners();
  }
  loadMoreListReferral(BuildContext context){
    if(perPageListReferral<listReferralMember.meta.total){
      isLoadMoreListReferral=true;
      perPageListReferral+=10;
      getListReferral(context: context);
    }
    else{
      isLoadMoreListReferral=false;
    }
    notifyListeners();
  }


  setAnySearchMember(context,input){
    isLoadingSearchMember=true;
    anySearchMember=input;
    getSearchMember(context: context);
    notifyListeners();
  }
  loadMoreSearchMember(BuildContext context){
    if(perPageSearchMember<memberSearchModel.meta.total){
      isLoadMoreSearchMember=true;
      perPageSearchMember+=10;
      getSearchMember(context: context);
    }
    else{
      isLoadMoreSearchMember=false;
    }
    notifyListeners();
  }
}