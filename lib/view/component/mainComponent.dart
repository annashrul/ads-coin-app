import 'package:adscoin/config/color_config.dart';
import 'package:adscoin/config/string_config.dart';
import 'package:adscoin/helper/functionalWidgetHelper.dart';
import 'package:adscoin/service/provider/siteProvider.dart';
import 'package:adscoin/view/component/product/libraryProductComponent.dart';
import 'package:adscoin/view/component/product/productComponent.dart';
import 'package:adscoin/view/component/profile/profileComponent.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:provider/provider.dart';
import 'home/homeComponent.dart';

// ignore: must_be_immutable
class MainComponent extends StatefulWidget {
  int index;
  MainComponent({this.index});
  @override
  _MainComponentState createState() => _MainComponentState();
}

class _MainComponentState extends State<MainComponent> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Widget currentWidget = HomeComponent();
  @override
  initState() {
    // final userStorage = Provider.of<UserProvider>(context, listen: false);
    // userStorage.getDataUser();
    final config = Provider.of<SiteProvider>(context, listen: false);
    config.getConfig(context: context);
    _selectTab(widget.index);
    super.initState();
    OneSignal.shared
        .setInFocusDisplayType(OSNotificationDisplayType.notification);
    var settings = {
      OSiOSSettings.autoPrompt: false,
      OSiOSSettings.promptBeforeOpeningPushUrl: true
    };
    OneSignal.shared.init(ApiString.onesignalAppId, iOSSettings: settings);
    OneSignal.shared.setNotificationOpenedHandler((notification) {
      var notify = notification.notification.payload.additionalData;
      String type = notify["section"];
      print(
          "============================ NOTIFIKASI ONSIGNAL $type =============================");
      if (type == NotifikasiString.transaksiWallet) {
        Navigator.of(context).pushNamed(RouteString.indexFintechComponent);
      } else if (type == NotifikasiString.referral) {
        Navigator.of(context).pushNamed(RouteString.referral);
      } else if (type == NotifikasiString.reminder) {
        Navigator.of(context).pushNamed(RouteString.productContributor);
      } else if (type == NotifikasiString.riwayatBeli) {
        Navigator.of(context).pushNamed(RouteString.historyPurchase);
      } else if (type == NotifikasiString.suspend) {
        Navigator.of(context).pushNamedAndRemoveUntil(
            RouteString.main, (route) => false,
            arguments: TabIndexString.tabProfile);
      } else if (type == NotifikasiString.blockir) {
        FunctionalWidget.processLogout(context);
      } else {
        Navigator.of(context).pushNamedAndRemoveUntil(
            RouteString.main, (route) => false,
            arguments: TabIndexString.tabHome);
      }
      print(
          "============================ NOTIFIKASI ONSIGNAL =============================");
    });
  }

  @override
  void didUpdateWidget(MainComponent oldWidget) {
    _selectTab(oldWidget.index);
    super.didUpdateWidget(oldWidget);
    print("didUpdateWidget");
  }

  void _selectTab(int tabItem) {
    setState(() {
      widget.index = tabItem;
      switch (tabItem) {
        case TabIndexString.tabHome:
          currentWidget = HomeComponent();
          break;
        case TabIndexString.tabProduct:
          currentWidget = ProductComponent();
          break;
        case TabIndexString.tabLibrary:
          currentWidget = LibraryProductComponent();
          break;
        case TabIndexString.tabProfile:
          currentWidget = ProfileComponent();
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenScaler scaler = ScreenScaler()..init(context);
    return WillPopScope(
        child: Scaffold(
          key: _scaffoldKey,
          body: currentWidget,
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            selectedFontSize: scaler.getTextSize(10),
            unselectedFontSize: scaler.getTextSize(10),
            iconSize: scaler.getTextSize(14),
            elevation: 0,
            backgroundColor: ColorConfig.redColor,
            selectedIconTheme: IconThemeData(size: scaler.getTextSize(14)),
            selectedItemColor: Color(0xFFFFFFFF),
            unselectedItemColor: Color(0xFFE3B3AF),
            currentIndex: widget.index,
            onTap: (int i) async {
              final isToken = await FunctionalWidget.isTokenExpired(context);
              if (isToken) {
                FunctionalWidget.nofitDialog(
                    context: context,
                    msg: "anda harus login ulang demi keamanan sistem",
                    callback2: () => FunctionalWidget.processLogout(context),
                    label2: "Keluar");
                Future.delayed(Duration(seconds: 2)).whenComplete(
                    () => FunctionalWidget.processLogout(context));
              } else {
                this._selectTab(i);
              }
              print(isToken);
              // await FunctionalWidget.checkTokenExp(context: context);
            },
            // this will be set when a new tab is tapped
            items: [
              bottomBar(
                  context: context, icon: AntDesign.home, title: "Beranda"),
              bottomBar(
                  context: context, icon: AntDesign.gift, title: "Produk"),
              bottomBar(
                  context: context, icon: AntDesign.piechart, title: "Library"),
              bottomBar(
                  context: context,
                  icon: FlutterIcons.user_alt_faw5s,
                  title: "Profile"),
            ],
          ),
        ),
        onWillPop: _onWillPop);
  }

  BottomNavigationBarItem bottomBar(
      {BuildContext context, IconData icon, String title}) {
    ScreenScaler scaler = ScreenScaler()..init(context);
    return BottomNavigationBarItem(
      icon: new Icon(icon),
      title: new Container(
        margin: scaler.getMarginLTRB(0, 0.5, 0, 0),
        child: Text(title),
      ),
    );
  }

  Future<bool> _onWillPop() async {
    return (FunctionalWidget.nofitDialog(
          context: context,
          msg: "Kamu yakin akan keluar dari aplikasi ?",
          callback1: () => Navigator.of(context).pop(),
          callback2: () => SystemNavigator.pop(),
        )) ??
        false;
  }
}
