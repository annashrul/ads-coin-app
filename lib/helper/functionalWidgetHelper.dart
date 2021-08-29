
import 'package:adscoin/config/color_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class FunctionalWidget{
  static myPushRemove({BuildContext context, Widget widget}){
    return  Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
        new CupertinoPageRoute(builder: (BuildContext context)=>widget), (Route<dynamic> route) => false
    );
  }
  static myPush({BuildContext context, Widget widget}){
    return Navigator.push(context, CupertinoPageRoute(builder: (context) => widget));
  }
  static myPushAndLoad({BuildContext context, Widget widget,Function callback}){
    return Navigator.push(context, CupertinoPageRoute(builder: (context) => widget)).whenComplete(callback);
  }

  static loadingDialog(BuildContext context,{Color color=Colors.black,title='tunggu sebentar'}){
    return dialog(
      context: context,
      child: AlertDialog(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        content: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SpinKitFadingGrid(color:ColorConfig.blackPrimaryColor, shape: BoxShape.circle),
          ],
        ),
      )
    );
  }

  static nofitDialog({BuildContext context,String msg="",Function callback1,Function callback2,String label1="kembali",String label2="oke"}){
    return dialog(
      context: context,
      child: AlertDialog(
        title:Text("Informasi !",style: Theme.of(context).textTheme.headline1),
        content:Text(msg,style: Theme.of(context).textTheme.subtitle1),
        actions: <Widget>[
          if(callback1!=null)TextButton(
            onPressed:callback1,
            child:Text(label1,style: Theme.of(context).textTheme.subtitle1)
          ),
          TextButton(
              onPressed:callback2,
              child:Text(label2,style: Theme.of(context).textTheme.subtitle1.copyWith(color: ColorConfig.yellowColor))
          ),
        ],
      )
    );
  }

  static dialog({BuildContext context, Widget child}){
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return ConstrainedBox(
          constraints: BoxConstraints(maxHeight: 100.0),
          child: child
        );
      }
    );
  }

}