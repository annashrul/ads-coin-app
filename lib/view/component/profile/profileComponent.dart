import 'package:adscoin/config/color_config.dart';
import 'package:adscoin/config/string_config.dart';
import 'package:adscoin/helper/ScreenScaleHelper.dart';
import 'package:adscoin/helper/functionalWidgetHelper.dart';
import 'package:adscoin/view/widget/general/buttonWidget.dart';
import 'package:adscoin/view/widget/general/titleSectionWidget.dart';
import 'package:adscoin/view/widget/general/touchWidget.dart';
import 'package:adscoin/view/widget/home/cardSaldoWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_icons/flutter_icons.dart';

class ProfileComponent extends StatefulWidget {
  @override
  _ProfileComponentState createState() => _ProfileComponentState();
}

class _ProfileComponentState extends State<ProfileComponent> {
  @override
  Widget build(BuildContext context) {
    ScreenScaleHelper scale = ScreenScaleHelper()..init(context);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: scale.getHeight(25),
                color: ColorConfig.yellowColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // SizedBox(height: scale.getHeight(1)),
                    InTouchWidget(
                      callback: (){},
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          CircleAvatar(
                              backgroundColor: Colors.transparent,
                              radius: 30,
                              backgroundImage: NetworkImage(GeneralString.dummyImgUser)
                          ),
                          Container(
                            padding: scale.getPadding(0.2,1),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle
                            ),
                            child: Icon(FlutterIcons.pencil_alt_faw5s,size: scale.getTextSize(8),color: ColorConfig.bluePrimaryColor,),
                          )
                        ],
                      )
                    ),
                    SizedBox(height: scale.getHeight(1)),
                    Text("annashrul yusuf",style: Theme.of(context).textTheme.headline1.copyWith(color:Colors.white)),
                    Text("0812 - 1504 - 6887",style: Theme.of(context).textTheme.subtitle1),
                    Text("Kontributor",style: Theme.of(context).textTheme.subtitle2),
                  ],
                ),
              ),
              Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children:<Widget>[
                    Container(height: scale.getHeight(20)),
                    Container(
                      padding: scale.getPadding(0,2.5),
                      child: CardSaldoWidget(),
                    ),
                  ]
              )
            ],
          ),
          Padding(
            padding: scale.getPadding(1, 2.5),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TitleSectionWidget(
                      title: "Akun",
                      callback: (){},
                    isAction: false,
                  ),
                  SizedBox(height: scale.getHeight(1)),
                  FunctionalWidget.wrapContent(
                    child:Column(
                      children: [
                        titleSpaceBetween(
                          context: context,
                          icon: FlutterIcons.user_alt_faw5s,
                          color: ColorConfig.bluePrimaryColor,
                          title: "Informasi pribadi",
                            callback: (){}
                        ),
                        divid(),
                        titleSpaceBetween(
                            context: context,
                            icon: FlutterIcons.heart_faw5s,
                            color: ColorConfig.redColor,
                            title: "Favorit saya",
                            callback: (){}
                        ),
                      ],
                    )
                  ),
                  SizedBox(height: scale.getHeight(1)),
                  TitleSectionWidget(
                      title: "Produk",
                      callback: (){},
                    titleAction: "Tambah produk",
                  ),
                  SizedBox(height: scale.getHeight(1)),
                  FunctionalWidget.wrapContent(
                      child:Column(
                        children: [
                          titleSpaceBetween(
                              context: context,
                              icon: FlutterIcons.file_alt_faw5s,
                              color: ColorConfig.yellowColor,
                              title: "Daftar produk",
                              callback: (){}
                          ),
                          divid(),
                          titleSpaceBetween(
                              context: context,
                              icon: FlutterIcons.chart_area_faw5s,
                              color: ColorConfig.blueSecondaryColor,
                              title: "Laporan pembelian",
                              callback: (){}
                          ),
                          divid(),
                          titleSpaceBetween(
                              context: context,
                              icon: FlutterIcons.chart_area_faw5s,
                              color: ColorConfig.purplePrimaryColor,
                              title: "Laporan penjualan",
                              callback: (){}
                          ),
                        ],
                      )
                  ),
                  SizedBox(height: scale.getHeight(4)),
                  BorderButtonWidget(
                    borderColor: ColorConfig.redColor,
                    title: "Keluar",
                    callback: (){},
                  ),
                ],
              ),
            ),
          ),

        ],
      ),
    );
  }
  
  Widget titleSpaceBetween({BuildContext context,IconData icon,String title,Function callback,Color color}){
    ScreenScaleHelper scale= ScreenScaleHelper()..init(context);
    return InTouchWidget(
        callback: (){callback();},
        child: Padding(
          padding: scale.getPadding(1,2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(icon,size: scale.getTextSize(10),color:color),
                  SizedBox(width: scale.getWidth(3)),
                  Text(title,style: Theme.of(context).textTheme.headline2),
                ],
              ),
              Icon(Icons.arrow_forward_ios_outlined,size: scale.getTextSize(10),color: ColorConfig.graySecondaryColor,),
            ],
          ),
        )
    );
  }

  Widget divid(){
    ScreenScaleHelper scale= ScreenScaleHelper()..init(context);
    return Container(
        margin: scale.getMargin(0,2),
        height:1,
        width: double.infinity,
        color:ColorConfig.graySecondaryColor
    );
  }
  
}
