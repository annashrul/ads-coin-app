

import 'dart:async';

import 'package:adscoin/config/string_config.dart';
import 'package:adscoin/model/auth/signInModel.dart';
import 'package:adscoin/service/httpService.dart';
import 'package:adscoin/service/provider/userProvider.dart';
import 'package:adscoin/view/component/auth/otpComponent.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class AuthProvider with ChangeNotifier{
  bool isTrue=false;
  int timeCounter = 0;
  bool timeUpFlag = false;
  dynamic dataOtp;
  Timer timer;
  timerUpdate() {
    timer = Timer(const Duration(seconds: 1), () async {
      timeCounter--;
      if (timeCounter != 0){
        timerUpdate();
        notifyListeners();
      }
      else{
        timeCounter=0;
        timeUpFlag = true;
        timer.cancel();
        notifyListeners();
      }
    });
  }

  void setTimer(input){
    timeCounter=input;
    // timerUpdate();
    timeUpFlag=!timeUpFlag;
    notifyListeners();
  }

  Future sendOtp({BuildContext context, dynamic data,bool isRedirect=true})async{
    final res = await HttpService().post(
      url: "auth/otp",
      data: data,
      context: context
    );
    data["otp"] = res["result"]["otp_anying"];
    if(isRedirect){
      Navigator.push(context, CupertinoPageRoute(builder: (context) =>  OtpComponent(
        data: data,
        callback: (otp)async{
          final resLogin = await HttpService().post(
              url: "auth",
              data: {
                "type":"otp",
                "nohp":data["nomor"],
                "otp_code":otp
              },
              context: context
          );
          if(resLogin==null){
            isTrue=true;
            await Future.delayed(Duration(seconds: 1));
            isTrue=false;
          }
          else{
            isTrue=false;
            SignInModel result = SignInModel.fromJson(resLogin);
            final dataUser = result.result;
            final userStorage = Provider.of<UserProvider>(context, listen: false);
            userStorage.setStorage({
              SessionString.sessIsLogin:StatusRoleString.masukAplikasi,
              SessionString.sessId:dataUser.id,
              SessionString.sessToken:dataUser.token,
              SessionString.sessHavePin:dataUser.havePin,
              SessionString.sessPhoto:dataUser.foto,
              SessionString.sessName:dataUser.fullname,
              SessionString.sessMobileNo:dataUser.mobileNo,
              SessionString.sessReferral:dataUser.referral,
              SessionString.sessStatus:dataUser.status,
              SessionString.sessType:dataUser.type,
            });
            Navigator.of(context).pushNamedAndRemoveUntil(RouteString.main, (route) => false,arguments: TabIndexString.tabHome);
          }
          notifyListeners();
        },
        isTrue: isTrue,
      )));
    }
    else{
      setTimer(10);
      notifyListeners();
      timerUpdate();
      print("tidak redirect");
    }
    dataOtp = data;
    notifyListeners();
  }







}