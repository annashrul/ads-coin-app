

import 'package:adscoin/config/route_config.dart';
import 'package:adscoin/config/string_config.dart';
import 'package:adscoin/service/provider/authProvider.dart';
import 'package:adscoin/service/provider/userProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'config/color_config.dart';
List<SingleChildWidget> providers = [
  ChangeNotifierProvider<AuthProvider>(create: (_) => AuthProvider()),
  ChangeNotifierProvider<UserProvider>(create: (_) => UserProvider()),
];
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // transparent status bar
  ));
  runApp(
    MultiProvider(
      providers:providers,
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextStyle style = GoogleFonts.poppins();

    return MaterialApp(
      title: 'n-shop',
      initialRoute: RouteString.splash,
      onGenerateRoute: RouteGenerator.generateRoute,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.white,
        brightness: Brightness.light,
        // accentColor: config.Colors().mainColor(1),
        // focusColor: config.Colors().accentColor(1),
        // hintColor: config.Colors().secondColor(1),
        unselectedWidgetColor: Colors.grey[300],
        bottomSheetTheme: BottomSheetThemeData(backgroundColor:Colors.white,modalBackgroundColor:Colors.white),
        textTheme: TextTheme(
          button: style.copyWith(color: Colors.white),
          headline1: style.copyWith(fontSize: 20.0, fontWeight: FontWeight.w600, color: ColorConfig.blackPrimaryColor),
          headline2: style.copyWith(fontSize: 18.0, fontWeight: FontWeight.w500, color: ColorConfig.blackPrimaryColor),
          headline3: style.copyWith(fontSize: 16.0, fontWeight: FontWeight.w400, color: ColorConfig.blackPrimaryColor),
          headline4: style.copyWith(fontSize: 14.0, fontWeight: FontWeight.w400, color: ColorConfig.blackPrimaryColor),
          headline5: style.copyWith(fontSize: 9.0, fontWeight: FontWeight.w200, color: ColorConfig.blackPrimaryColor),
          subtitle1: style.copyWith(fontSize: 16.0, fontWeight: FontWeight.w500, color: ColorConfig.grayPrimaryColor),
          subtitle2: style.copyWith(fontSize: 14.0, fontWeight: FontWeight.w500, color:ColorConfig.grayPrimaryColor),
          bodyText1: style.copyWith(fontSize: 12.0, color: ColorConfig.grayPrimaryColor),
          bodyText2: style.copyWith(fontSize: 10.0, fontWeight: FontWeight.w600, color: ColorConfig.grayPrimaryColor),
          caption: style.copyWith(fontSize: 9.0, color: ColorConfig.grayPrimaryColor),
        ),
      ),
      builder: (BuildContext context, Widget child){
        final MediaQueryData data = MediaQuery.of(context);
        return MediaQuery(
          data: data.copyWith(textScaleFactor: 0.8),
          child: child,
        );
      },
    );
  }
}
