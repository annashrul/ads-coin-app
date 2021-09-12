import 'package:adscoin/config/color_config.dart';
import 'package:adscoin/config/string_config.dart';
import 'package:adscoin/service/provider/authProvider.dart';
import 'package:adscoin/view/widget/general/buttonWidget.dart';
import 'package:adscoin/view/widget/general/touchWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:provider/provider.dart';

class SignUpComponent extends StatefulWidget {
  @override
  _SignUpComponentState createState() => _SignUpComponentState();
}

class _SignUpComponentState extends State<SignUpComponent> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController pinController = TextEditingController();
  TextEditingController confirmPinController = TextEditingController();
  TextEditingController referralCodeController = TextEditingController();

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
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: Image.asset(GeneralString.imgLocal+"logo.png",height: scale.getHeight(9))),
              SizedBox(height: scale.getHeight(1)),
              Center(
                child: Text("Selamat Datang di ${SiteString.siteName}",style: Theme.of(context).textTheme.headline1,textAlign: TextAlign.center,),
              ),
              Center(
                child: Text("Sign up to continue",style: Theme.of(context).textTheme.subtitle1,textAlign: TextAlign.center),
              ),
              SizedBox(height: scale.getHeight(3)),
              customField(
                label: "Full Name",
                maxLength: 80,
                controller: fullNameController
              ),
              SizedBox(height: scale.getHeight(1)),
              customField(
                label: "Email",
                maxLength: 80,
                controller: emailController,
                textInputType: TextInputType.emailAddress
              ),
              SizedBox(height: scale.getHeight(1)),
              customField(
                label: "Phone number",
                maxLength: 15,
                controller: phoneNumberController,
                textInputType: TextInputType.number
              ),
              SizedBox(height: scale.getHeight(1)),
              customField(
                label: "PIN",
                maxLength: 6,
                controller: pinController,
                textInputType: TextInputType.number
              ),
              SizedBox(height: scale.getHeight(1)),
              customField(
                  label: "Confirm PIN",
                  maxLength: 6,
                  controller: confirmPinController,
                  textInputType: TextInputType.number
              ),
              SizedBox(height: scale.getHeight(1)),
              customField(
                  label: "Referral code",
                  maxLength: 50,
                textCapitalization: TextCapitalization.characters,
                  controller: referralCodeController,
              ),
              Container(
                padding: scale.getPadding(2,0),
                child: BackroundButtonWidget(
                  callback: ()async{
                    auth.signUp(
                      context: context,
                      fields: {
                        "fullname":fullNameController.text,
                        "email":emailController.text,
                        "nomor":phoneNumberController.text,
                        "pin":pinController.text,
                        "confirm_pin":confirmPinController.text,
                        "referral_code":referralCodeController.text,
                        "compare":{
                          "pin":pinController.text,
                          "confirm_pin":confirmPinController.text
                        }
                      }
                    );
                  },
                  backgroundColor: ColorConfig.redColor,
                  title: "Sign up",
                ),
              )

            ],
          ),
        ),
      ),
      bottomNavigationBar: InTouchWidget(
        callback: (){
          Navigator.of(context).pushNamedAndRemoveUntil(RouteString.signIn, (route) => false);
        },
        child: Padding(
          padding:scale.getPadding(2, 6),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("sudah memiliki akun ? ",style: Theme.of(context).textTheme.subtitle1),
              Text("Sign in",style: Theme.of(context).textTheme.subtitle1.copyWith(color: ColorConfig.yellowColor)),
            ],
          ),
        ),
      ),
    );

  }


  Widget customField({String label,int maxLength,TextEditingController controller,TextInputType textInputType=TextInputType.text,TextCapitalization textCapitalization = TextCapitalization.words}){
    ScreenScaler scale= ScreenScaler()..init(context);
    return Wrap(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("$label *",style: Theme.of(context).textTheme.subtitle1,),
            Text("${controller.text.length}/$maxLength",style: Theme.of(context).textTheme.subtitle2,)
          ],
        ),
        Container(
          padding: scale.getPadding(0, 2),
          width:double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: ColorConfig.graySecondaryColor
          ),
          child: TextFormField(
            textCapitalization:textCapitalization,
            controller: controller,
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
            keyboardType: textInputType,
            inputFormatters: <TextInputFormatter>[
              LengthLimitingTextInputFormatter(maxLength),
              if(textInputType==TextInputType.number) FilteringTextInputFormatter.digitsOnly
            ],
            onChanged: (e)=>this.setState(() {}),
          ),
        )
      ],
    );
  }

}
