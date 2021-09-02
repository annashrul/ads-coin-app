import 'package:adscoin/config/color_config.dart';
import 'package:adscoin/config/string_config.dart';
import 'package:adscoin/helper/functionalWidgetHelper.dart';
import 'package:adscoin/service/provider/GeneralProvider.dart';
import 'package:adscoin/view/widget/general/buttonWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:provider/provider.dart';

class SuccessComponent extends StatefulWidget {
  Function callback;
  String title;

  SuccessComponent({this.callback,this.title = "Transaksi berhasil dilakukan"});
  @override
  _SuccessComponentState createState() => _SuccessComponentState();
}

class _SuccessComponentState extends State<SuccessComponent> {
  @override
  Widget build(BuildContext context) {
    ScreenScaler scale = ScreenScaler()..init(context);
    final general = Provider.of<GeneralProvider>(context);

    return WillPopScope(
        child: Scaffold(
          body: Padding(
            padding: scale.getPadding(1,2.5),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: scale.getPadding(3,3),
                    decoration: BoxDecoration(
                        color: ColorConfig.yellowColor,
                        shape: BoxShape.circle
                    ),
                    child: Icon(FlutterIcons.check_outline_mco,size: scale.getTextSize(25),color: Colors.white,),
                  ),
                  Text(widget.title,style: Theme.of(context).textTheme.headline1),
                  SizedBox(height: scale.getHeight(3)),
                  RedButtonWidget(
                    child:Text("Kembali",style: Theme.of(context).textTheme.headline1.copyWith(color: ColorConfig.graySecondaryColor)),
                    callback: ()=>widget.callback(),
                  )
                ],
              ),
            ),
          ),
        ),
        onWillPop: (){
          FunctionalWidget.toast(context: context,msg: "Gunakan tombol kembali yang ada di aplikasi ini");
          return;

        }
    );
  }
}

