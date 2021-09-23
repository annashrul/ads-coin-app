import 'package:adscoin/config/string_config.dart';
import 'package:adscoin/helper/functionalWidgetHelper.dart';
import 'package:adscoin/service/provider/siteProvider.dart';
import 'package:adscoin/service/provider/userProvider.dart';
import 'package:adscoin/view/component/mainComponent.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashComponent extends StatefulWidget {
  @override
  _SplashComponentState createState() => _SplashComponentState();
}

class _SplashComponentState extends State<SplashComponent> {

  Future checkingRoute()async{
    await Future.delayed(Duration(seconds: 1));
    final userStorage = Provider.of<UserProvider>(context, listen: false);
    await userStorage.getDataUser();
    print("userStorage.isLogin ${userStorage.isLogin}");
    if(userStorage.isLogin==null || userStorage.isLogin==StatusRoleString.baruInstall){
      print("########################## USER BARU MENGGUNAKAN APLIKASI");
      Navigator.of(context).pushNamedAndRemoveUntil(RouteString.onBoarding, (route) => false);
    }
    else{
      if(userStorage.isLogin==StatusRoleString.keluarAplikasi){
        print("########################## USER MELAKUKAN LOGOUT");
        Navigator.of(context).pushNamedAndRemoveUntil(RouteString.signIn, (route) => false);
      }
      else{
        final isToken = await FunctionalWidget.isTokenExpired(context);
        if(isToken){
          print("########################## TOKEN EXPIRED");
          FunctionalWidget.processLogout(context);
        }else{
          await userStorage.getDetailMember(context: context);
          print("########################## CHECK DATA USER ${userStorage.detailMemberModel}");
          if(userStorage.detailMemberModel!=null){
            if(userStorage.detailMemberModel.result.status==0){
              print("########################## STATUS USER SUDAH TIDAK AKTIF");
              FunctionalWidget.processLogout(context);
            }else{
              print(" ####################### USER BOLEH MASUK KE HALAMAN UTAMA APLIKASI ########################################");
              Navigator.of(context).pushNamedAndRemoveUntil(RouteString.main, (route) => false,arguments: TabIndexString.tabHome);
            }
          }else{
            print(" ####################### DATA USER TIDAK ADA ########################################");
            FunctionalWidget.processLogout(context);
          }
        }
      }
    }
  }


  AssetImage assetImage;
  @override
  void initState() {
    super.initState();
    assetImage = AssetImage("${GeneralString.imgLocal}ic_launcher.png");
    checkingRoute();
    final site = Provider.of<SiteProvider>(context,listen: false);
    site.getConfigInfo(context: context);

  }

  @override
  void didChangeDependencies() {
    precacheImage(assetImage, context);
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    // return ReadingApp();
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            image: DecorationImage(image: assetImage)
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(10),
        child: Text("By Shopowae",style: Theme.of(context).textTheme.headline1,textAlign: TextAlign.center,),
      ),
    );

  }
}
