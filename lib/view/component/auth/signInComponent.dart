import 'package:adscoin/config/color_config.dart';
import 'package:adscoin/config/string_config.dart';
import 'package:adscoin/service/provider/authProvider.dart';
import 'package:adscoin/view/widget/general/fieldWidget.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
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
  String countryCode="";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

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
              Text("Masukkan Nomor Ponsel",style: Theme.of(context).textTheme.headline1),
              Center(child:Text("Masukkan nomor ponsel untuk mendapatkan kode OTP",style: Theme.of(context).textTheme.subtitle1,textAlign: TextAlign.center,)),
              SizedBox(height: scale.getHeight(4)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FieldWidget(
                    controller: phoneNumberController,
                    textInputType: TextInputType.number,
                    width: 60,
                    isPhone: true,
                    onTapCountry: (code){
                      countryCode=code;
                      // setState(() {
                      //
                      // });
                    },

                  ),
                  RedButtonWidget(
                    callback: ()async{
                      final data = {
                        "countryCode":countryCode,
                        "nomor":phoneNumberController.text,
                        "type":"sms",
                        "nama":"tatang",
                        "islogin":"1",
                        "isRegister":"0",
                      };
                      // print("############### $countryCode${phoneNumberController.text}");
                      auth.sendOtp(context: context,fields: data,isRedirect: true);
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
        callback: (){
          Navigator.of(context).pushNamedAndRemoveUntil(RouteString.signUp, (route) => false);
        },
        child: Padding(
          padding:scale.getPadding(2, 6),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Belum memiliki akun ? ",style: Theme.of(context).textTheme.subtitle1),
              Text("Sign up",style: Theme.of(context).textTheme.subtitle1.copyWith(fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );

  }
}
