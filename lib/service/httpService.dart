import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:adscoin/config/string_config.dart';
import 'package:adscoin/helper/functionalWidgetHelper.dart';
import 'package:adscoin/model/generalModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' show Client;


class HttpService{
  Client client = Client();




  Future get({String url,BuildContext context})async{
    final res = isNotError(context: context,callback: (){});
    if(res){
      ApiString.head["Authorization"] = "";
      final response = await client.get(ApiString.url+url, headers:ApiString.head).timeout(Duration(seconds: ApiString.timeOut));
      if (response.statusCode == 200){
        final jsonResponse = json.decode(response.body);
        return jsonResponse is GeneralModel ? GeneralModel.fromJson(jsonResponse.toJson()):jsonResponse;
      }
      else{
        final jsonResponse = json.decode(response.body);
        return GeneralModel.fromJson(jsonResponse.toJson());
      }
    }
  }

  Future post({String url,dynamic data,BuildContext context}) async {
    final res = isNotError(context: context,callback: (){});
    if(res){
      FunctionalWidget.loadingDialog(context);
      ApiString.head["Authorization"] = "";
      final response = await client.post( ApiString.url+url,headers: ApiString.head,body:data).timeout(Duration(seconds: ApiString.timeOut));
      print("=================== POST DATA $url ${response.statusCode} ============================");
      if(response.statusCode==200){
        final jsonResponse =  json.decode(response.body);
        Navigator.pop(context);
        if(jsonResponse is GeneralModel){
          GeneralModel result = GeneralModel.fromJson(jsonResponse.toJson());
          FunctionalWidget.nofitDialog(context: context,msg: result.msg,callback2: ()=>Navigator.of(context).pop());
          return null;
        }
        else{
          return jsonResponse;
        }
      }else{
        Navigator.pop(context);
        final jsonResponse = json.decode(response.body);
        print("jsonResponse = $jsonResponse");
        GeneralModel result = GeneralModel.fromJson(jsonResponse);
        FunctionalWidget.nofitDialog(context: context,msg: result.msg,callback2: ()=>Navigator.of(context).pop());
        return null;
      }
    }
  }
  Future put({String url,dynamic data,BuildContext context}) async {
    final res = isNotError(context: context,callback: (){});
    if(res){
      FunctionalWidget.loadingDialog(context);
      ApiString.head["Authorization"] = "";
      final response = await client.put( ApiString.url+url,headers: ApiString.head,body:data).timeout(Duration(seconds: ApiString.timeOut));
      print("=================== POST DATA $url ${response.statusCode} ============================");
      if(response.statusCode==200){
        final jsonResponse =  json.decode(response.body);
        Navigator.pop(context);
        if(jsonResponse is GeneralModel){
          GeneralModel result = GeneralModel.fromJson(jsonResponse.toJson());
          FunctionalWidget.nofitDialog(context: context,msg: result.msg,callback2: ()=>Navigator.of(context).pop());
        }
        else{
          return jsonResponse;
        }
      }else{
        Navigator.pop(context);
        final jsonResponse = json.decode(response.body);
        GeneralModel result = GeneralModel.fromJson(jsonResponse.toJson());
        FunctionalWidget.nofitDialog(context: context,msg: result.msg,callback1: ()=>Navigator.of(context).pop());
      }
    }
  }

  Future delete({String url,dynamic data,BuildContext context}) async{
    final res = isNotError(context: context,callback: (){});
    if(res){
      FunctionalWidget.loadingDialog(context);
      ApiString.head["Authorization"] = "";
      final response = await client.delete(ApiString.url+url,headers: ApiString.head,).timeout(Duration(seconds: ApiString.timeOut));
      if(response.statusCode==200){
        final jsonResponse =  json.decode(response.body);
        GeneralModel result = GeneralModel.fromJson(jsonResponse);
        Navigator.pop(context);
        return result.msg;
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