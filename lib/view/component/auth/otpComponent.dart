import 'package:adscoin/config/color_config.dart';
import 'package:adscoin/config/string_config.dart';
import 'package:adscoin/service/provider/authProvider.dart';
import 'package:adscoin/view/widget/auth/secureCodeWidget.dart';
import 'package:adscoin/view/widget/general/buttonWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class OtpComponent extends StatefulWidget {
  Function(String otp) callback;
  bool isTrue;
  OtpComponent({this.callback, this.isTrue});
  @override
  _OtpComponentState createState() => _OtpComponentState();
}

class _OtpComponentState extends State<OtpComponent> {
  String joinString = "";
  void hidePhoneNumber() {
    final auth = Provider.of<AuthProvider>(context, listen: false);
    String nohp = auth.dataOtp["nomor"];
    String substringNoHp = nohp.substring(3, 9);
    String replaceToStar = "";
    for (int i = 0; i < substringNoHp.length; i++) {
      replaceToStar += substringNoHp[i].replaceAll(substringNoHp[i], "*");
    }
    joinString = nohp.substring(0, 3) + replaceToStar;
    joinString = joinString + nohp.substring(joinString.length, nohp.length);
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    hidePhoneNumber();
    final auth = Provider.of<AuthProvider>(context, listen: false);
    auth.timerUpdate();
    auth.timeCounter = 120;
    auth.isTrue = false;
  }

  @override
  Widget build(BuildContext context) {
    ScreenScaler scale = ScreenScaler()..init(context);
    final auth = Provider.of<AuthProvider>(context);
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: scale.getPadding(5, 6),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                  child: Image.asset(GeneralString.imgLocal + "logo.png",
                      height: scale.getHeight(10))),
              SizedBox(height: scale.getHeight(5)),
              // Text(auth.dataOtp["otp"],style: Theme.of(context).textTheme.headline1),
              Text("Masukkan Kode OTP",
                  style: Theme.of(context).textTheme.headline1),
              Text("Kami telah mengirimkan kode OTP pada ponsel anda",
                  style: Theme.of(context).textTheme.subtitle1),
              Text(
                joinString,
                style: Theme.of(context).textTheme.subtitle1,
                textAlign: TextAlign.center,
              ),
              SecureCodeWidget(
                  isTrue: auth.isTrue,
                  passLength: 4,
                  borderColor: Theme.of(context).textTheme.subtitle1.color,
                  passCodeVerify: (passcode) async {
                    String code = '';
                    for (int i = 0; i < passcode.length; i++) {
                      code += passcode[i].toString();
                    }
                    await widget.callback(code);
                    return false;
                  },
                  onSuccess: () async {
                    // widget.callback();
                  })
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(left: 50, right: 50, bottom: 20),
        child: RedButtonWidget(
            callback: () async {
              if (auth.timeUpFlag) {
                final sendData = {
                  "nomor": auth.dataOtp["nomor"],
                  "type": auth.dataOtp["type"],
                  "nama": auth.dataOtp["nama"],
                  "islogin": auth.dataOtp["islogin"],
                  "isRegister": auth.dataOtp["isRegister"],
                };
                await auth.sendOtp(
                    context: context, fields: sendData, isRedirect: false);
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    "Kirim ulang kode OTP ${!auth.timeUpFlag ? 'dalam ${auth.timeCounter} detik' : ''}",
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1
                        .copyWith(color: ColorConfig.graySecondaryColor)),
                Icon(Icons.arrow_right_alt,
                    color: ColorConfig.graySecondaryColor),
              ],
            )),
      ),
    );
  }
}
