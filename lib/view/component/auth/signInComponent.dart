import 'package:adscoin/config/color_config.dart';
import 'package:adscoin/config/string_config.dart';
import 'package:adscoin/service/provider/authProvider.dart';
import 'package:adscoin/view/widget/general/fieldWidget.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:provider/provider.dart';
import '../../widget/general/buttonWidget.dart';
import '../../widget/general/touchWidget.dart';
import 'package:flutter/material.dart';

class SignInComponent extends StatefulWidget {
  @override
  _SignInComponentState createState() => _SignInComponentState();
}

class _SignInComponentState extends State<SignInComponent> {
  TextEditingController phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ScreenScaler scale= ScreenScaler()..init(context);
    final auth = Provider.of<AuthProvider>(context);
    return Scaffold(
      body:  Container(
        alignment: Alignment.center,
        padding: scale.getPadding(1, 6),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(child: Image.asset(GeneralString.imgLocal+"logo.png",height: scale.getHeight(10))),
              SizedBox(height: scale.getHeight(5)),
              Text("Masukan Nomer Ponsel",style: Theme.of(context).textTheme.headline1),
              Text("Masukan nomer ponsel untuk mendapatkan kode OTP",style: Theme.of(context).textTheme.subtitle1),
              SizedBox(height: scale.getHeight(4)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FieldWidget(
                    controller: phoneNumberController,
                    textInputType: TextInputType.number,
                    width: 60,
                  ),
                  RedButtonWidget(
                    callback: ()async{
                      final data = {
                        "nomor":phoneNumberController.text,
                        "type":"otp",
                        "nama":"",
                        "islogin":"1"
                      };
                      await auth.sendOtp(context: context,data: data);
                    },
                    child:Icon(Icons.arrow_right_alt,color: ColorConfig.graySecondaryColor),
                  )
                ],
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: InTouchWidget(
        callback: (){},
        child: Padding(
          padding:scale.getPadding(2, 6),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Belum memiliki akun ? ",style: Theme.of(context).textTheme.subtitle1),
              Text("Sign up",style: Theme.of(context).textTheme.subtitle1.copyWith(color: ColorConfig.yellowColor)),
            ],
          ),
        ),
      ),
    );

  }
}
