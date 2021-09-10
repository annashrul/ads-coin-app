import 'package:adscoin/helper/functionalWidgetHelper.dart';
import 'package:flutter/cupertino.dart';

class ValidateFormHelper {
  validateEmail({BuildContext context, email}) {
    String p = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(p);
    bool valid = regExp.hasMatch(email);
    return valid;
  }

  validateLength(field,length){
    if(field.length>length){
      return false;
    }
    return true;
  }

  validateEmptyForm({BuildContext context, field}){
    bool forEachDone=true;
    field.forEach((key, value) {
      if(forEachDone){
        if(value==""){
          FunctionalWidget.toast(context: context,msg: "$key tidak boleh kosong");
          forEachDone=false;
          return forEachDone;
        }
        else if(key=="email"){
          final validEmail = validateEmail(context: context,email: value);
          if(!validEmail){
            FunctionalWidget.toast(context: context,msg: "format email salah");
            forEachDone=false;
            return forEachDone;
          }
        }
        else if(key=="website"){
          bool validLink = Uri.parse(value).isAbsolute;
          if(!validLink){
            FunctionalWidget.toast(context: context,msg: "format link salah");
            forEachDone=false;
            return forEachDone;
          }
        }
        forEachDone=true;
      }
    });
    return forEachDone;

  }



}