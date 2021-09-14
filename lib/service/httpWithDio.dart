

import 'dart:convert';

import 'package:adscoin/config/string_config.dart';
import 'package:adscoin/helper/functionalWidgetHelper.dart';
import 'package:adscoin/model/generalModel.dart';
import 'package:adscoin/service/provider/userProvider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class HttpWithDio {
  var dio = Dio();
  Future<dynamic> getDio({String url,BuildContext context}) async {
    Map<String, String> head={
      'X-Project-ID': ApiString.xProjectId,
      'X-Requested-From': ApiString.xRequestedFrom,
      'Authorization':''
    };
    final userStorage = Provider.of<UserProvider>(context, listen: false);
    if(userStorage.token!=''){
      head["Authorization"] = "Bearer ${userStorage.token}";
    }
    try {
      var response = await dio.get(ApiString.url+url,
        options: Options(
            followRedirects: false,
            validateStatus: (status) {
              return status < 500;
            },
            headers:head
        )
      );

      if (response.statusCode == 200){
        final jsonResponse = json.decode(response.data);
        return jsonResponse;
      }
      else if(response.statusCode==500){
        FunctionalWidget.toast(context: context,msg: "terjadi kesalahan url");
        return null;
      }
      else{
        final jsonResponse = json.decode(response.data);
        return GeneralModel.fromJson(jsonResponse);
      }
    } catch (e) {
      print(e);
    }

  }

  Future<dynamic> postDio({String url,BuildContext context,dynamic column,bool isLoading=true})async{
    Map<String, String> head={
      'X-Project-ID': ApiString.xProjectId,
      'X-Requested-From': ApiString.xRequestedFrom,
      'Authorization':''
    };
    final userStorage = Provider.of<UserProvider>(context, listen: false);
    if(userStorage.token!=''){
      head["Authorization"] = "Bearer ${userStorage.token}";
    }
    print(column);
    try{


      var response = await dio.put(ApiString.url+url,
          // data: {"title": "update" , "content": "-", "preview": "", "id_category": "d7180cd2-a695-4f28-aa7c-f84caa11526e", "status": "0", "image":""},
          data: column,
          options: Options(
              receiveTimeout: 60000,
              sendTimeout: 60000,
              headers:head
          )
      );
      if(response.statusCode==200){
        final jsonResponse =  json.decode(response.data);
        if(isLoading)Navigator.pop(context);
        print(jsonResponse);
        if(jsonResponse["status"]=="failed"){
          if(isLoading)FunctionalWidget.nofitDialog(context: context,msg:jsonResponse["msg"],callback2: ()=>Navigator.of(context).popUntil((route) => route.isFirst));
          return null;
        }
        else{
          return jsonResponse;
        }
      }
      else{
        if(isLoading)Navigator.pop(context);
        final jsonResponse = json.decode(response.data);
        print("jsonResponse = $jsonResponse");
        // GeneralModel result = GeneralModel.fromJson(jsonResponse);
        // if(isLoading)FunctionalWidget.nofitDialog(context: context,msg: result.msg,callback2: ()=>Navigator.of(context).pop());
        return null;
      }
    }catch (e) {
      print("CATCH ${e.toString()}");
    }
  }

}