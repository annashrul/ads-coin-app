

import 'package:adscoin/config/string_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider with ChangeNotifier{
  dynamic isLogin="0";
  dynamic id="";
  dynamic token="";
  dynamic havePin="";
  dynamic photo="";
  dynamic name="";
  dynamic mobileNo="";
  dynamic referral="";
  dynamic status="";
  dynamic type="";
  Future setStorage(data)async{
    print(data);
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    myPrefs.setString(SessionString.sessIsLogin, data[SessionString.sessIsLogin]);
    myPrefs.setString(SessionString.sessId, data[SessionString.sessId]);
    myPrefs.setString(SessionString.sessToken, data[SessionString.sessToken]);
    myPrefs.setBool(SessionString.sessHavePin, data[SessionString.sessHavePin]);
    myPrefs.setString(SessionString.sessPhoto, data[SessionString.sessPhoto]);
    myPrefs.setString(SessionString.sessName, data[SessionString.sessName]);
    myPrefs.setString(SessionString.sessMobileNo, data[SessionString.sessMobileNo]);
    myPrefs.setString(SessionString.sessReferral, data[SessionString.sessReferral]);
    myPrefs.setInt(SessionString.sessStatus, data[SessionString.sessStatus]);
    myPrefs.setString(SessionString.sessType, data[SessionString.sessType]);
    notifyListeners();
  }


  Future getUser()async{
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    isLogin = myPrefs.getString(SessionString.sessIsLogin);
    id = myPrefs.getString(SessionString.sessId);
    token =  myPrefs.getString(SessionString.sessToken);
    havePin = myPrefs.getBool(SessionString.sessHavePin);
    photo = myPrefs.getString(SessionString.sessPhoto);
    name =  myPrefs.getString(SessionString.sessName);
    mobileNo = myPrefs.getString(SessionString.sessMobileNo);
    referral = myPrefs.getString(SessionString.sessReferral);
    status = myPrefs.getInt(SessionString.sessStatus);
    type = myPrefs.getString(SessionString.sessType);
    notifyListeners();
  }




}