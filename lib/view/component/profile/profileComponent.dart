import 'package:adscoin/config/color_config.dart';
import 'package:adscoin/config/string_config.dart';
import 'package:adscoin/database/databaseInit.dart';
import 'package:adscoin/database/table.dart';
import 'package:adscoin/helper/functionalWidgetHelper.dart';
import 'package:adscoin/service/provider/historyProvider.dart';
import 'package:adscoin/service/provider/productProvider.dart';
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
    user.getDetailMember(context: context);
  }

  @override
  Widget build(BuildContext context) {
    ScreenScaler scale= ScreenScaler()..init(context);
    final user  = Provider.of<UserProvider>(context);
    final product = Provider.of<ProductProvider>(context);
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
                      callback: ()=>Navigator.of(context).pushNamed(RouteString.formProfile).then((value) => user.getDetailMember(context: context)),
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          CircleAvatar(
                              backgroundColor: Colors.transparent,
                              radius: 30,
                              backgroundImage: NetworkImage(user.detailMemberModel.result.foto)
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
                    Text(user.detailMemberModel.result.fullname,style: Theme.of(context).textTheme.headline1.copyWith(color:Colors.white)),
                    Text(user.detailMemberModel.result.mobileNo,style: Theme.of(context).textTheme.subtitle1),
                    Text(user.detailMemberModel.result.type,style: Theme.of(context).textTheme.subtitle2),
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
                         if(user.type==RoleAccessString.contributor)divid(),
                         if(user.type==RoleAccessString.contributor)CardAction(
                           img:"Home1" ,
                           title: "Bank",
                           colorIcon: ColorConfig.bluePrimaryColor,
                           callback: (){
                              Navigator.of(context).pushNamed(RouteString.bankMember);
                           },
                         ),
                         divid(),
                         CardAction(
                           img:"Heart" ,
                           title: "Favorite saya",
                           colorIcon: ColorConfig.redColor,
                           callback: ()=>Navigator.of(context).pushNamed(RouteString.favorite),
                         ),
                       ],
                     )
                 ),
                 SizedBox(height: scale.getHeight(1)),
                 TitleSectionWidget(
                   title: "Produk",
                   callback: ()async{
                     if(user.type==RoleAccessString.contributor){
                       await product.setIsAdd(true);
                       Navigator.of(context).pushNamed(RouteString.formProductContributor);
                     }
                   },
                   titleAction: user.type==RoleAccessString.contributor?"Tambah produk":"",
                 ),
                 SizedBox(height: scale.getHeight(1)),
                 FunctionalWidget.wrapContent(
                     child:Column(
                       children: [
                         if(user.type==RoleAccessString.contributor)CardAction(
                           img:"analytics1" ,
                           title: "Daftar produk",
                           colorIcon: ColorConfig.yellowColor,
                           callback: (){
                             Navigator.of(context).pushNamed(RouteString.productContributor);
                           },
                         ),

                         if(user.type==RoleAccessString.contributor)divid(),
                         CardAction(
                           img:"Chart" ,
                           title: "Laporan pembelian",
                           colorIcon: ColorConfig.blueSecondaryColor,
                           callback: (){
                             Navigator.of(context).pushNamed(RouteString.historyPurchase);
                           },
                         ),
                         if(user.type==RoleAccessString.contributor)divid(),
                         if(user.type==RoleAccessString.contributor)CardAction(
                           img:"analytics" ,
                           title: "Laporan penjualan",
                           colorIcon: ColorConfig.purplePrimaryColor,
                           callback: (){
                             Navigator.of(context).pushNamed(RouteString.historySale);
                           },
                         ),
                       ],
                     )
                 ),
                 SizedBox(height: scale.getHeight(4)),
                 BorderButtonWidget(
                   borderColor: ColorConfig.redColor,
                   title: "Keluar",
                   callback: ()async{
                     DatabaseInit db = new DatabaseInit();
                     final res = await db.update(UserTable.TABLE_NAME, user.id, {
                       SessionString.sessIsLogin:StatusRoleString.keluarAplikasi
                     });
                     if(res){
                       Navigator.of(context).pushNamedAndRemoveUntil(RouteString.signIn, (route) => false);
                     }else{
                       FunctionalWidget.toast(context: context,msg:"gagal keluar aplikasi");
                     }
                     // user.isLogin = StatusRoleString.keluarAplikasi;
                     // SharedPreferences myPrefs = await SharedPreferences.getInstance();
                     // myPrefs.setString(SessionString.sessIsLogin, StatusRoleString.keluarAplikasi);
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
