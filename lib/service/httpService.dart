import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:adscoin/config/string_config.dart';
import 'package:adscoin/helper/functionalWidgetHelper.dart';
import 'package:adscoin/model/generalModel.dart';
import 'package:adscoin/service/provider/userProvider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' show Client;
import 'package:provider/provider.dart';


class HttpService{
  Client client = Client();

  Future get({String url,BuildContext context})async{
    final res = isNotError(context: context,callback: (){});
    if(res){
      final userStorage = Provider.of<UserProvider>(context, listen: false);
      ApiString.head["Authorization"] = "Bearer ${userStorage.token}";
      final response = await client.get(ApiString.url+url, headers:ApiString.head).timeout(Duration(seconds: ApiString.timeOut));
      print("################################ URL = $url, STATUS = ${response.statusCode}");
      if (response.statusCode == 200){
        final jsonResponse = json.decode(response.body);
        return jsonResponse;
      }
      else if(response.statusCode==500){
        FunctionalWidget.toast(context: context,msg: "terjadi kesalahan url");
        return null;
      }
      else{
        final jsonResponse = json.decode(response.body);
        return GeneralModel.fromJson(jsonResponse);
      }
    }
  }

  Future post({String url,dynamic data,BuildContext context,bool isLoading=true}) async {
    final res = isNotError(context: context,callback: (){});
    if(res){
      if(isLoading)FunctionalWidget.loadingDialog(context);
      final userStorage = Provider.of<UserProvider>(context, listen: false);
      ApiString.head["Authorization"] = "Bearer ${userStorage.token}";
      final response = await client.post( ApiString.url+url,headers: ApiString.head,body:data).timeout(Duration(seconds: ApiString.timeOut));
      print("=================== POST DATA $url ${response.statusCode} ============================");
      if(response.statusCode==200){
        final jsonResponse =  json.decode(response.body);
        if(isLoading)Navigator.pop(context);
        print(jsonResponse);
        if(jsonResponse["status"]=="failed"){
          if(isLoading)FunctionalWidget.nofitDialog(context: context,msg:jsonResponse["msg"],callback2: ()=>Navigator.of(context).pop());
          return null;
        }
        else{
          return jsonResponse;
        }
      }else{
        if(isLoading)Navigator.pop(context);
        final jsonResponse = json.decode(response.body);
        print("jsonResponse = $jsonResponse");
        GeneralModel result = GeneralModel.fromJson(jsonResponse);
        if(isLoading)FunctionalWidget.nofitDialog(context: context,msg: result.msg,callback2: ()=>Navigator.of(context).pop());
        return null;
      }
    }
  }
  Future put({String url,dynamic data,BuildContext context,bool isLoading=true}) async {
    final res = isNotError(context: context,callback: (){});
    if(res){
      if(isLoading)FunctionalWidget.loadingDialog(context);
      final userStorage = Provider.of<UserProvider>(context, listen: false);
      ApiString.head["Authorization"] = "Bearer ${userStorage.token}";
      final response = await client.put( ApiString.url+url,headers: ApiString.head,body:data).timeout(Duration(seconds: ApiString.timeOut));
      print("=================== PUT DATA $url ${response.statusCode} ============================");
      if(response.statusCode==200){
        final jsonResponse =  json.decode(response.body);
        if(isLoading)Navigator.pop(context);
        if(jsonResponse["status"]=="failed"){
          if(isLoading)FunctionalWidget.nofitDialog(context: context,msg:jsonResponse["msg"],callback2: ()=>Navigator.of(context).pop());
          return null;
        }
        else{
          return jsonResponse;
        }
      }else{
        if(isLoading)Navigator.pop(context);
        final jsonResponse = json.decode(response.body);
        GeneralModel result = GeneralModel.fromJson(jsonResponse.toJson());
        if(isLoading)FunctionalWidget.nofitDialog(context: context,msg: result.msg,callback1: ()=>Navigator.of(context).pop());
        return null;

      }
    }
  }
  Future delete({String url,BuildContext context}) async{
    final res = isNotError(context: context,callback: (){});
    if(res){
      FunctionalWidget.loadingDialog(context);
      final userStorage = Provider.of<UserProvider>(context, listen: false);
      ApiString.head["Authorization"] = "Bearer ${userStorage.token}";
      final response = await client.delete(ApiString.url+url,headers: ApiString.head,).timeout(Duration(seconds: ApiString.timeOut));
      Navigator.of(context).pop();
      if(response.statusCode==200){
        final jsonResponse =  json.decode(response.body);
        if(jsonResponse["status"]=="failed"){
          FunctionalWidget.nofitDialog(context: context,msg:jsonResponse["msg"],callback2: ()=>Navigator.of(context).pop());
          return null;
        }
        else{
          print("jsonResponse = $jsonResponse");
          return jsonResponse;
        }
      }
      else{
        final jsonResponse = json.decode(response.body);
        GeneralModel result = GeneralModel.fromJson(jsonResponse.toJson());
        FunctionalWidget.nofitDialog(context: context,msg: result.msg,callback1: ()=>Navigator.of(context).pop());
        return null;
      }
    }



  }
  isNotError({BuildContext context,Function callback}){
    try{
      return true;
    }on TimeoutException catch (e) {
      print("###################################### GET TimeoutException");
      return Navigator.pushNamed(context, "error",arguments: (){
        print("TimeoutException");
      });
    } on SocketException catch (e) {
      print("###################################### GET SocketException");
      return Navigator.pushNamed(context, "error",arguments: (){
        print("SocketException");
      });
    }
    on Error catch (e) {
      print("###################################### GET Error");
      return Navigator.pushNamed(context, "error",arguments: (){
        print("Error");
      });
    }
  }

}