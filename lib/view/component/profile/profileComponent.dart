import 'package:adscoin/config/color_config.dart';
import 'package:adscoin/config/string_config.dart';
import 'package:adscoin/helper/functionalWidgetHelper.dart';
import 'package:adscoin/service/provider/userProvider.dart';
import 'package:adscoin/view/widget/general/buttonWidget.dart';
import 'package:adscoin/view/widget/general/cardAction.dart';
import 'package:adscoin/view/widget/general/titleSectionWidget.dart';
import 'package:adscoin/view/widget/general/touchWidget.dart';
import 'package:adscoin/view/widget/home/cardSaldoWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileComponent extends StatefulWidget {
  @override
  _ProfileComponentState createState() => _ProfileComponentState();
}

class _ProfileComponentState extends State<ProfileComponent> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final user = Provider.of<UserProvider>(context, listen: false);
    user.getUser();
  }

  @override
  Widget build(BuildContext context) {
    ScreenScaler scale= ScreenScaler()..init(context);
    final user  = Provider.of<UserProvider>(context);
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
                      callback: ()=>Navigator.of(context).pushNamed(RouteString.formProfile),
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          CircleAvatar(
                              backgroundColor: Colors.transparent,
                              radius: 30,
                              backgroundImage: NetworkImage(user.photo)
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
                    Text(user.name,style: Theme.of(context).textTheme.headline1.copyWith(color:Colors.white)),
                    Text(user.mobileNo,style: Theme.of(context).textTheme.subtitle1),
                    Text(user.type,style: Theme.of(context).textTheme.subtitle2),
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
         Expanded(
             child: ListView(
               padding: scale.getPadding(1, 2.5),
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
                         CardAction(
                           img:"Profile" ,
                           title: "Informasi pribadi",
                           colorIcon: ColorConfig.bluePrimaryColor,
                           callback: (){},
                         ),

                         divid(),
                         CardAction(
                           img:"Heart" ,
                           title: "Favorite saya",
                           colorIcon: ColorConfig.redColor,
                           callback: (){},
                         ),

                       ],
                     )
                 ),
                 SizedBox(height: scale.getHeight(1)),
                 TitleSectionWidget(
                   title: "Produk",
                   callback: ()=>Navigator.of(context).pushNamed(RouteString.formProductContributor),
                   titleAction: "Tambah produk",
                 ),
                 SizedBox(height: scale.getHeight(1)),
                 FunctionalWidget.wrapContent(
                     child:Column(
                       children: [
                         CardAction(
                           img:"analytics1" ,
                           title: "Daftar produk",
                           colorIcon: ColorConfig.yellowColor,
                           callback: (){
                             Navigator.of(context).pushNamed(RouteString.productContributor);
                           },
                         ),

                         divid(),
                         CardAction(
                           img:"Chart" ,
                           title: "Laporan pembelian",
                           colorIcon: ColorConfig.blueSecondaryColor,
                           callback: ()=>Navigator.of(context).pushNamed(RouteString.historyPurchase),
                         ),
                         divid(),
                         CardAction(
                           img:"analytics" ,
                           title: "Laporan penjualan",
                           colorIcon: ColorConfig.purplePrimaryColor,
                           callback: (){},
                         ),
                       ],
                     )
                 ),
                 SizedBox(height: scale.getHeight(4)),
                 BorderButtonWidget(
                   borderColor: ColorConfig.redColor,
                   title: "Keluar",
                   callback: ()async{
                     SharedPreferences myPrefs = await SharedPreferences.getInstance();
                     myPrefs.setString(SessionString.sessIsLogin, StatusRoleString.keluarAplikasi);
                     Navigator.of(context).pushNamedAndRemoveUntil(RouteString.signIn, (route) => false);
                   },
                 ),
               ],
             )
         ),
        ],
      ),
    );
  }


  Widget divid(){
    ScreenScaler scale= ScreenScaler()..init(context);
    return Container(
        margin: scale.getMargin(0,2),
        height:1,
        width: double.infinity,
        color:ColorConfig.graySecondaryColor
    );
  }
  
}
