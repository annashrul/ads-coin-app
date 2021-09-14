

import 'dart:async';

import 'package:adscoin/config/string_config.dart';
import 'package:adscoin/database/databaseInit.dart';
import 'package:adscoin/database/table.dart';
import 'package:adscoin/helper/functionalWidgetHelper.dart';
import 'package:adscoin/helper/validateFormHelper.dart';
import 'package:adscoin/model/auth/signInModel.dart';
import 'package:adscoin/service/httpService.dart';
import 'package:adscoin/service/provider/userProvider.dart';
import 'package:adscoin/view/component/auth/otpComponent.dart';
import 'package:adscoin/view/component/profile/disclaimerComponent.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class AuthProvider with ChangeNotifier{
  bool isTrue=false;
  dynamic dataOtp;
  int timeCounter = 0;
  bool timeUpFlag = false;
  Timer timer;
  DatabaseInit db = new DatabaseInit();
  HttpService service = new HttpService();
  ValidateFormHelper valid = new ValidateFormHelper();

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


  postOtp({BuildContext context, dynamic data,Function(String res) callback})async{
    dynamic field={
      "nomor":data["phoneNumber"],
      "type":"otp",
      "nama":"",
      "islogin":data["isLogin"]=="1"?"1":"0",
      "isRegister":data["isLogin"]=="1"?"0":"1",
    };
    final res = await service.post(
        url: "auth/otp",
        data: field,
        context: context
    );
    field["otp"] = res["result"]["otp_anying"];
    dataOtp = field;

    callback(res["result"]["otp_anying"]);
    // print(res);
  }

  Future<void> sendOtp({BuildContext context, dynamic fields,bool isRedirect=true})async{
    final isValid = valid.validateEmptyForm(context: context,field:{"nomor_ponsel":fields["nomor"]});
    if(isValid){
      final res = await service.post(
          url: "auth/otp",
          data: fields,
          context: context
      );
      fields["otp"] = res["result"]["otp_anying"];
      dataOtp = fields;
      if(isRedirect){
        Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
            new CupertinoPageRoute(builder: (BuildContext context)=>OtpComponent(
              callback: (otp) async{
                final resLogin = await service.post(
                    url: "auth",
                    data: {
                      "type":"otp",
                      "nohp":fields["nomor"],
                      "otp_code":otp
                    },
                    context: context
                );
                if(resLogin!=null){
                  isTrue=false;
                  SignInModel result = SignInModel.fromJson(resLogin);
                  final dataUser = result.result;
                  final getUserLocal = await db.getData(UserTable.TABLE_NAME);
                  final storeDataUser =  {
                    SessionString.sessIsLogin:StatusRoleString.masukAplikasi,
                    SessionString.sessId:dataUser.id.toString(),
                    SessionString.sessToken:dataUser.token.toString(),
                    SessionString.sessHavePin:dataUser.havePin.toString(),
                    SessionString.sessPhoto:dataUser.foto.toString(),
                    SessionString.sessName:dataUser.fullname.toString(),
                    SessionString.sessMobileNo:dataUser.mobileNo.toString(),
                    SessionString.sessReferral:dataUser.referral.toString(),
                    SessionString.sessStatus:dataUser.status.toString(),
                    SessionString.sessType:dataUser.type.toString(),
                  };
                  if(getUserLocal.length>0){
                    await db.delete(UserTable.TABLE_NAME);
                    await db.insert(UserTable.TABLE_NAME,storeDataUser);
                  }
                  else{
                    await db.insert(UserTable.TABLE_NAME,storeDataUser);
                  }
                  final userStorage = Provider.of<UserProvider>(context, listen: false);
                  await userStorage.getDataUser();
                  Navigator.of(context).pushNamedAndRemoveUntil(RouteString.main, (route) => false,arguments: TabIndexString.tabHome);
                }
              },
              isTrue: isTrue,
            )), (Route<dynamic> route) => false
        );
      }
      else{
        setTimer(10);
        notifyListeners();
        timerUpdate();
        print("tidak redirect");
      }
    }



  }





  signUp({BuildContext context,Map<String,dynamic> fields})async{
    final isValid = valid.validateEmptyForm(context: context,field:fields);
    if(isValid){
      FunctionalWidget.modal(
          context: context,
          child: Container(
            height: MediaQuery.of(context).size.height/1.2,
            child: DisclaimerComponent(
              callback: ()async{
                await postOtp(context: context,data: {"phoneNumber":fields["nomor"],"isLogin":"0"},callback: (otp){
                  Navigator.push(context, CupertinoPageRoute(builder: (context) =>  OtpComponent(
                    callback: (code)async{
                      dynamic dataRegister={
                        "fullname":fields["fullname"].toString(),
                        "email":fields["email"].toString(),
                        "mobile_no":fields["nomor"].toString(),
                        "pin":fields["pin"].toString(),
                        "sponsor":fields["referral_code"].toString(),
                        "signup_source":"apps",
                        "kode_otp":code.toString()
                      };
                      print(dataRegister);
                      // print("CALLBAC OTP COMPONENT $code");
                      final register = await HttpService().post(
                          url: "auth/register",
                          data: dataRegister,
                          context: context
                      );
                      print("RESULT REGISTER $register");
                      if(register!=null){
                        FunctionalWidget.nofitDialog(context: context,msg: register["msg"],callback2: ()=>Navigator.of(context).pushNamedAndRemoveUntil(RouteString.signIn, (route) => false),label2: "Login");
                      }
                      notifyListeners();
                    },
                    isTrue: isTrue,
                  )));
                  notifyListeners();
                });
              },
            ),
          )
      );

      // final res = await HttpService().post(url: "auth/register",data: fields,context:context);
      // print(sendOtp);

    }
    // notifyListeners();
  }





}