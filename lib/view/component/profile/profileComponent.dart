import 'package:adscoin/config/color_config.dart';
import 'package:adscoin/config/string_config.dart';
import 'package:adscoin/database/databaseInit.dart';
import 'package:adscoin/database/table.dart';
import 'package:adscoin/helper/functionalWidgetHelper.dart';
import 'package:adscoin/service/provider/authProvider.dart';
import 'package:adscoin/service/provider/historyProvider.dart';
import 'package:adscoin/service/provider/productProvider.dart';
import 'package:adscoin/service/provider/siteProvider.dart';
import 'package:adscoin/service/provider/userProvider.dart';
import 'package:adscoin/view/component/auth/otpComponent.dart';
import 'package:adscoin/view/component/auth/pinComponent.dart';
import 'package:adscoin/view/component/loadingComponent.dart';
import 'package:adscoin/view/component/site/infoAdsComponent.dart';
import 'package:adscoin/view/widget/general/buttonWidget.dart';
import 'package:adscoin/view/widget/general/cardAction.dart';
import 'package:adscoin/view/widget/general/cardTitleAction.dart';
import 'package:adscoin/view/widget/general/titleSectionWidget.dart';
import 'package:adscoin/view/widget/general/touchWidget.dart';
import 'package:adscoin/view/widget/home/cardSaldoWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  }
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = new GlobalKey<RefreshIndicatorState>();
  Future onLoadService()async{
    _refreshIndicatorKey.currentState.show();
    final user  = Provider.of<UserProvider>(context,listen: false);
    final config = Provider.of<SiteProvider>(context,listen: false);
    user.getDetailMember(context: context);
    config.getConfig(context: context);
  }
  @override
  Widget build(BuildContext context) {
    ScreenScaler scale= ScreenScaler()..init(context);
    final user  = Provider.of<UserProvider>(context);
    final product = Provider.of<ProductProvider>(context);
    final config = Provider.of<SiteProvider>(context);

    bool isLoading=user.isLoadingDetailMember;
    return Scaffold(
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        child: Column(
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
                      InTouchWidget(
                          callback: ()=>Navigator.of(context).pushNamed(RouteString.formProfile).then((value) => user.getDetailMember(context: context)),
                          child: Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  radius: 30,
                                  backgroundImage: NetworkImage(isLoading?GeneralString.dummyImgUser:user.detailMemberModel.result.foto)
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
                      isLoading?BaseLoading(height: 1, width: 30):Text(user.detailMemberModel.result.fullname,style: Theme.of(context).textTheme.headline1.copyWith(color:Colors.white)),
                      isLoading?BaseLoading(height: 1, width: 40):Text(user.detailMemberModel.result.mobileNo,style: Theme.of(context).textTheme.subtitle1.copyWith(color: Colors.grey[200])),
                      isLoading?BaseLoading(height: 1, width: 20):Text(user.detailMemberModel.result.type,style: Theme.of(context).textTheme.subtitle2.copyWith(color: Colors.grey[200])),
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
                      callback: (){
                        FunctionalWidget.modal(context: context,child: ModalFormPin());
                      },
                      isAction: true,
                      titleAction: "ubah pin",
                    ),
                    SizedBox(height: scale.getHeight(1)),
                    FunctionalWidget.wrapContent(
                        child:Column(
                          children: [
                            CardAction(
                              img:"Profile" ,
                              title: "Informasi pribadi",
                              colorIcon: ColorConfig.bluePrimaryColor,
                              callback: ()=>Navigator.of(context).pushNamed(RouteString.formProfile).then((value) => user.getDetailMember(context: context)),
                            ),
                            if(!isLoading&&user.detailMemberModel.result.idType==1)divid(),
                            if(!isLoading&&user.detailMemberModel.result.idType==1)CardAction(
                              img:"Discount" ,
                              title: "Referral",
                              colorIcon: ColorConfig.bluePrimaryColor,
                              callback: ()=>Navigator.of(context).pushNamed(RouteString.referral),
                            ),
                            if(!isLoading&&user.detailMemberModel.result.idType==1)divid(),
                            if(!isLoading&&user.detailMemberModel.result.idType==1)CardAction(
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
                        if(!isLoading&&user.detailMemberModel.result.idType==1){
                          await product.setIsAdd(true);
                          Navigator.of(context).pushNamed(RouteString.formProductContributor);
                        }
                      },
                      titleAction: !isLoading&&user.detailMemberModel.result.idType==1?"Tambah produk":"",
                    ),
                    SizedBox(height: scale.getHeight(1)),
                    FunctionalWidget.wrapContent(
                        child:Column(
                          children: [
                            if(!isLoading&&user.detailMemberModel.result.idType==1)CardAction(
                              img:"analytics1" ,
                              title: "Daftar produk",
                              colorIcon: ColorConfig.yellowColor,
                              callback: (){
                                Navigator.of(context).pushNamed(RouteString.productContributor);
                              },
                            ),

                            if(!isLoading&&user.detailMemberModel.result.idType==1)divid(),
                            CardAction(
                              img:"Chart" ,
                              title: "Laporan pembelian",
                              colorIcon: ColorConfig.blueSecondaryColor,
                              callback: (){
                                Navigator.of(context).pushNamed(RouteString.historyPurchase);
                              },
                            ),
                            if(!isLoading&&user.detailMemberModel.result.idType==1)divid(),
                            if(!isLoading&&user.detailMemberModel.result.idType==1)CardAction(
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
                    SizedBox(height: scale.getHeight(1)),
                    TitleSectionWidget(
                      title: "Informasi ${SiteString.siteName}",
                      callback: ()async{},
                      isAction: false,
                    ),
                    SizedBox(height: scale.getHeight(1)),
                    FunctionalWidget.wrapContent(
                        child:Column(
                          children: [
                            CardAction(
                              img:"adscoin" ,
                              title: "Term and condition",
                              colorIcon: ColorConfig.bluePrimaryColor,
                              callback: (){
                                FunctionalWidget.modal(context: context,child: Container(
                                  height: scale.getHeight(90),
                                  child: InfoAdsComponent(
                                    title: "Term and condition",
                                    desc: config.configModel.result[0].terms,
                                  ),
                                ));
                              },
                            ),
                            divid(),
                            CardAction(
                              img:"adscoin" ,
                              title: "Privacy policy",
                              colorIcon: ColorConfig.bluePrimaryColor,
                              callback: (){
                                FunctionalWidget.modal(context: context,child: Container(
                                  height: scale.getHeight(90),
                                  child: InfoAdsComponent(
                                    title: "Privacy policy",
                                    desc: config.configModel.result[0].privacy,
                                  ),
                                ));

                              },
                            ),
                            divid(),
                            CardAction(
                              img:"adscoin" ,
                              title: "Disclaimer",
                              colorIcon: ColorConfig.redColor,
                              callback: (){
                                FunctionalWidget.modal(context: context,child: Container(
                                  height: scale.getHeight(90),
                                  child: InfoAdsComponent(
                                    title: "Disclaimer",
                                    desc: config.configModel.result[0].disclaimer,
                                  ),
                                ));

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
                        FunctionalWidget.nofitDialog(
                          context: context,
                          msg: "Anda yakin akan keluar dari aplikasi ?",
                          callback1: ()=>Navigator.of(context).pop(),
                          callback2: ()async{
                            DatabaseInit db = new DatabaseInit();

                            final res = await db.update(UserTable.TABLE_NAME, user.id, {
                              SessionString.sessIsLogin:StatusRoleString.keluarAplikasi,
                              SessionString.sessToken:"",
                            });
                            if(res){
                              Navigator.of(context).pushNamedAndRemoveUntil(RouteString.signIn, (route) => false);
                            }else{
                              FunctionalWidget.toast(context: context,msg:"gagal keluar aplikasi");
                            }
                          },
                          label2: "Keluar"
                        );
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
        onRefresh: ()=>onLoadService()
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



class ModalFormPin extends StatefulWidget {
  @override
  _ModalFormPinState createState() => _ModalFormPinState();
}

class _ModalFormPinState extends State<ModalFormPin> {
  TextEditingController pinController = new TextEditingController();
  TextEditingController confirmPinController = new TextEditingController();
  String errorPin="",errorConfirmPin="";
  bool isValid=false;
  clearState(){
    pinController.text="";
    confirmPinController.text="";
    this.setState(() {});
  }
  conditionalPin(){
    String conPin=confirmPinController.text,pin=pinController.text;
    if(pin==""){
      setState(() {errorPin = "pin tidak boleh kosong";isValid=false;});
      return false;
    }
   if(pin.length<6){
      setState(() {errorPin = "pin kurang dari 6 digit";isValid=false;});
      return false;
    }
    if(pin!=conPin){
      setState(() {errorPin="";errorConfirmPin = "pin tidak sesuai";isValid=false;});
      return false;
    }
    setState(() {
      errorPin = "";
      errorConfirmPin="";
      isValid=false;
    });
    return true;
  }
  
  conditionalConfirmPin(){
    String conPin=confirmPinController.text,pin=pinController.text;
    if(conPin==""){
      setState(() {errorConfirmPin = "konfirmasi pin tidak boleh kosong";isValid=false;});
      return false;
    }
   if(conPin.length<6){
      setState(() {errorConfirmPin = "konfirmasi pin kurang dari 6 digit";isValid=false;});
      return false;
    }
    if(pin!=conPin){
      setState(() {errorConfirmPin = "pin tidak sesuai";isValid=false;});
      return false;
    }
    setState(() {
      errorConfirmPin = "";
      errorPin="";
      isValid=true;
    });
    return true;

  }

  @override
  Widget build(BuildContext context) {
    final user  = Provider.of<UserProvider>(context);
    final auth  = Provider.of<AuthProvider>(context);
    ScreenScaler scale = ScreenScaler()..init(context);
    return Container(
      padding: scale.getPadding(1, 2),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
         TitleSectionWidget(
           title: "Ubah pin",
           titleAction: "Simpan",
           callback: ()async{
             bool checkPin = conditionalPin();
             bool checkConfirmPin = conditionalConfirmPin();
             if(checkPin&&checkConfirmPin){
               String noTelp = user.mobileNo;
               print(noTelp);
               await auth.postOtp(
                   context: context,
                   data: {"phoneNumber":noTelp,"isLogin":"1"},
                   callback: (finishPin)async{
                     FunctionalWidget.modal(context: context,child: OtpComponent(callback: (code)async{
                       await user.store(context: context,fields: {
                         "pin":"${pinController.text}",
                         "kode_otp":code.toString(),
                       },isPin: true);
                     },isTrue: true,));
                   }
               );
             }

             // print("######################### CHECK FORM $checkForm");
             // if(errorPin==""&&errorConfirmPin==""){

             // }
           },

         ),
          TextFormField(
            style: Theme.of(context).textTheme.headline2,
            controller: pinController,
            maxLength: 6,
            buildCounter: (_, {currentLength, maxLength, isFocused}) => Padding(
              padding: const EdgeInsets.all(0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(errorPin,style: TextStyle(color: ColorConfig.redColor)),
                  Container(
                      alignment: Alignment.bottomRight,
                      child: Text(currentLength.toString() + "/" + maxLength.toString())
                  )
                ],
              ),
            ),
            decoration: InputDecoration(
                labelText: "Pin",
                labelStyle: Theme.of(context).textTheme.subtitle1,
                focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: ColorConfig.yellowColor))
            ),
            obscureText: true,
            cursorColor: ColorConfig.yellowColor,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              LengthLimitingTextInputFormatter(6),
              FilteringTextInputFormatter.digitsOnly
            ],
            onChanged: (e){
              conditionalPin();
              conditionalConfirmPin();
            },
          ),
          SizedBox(height: scale.getHeight(1),),
          TextFormField(
            style: Theme.of(context).textTheme.headline2,
            controller: confirmPinController,
            maxLength: 6,
            buildCounter: (_, {currentLength, maxLength, isFocused}) => Padding(
              padding: const EdgeInsets.all(0),
              child:  Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(errorConfirmPin,style: TextStyle(color: ColorConfig.redColor)),
                  Container(
                      alignment: Alignment.bottomRight,
                      child: Text(currentLength.toString() + "/" + maxLength.toString())
                  )
                ],
              ),
            ),
            decoration: InputDecoration(
                labelText: "Konfirmasi Pin",
                labelStyle: Theme.of(context).textTheme.subtitle1,
                focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: ColorConfig.yellowColor))
            ),
            obscureText: true,
            cursorColor: ColorConfig.yellowColor,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              LengthLimitingTextInputFormatter(6),
              FilteringTextInputFormatter.digitsOnly
            ],
            onChanged: (e){
              conditionalPin();
              conditionalConfirmPin();
            },
          ),
        ],
      )
    );
  }
}
