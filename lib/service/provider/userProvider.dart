

import 'package:adscoin/config/string_config.dart';
import 'package:adscoin/database/databaseInit.dart';
import 'package:adscoin/database/table.dart';
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

}