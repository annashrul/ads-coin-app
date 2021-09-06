
import 'dart:io';

import 'package:adscoin/config/color_config.dart';
import 'package:adscoin/config/string_config.dart';
import 'package:adscoin/helper/formatCurrencyHelper.dart';
import 'package:adscoin/view/widget/general/buttonWidget.dart';
import 'package:adscoin/view/widget/general/touchWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';


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



  static appBarHelper({BuildContext context,String title, Function callback, Color backgroundColor = Colors.transparent,Color titleColor}){
    ScreenScaler scale= ScreenScaler()..init(context);
    return AppBar(
      backgroundColor: backgroundColor,
      titleSpacing: 0.0,
      automaticallyImplyLeading: true,
      elevation: 0.0,
      leadingWidth:scale.getWidth(7),
      leading:InkResponse(
        onTap: (){
          callback!=null?callback():Navigator.of(context).pop();
        },
        child: Icon(Ionicons.ios_arrow_back,color: titleColor==null?ColorConfig.blackPrimaryColor:titleColor),
      ),
      centerTitle: true,
      title: Text(title,style: titleColor==null?Theme.of(context).textTheme.headline1:Theme.of(context).textTheme.headline1.copyWith(color: titleColor),textAlign: TextAlign.center),
    );
  }
  static appBarWithFilterHelper({BuildContext context,String title, Function callback,List<Widget> action}){
    ScreenScaler scale= ScreenScaler()..init(context);
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
      actions:action,
    );
  }
  static iconAppbar({BuildContext context,Function callback,IconData icon,Color color,String image}){
    ScreenScaler scaler= ScreenScaler()..init(context);
    return Container(
      margin: scaler.getMarginLTRB(0, 0, 0, 0),
      child: InTouchWidget(
          radius: 100,
          callback: (){callback();},
          child: Container(
            padding: scaler.getPadding(0,2),
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    // child: Icon(icon,color:color!=null?color:Theme.of(context).hintColor)
                    child: icon!=null? Icon(icon,color:color!=null?color:Theme.of(context).hintColor):Image.asset(GeneralString.imgLocalPng+"$image.png",height: scaler.getHeight(1.5),color: color!=null?color:ColorConfig.blackPrimaryColor,filterQuality: FilterQuality.high,)
                ),
              ],
            ),
          )
      ),
    );
  }



  static rating({BuildContext context,double rate}){
    ScreenScaler scale= ScreenScaler()..init(context);
    return Row(
      children: [
        Icon(AntDesign.star,size: scale.getTextSize(9),color: ColorConfig.yellowColor,),
        SizedBox(width: scale.getWidth(1)),
        Text(rate.toString(),style: Theme.of(context).textTheme.subtitle1)
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
    ScreenScaler scale= ScreenScaler()..init(context);
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


  static betweenText({BuildContext context,String title,String desc,Color color}){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,style: Theme.of(context).textTheme.headline2.copyWith(color: color==null?Theme.of(context).textTheme.subtitle1.color:Theme.of(context).textTheme.headline2.color)),
        Text(desc,style: Theme.of(context).textTheme.headline2),
      ],
    );
  }

  static spaceText({BuildContext context,String title, String desc,Widget child}){
    ScreenScaler scale= ScreenScaler()..init(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          child: Text(title,style: Theme.of(context).textTheme.headline2.copyWith(color: Theme.of(context).textTheme.subtitle1.color)),
          width: scale.getWidth(20),
        ),
        Text(":",style: Theme.of(context).textTheme.subtitle1.copyWith(color: Theme.of(context).textTheme.subtitle2.color)),
        SizedBox(width: scale.getWidth(1)),
        child==null?Text(desc,style: Theme.of(context).textTheme.headline2):child,
      ],
    );
  }

  static modal({BuildContext context,Widget child}){
    return showModalBottomSheet(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(10.0))),
        context: context,
        isScrollControlled: true,
        builder: (context) => Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: child,
        )
    );
  }


  static Future getImage(param) async {
    ImageSource imageSource;
    if(param == 'kamera'){
      imageSource = ImageSource.camera;
    }
    else{
      imageSource = ImageSource.gallery;
    }
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: imageSource);
    print(pickedFile.path);
    return File(pickedFile.path);
  }
  static toast({BuildContext context,msg}) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(msg,style: Theme.of(context).textTheme.subtitle1.copyWith(color: Colors.white),),
      ),
    );
  }


  static toCoin(double coin){
    return "$coin coin";
  }
}