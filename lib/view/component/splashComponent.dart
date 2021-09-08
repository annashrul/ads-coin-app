import 'package:adscoin/config/string_config.dart';
import 'package:adscoin/helper/functionalWidgetHelper.dart';
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
      Navigator.of(context).pushNamed(RouteString.onBoarding);
    }
    else if(userStorage.isLogin==StatusRoleString.keluarAplikasi){
      Navigator.of(context).pushNamed(RouteString.signIn);
    }
    else{
      Navigator.of(context).pushNamedAndRemoveUntil(RouteString.main, (route) => false,arguments: TabIndexString.tabHome);
    }
  }


  AssetImage assetImage;
  @override
  void initState() {
    super.initState();

    assetImage = AssetImage("${GeneralString.imgLocal}ic_launcher.png");
    checkingRoute();
  }

  @override
  void didChangeDependencies() {
    precacheImage(assetImage, context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            image: DecorationImage(image: assetImage)
        ),
      ),
    );
  }
}
