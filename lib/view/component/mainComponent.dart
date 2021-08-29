import 'package:adscoin/config/color_config.dart';
import 'package:adscoin/helper/ScreenScaleHelper.dart';
import 'package:adscoin/helper/functionalWidgetHelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
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
    _selectTab(widget.index);
    super.initState();
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
        case 0:
          currentWidget = HomeComponent();
          break;
        case 1:
          currentWidget = HomeComponent();
          break;
        case 2:
          currentWidget = HomeComponent();
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenScaleHelper scaler = ScreenScaleHelper()..init(context);

    return WillPopScope(
        child: Scaffold(
          key: _scaffoldKey,
          body:currentWidget,
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            selectedFontSize: scaler.getTextSize(10),
            unselectedFontSize: scaler.getTextSize(10),
            iconSize: scaler.getTextSize(14),
            elevation: 0,
            backgroundColor: ColorConfig.redColor,
            selectedIconTheme: IconThemeData(size:  scaler.getTextSize(14)),
            selectedItemColor: Color(0xFFFFFFFF),
            unselectedItemColor: Color(0xFFE3B3AF),
            currentIndex: widget.index,
            onTap: (int i) {
              this._selectTab(i);
            },
            // this will be set when a new tab is tapped
            items: [
              BottomNavigationBarItem(
                icon: Icon(AntDesign.home),
                title: new Container(
                  child: Text("Beranda"),
                ),
                // label: "asd"
              ),
              BottomNavigationBarItem(
                icon: Icon(AntDesign.gift),
                title: new Container(
                  child: Text("Produk"),
                ),
              ),
              BottomNavigationBarItem(
                icon: new Icon(AntDesign.piechart),
                title: new Container(
                  child: Text("Library"),
                ),
              ),
              BottomNavigationBarItem(
                icon: new Icon(AntDesign.profile),
                title: new Container(
                  child: Text("Profile"),
                ),
              ),
            ],
          ),
        ),
        onWillPop: _onWillPop
    );
  }
  Future<bool> _onWillPop() async {
    // return WidgetHelper().showFloatingFlushbar(context, "success", "desc");
    return (
        FunctionalWidget.nofitDialog(
          context: context,
          msg: "Kamu yakin akan keluar dari aplikasi ?",
          callback1: ()=>Navigator.of(context).pop(),
          callback2: ()=>SystemNavigator.pop(),
        )
        // UserRepository().notifAlertQ(context, "info ", "Keluar", "Kamu yakin akan keluar dari aplikasi ?", "Ya", "Batal", ()=>SystemNavigator.pop(), ()=>Navigator.of(context).pop(false))
    ) ?? false;
  }
}
