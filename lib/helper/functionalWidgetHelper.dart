
import 'package:adscoin/config/color_config.dart';
import 'package:adscoin/config/string_config.dart';
import 'package:adscoin/helper/ScreenScaleHelper.dart';
import 'package:adscoin/view/widget/general/buttonWidget.dart';
import 'package:adscoin/view/widget/general/touchWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class FunctionalWidget{

  static backToHome(BuildContext context){
    return Navigator.of(context).pushNamedAndRemoveUntil(RouteString.main, (route) => false,arguments: TabIndexString.tabHome);
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



  static appBarHelper({BuildContext context,String title, Function callback}){
    ScreenScaleHelper scale = ScreenScaleHelper()..init(context);
    return AppBar(
      backgroundColor: Colors.transparent,
      titleSpacing: 0.0,
      automaticallyImplyLeading: true,
      elevation: 0.0,
      leadingWidth:scale.getWidth(7),
      leading:InkResponse(
        onTap: (){
          callback!=null?callback():Navigator.of(context).pop();
        },
        child: Icon(Ionicons.ios_arrow_back),
      ),
      centerTitle: true,
      title: Text(title,style: Theme.of(context).textTheme.headline1,textAlign: TextAlign.center),
    );
  }


  static rating({BuildContext context}){
    ScreenScaleHelper scale = ScreenScaleHelper()..init(context);
    return Row(
      children: [
        Icon(AntDesign.star,size: scale.getTextSize(9),color: ColorConfig.yellowColor,),
        SizedBox(width: scale.getWidth(1)),
        Text("5.0",style: Theme.of(context).textTheme.subtitle1)
      ],
    );
  }

  static wrapContent({Widget child}){
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 4,
      shadowColor:Colors.white54,
      margin: EdgeInsets.zero,
      child: child,
    );
  }

  static bottomBar({BuildContext context,String title,String desc,String btnText,Function callback}){
    ScreenScaleHelper scale = ScreenScaleHelper()..init(context);
    return Container(
      padding: scale.getPadding(1, 2),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.9),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(title,style: Theme.of(context).textTheme.subtitle2,),
              Text(desc,style: Theme.of(context).textTheme.headline1),
            ],
          ),
          RedButtonWidget(
              callback: ()=>callback(),
              child: Text(btnText,style: Theme.of(context).textTheme.headline1.copyWith(color: ColorConfig.graySecondaryColor))
          )
        ],
      ),
    );
  }

}