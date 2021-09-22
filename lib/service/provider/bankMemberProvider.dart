

import 'package:adscoin/config/string_config.dart';
import 'package:adscoin/helper/functionalWidgetHelper.dart';
import 'package:adscoin/helper/validateFormHelper.dart';
import 'package:adscoin/model/member/bankMemberModel.dart';
import 'package:adscoin/service/httpService.dart';
import 'package:flutter/cupertino.dart';

class BankMemberProvider with ChangeNotifier{
  BankMemberModel bankMemberModel;
  bool isLoading=true,isLoadMore=false;
  int perPage=10;
  bool isAdd=true;
  int indexBank=10000;

  setIsAdd(input){
    isAdd=input;
    notifyListeners();
  }
  setIndexBank(input){
    indexBank=input;
    notifyListeners();
  }
  get({BuildContext context})async{
    if(bankMemberModel==null) isLoading=true;
    final res = await HttpService().get(url: "bank_member",context: context);
    print("RESPONSE BANK $res");
    if(res["result"].length>0){
      BankMemberModel result=BankMemberModel.fromJson(res);
      bankMemberModel=result;
    }else{
      bankMemberModel=null;
    }
    isLoading=false;
    isLoadMore=false;
    notifyListeners();

  }

  store({BuildContext context,Map<dynamic,dynamic> data})async{
    ValidateFormHelper valid = new ValidateFormHelper();
    final isValid = valid.validateEmptyForm(context: context,field:{"atas_nama":data["acc_name"],"no_rekening":data["acc_no"]});
    if(isValid){
      dynamic res;
      if(isAdd){
        data.remove("id");
        res = await HttpService().post(url: "bank_member",data: data,context: context);
      }else{
        Navigator.of(context).pop();
        String id = data["id"];
        data.remove("id");
        data.remove("bank_name");
        print(data);
        res = await HttpService().put(url: "bank_member/$id",data: data,context: context);
        print(res);
      }
      if(res!=null){
        get(context: context);
        Navigator.of(context).pop();
        FunctionalWidget.toast(context: context,msg: "data berhasil disimpan");
        // FunctionalWidget.nofitDialog(context: context,msg: "data berhasil disimpan",callback2: ()=>Navigator.of(context).pushReplacementNamed(RouteString.bankMember),callback1: ()=>Navigator.of(context).pop(),label2: "Lihat data");
      }
      notifyListeners();
    }

  }

   delete({BuildContext context})async{
    FunctionalWidget.nofitDialog(
        context: context,
        msg: "Anda yakin akan menghapus data ini ?",
        callback1: ()=>Navigator.of(context).pop(),
        callback2: ()async{
          Navigator.of(context).pop();
          final res = await HttpService().delete(url: "bank_member/${bankMemberModel.result[indexBank].id}",context: context);
          if(res!=null){
            Navigator.of(context).pop();
            get(context: context);
            FunctionalWidget.toast(context: context,msg: "data berhasil dihapus");
          }

          notifyListeners();
          // print("RESPONSE $res");
        }
    );

  }


}