import 'package:adscoin/config/string_config.dart';
import 'package:adscoin/helper/ScreenScaleHelper.dart';
import 'package:adscoin/view/widget/auth/secureCodeWidget.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class PinComponent extends StatefulWidget {
  Function callback;
  PinComponent({this.callback});
  @override
  _PinComponentState createState() => _PinComponentState();
}

class _PinComponentState extends State<PinComponent> {
  @override
  Widget build(BuildContext context) {
    ScreenScaleHelper scale = ScreenScaleHelper()..init(context);
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
              Text("Verifikasi PIN",style: Theme.of(context).textTheme.headline1),
              Text("Masukan pin anda demi keamanan bertransaksi di aplikasi ini",style: Theme.of(context).textTheme.subtitle1,textAlign: TextAlign.center,),
              SecureCodeWidget(
                  isTrue:false,
                  passLength: 6,
                  borderColor: Theme.of(context).textTheme.subtitle1.color,
                  passCodeVerify: (passcode) async {
                    String code='';
                    for (int i = 0; i < passcode.length; i++) {
                      code+= passcode[i].toString();
                    }
                    widget.callback(code);
                    return false;
                  },
                  onSuccess: () async{
                    // widget.callback();
                  }
              )
            ],
          ),
        ),
      ),
    );
  }
}
