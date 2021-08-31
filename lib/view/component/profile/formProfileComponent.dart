import 'package:adscoin/config/color_config.dart';
import 'package:adscoin/config/string_config.dart';
import 'package:adscoin/helper/ScreenScaleHelper.dart';
import 'package:adscoin/helper/functionalWidgetHelper.dart';
import 'package:adscoin/view/widget/general/appBarWithActionWidget.dart';
import 'package:adscoin/view/widget/general/buttonWidget.dart';
import 'package:adscoin/view/widget/general/fieldWidget.dart';
import 'package:adscoin/view/widget/general/touchWidget.dart';
import 'package:adscoin/view/widget/general/uploadWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';


class FormProfileComponent extends StatefulWidget {
  @override
  _FormProfileComponentState createState() => _FormProfileComponentState();
}

class _FormProfileComponentState extends State<FormProfileComponent> {
  TextEditingController nameController;
  TextEditingController phoneController;
  TextEditingController emailController;
  @override
  Widget build(BuildContext context) {
    ScreenScaleHelper scale = ScreenScaleHelper()..init(context);

    return Scaffold(
      appBar:FunctionalWidget.appBarHelper(
        context: context,title: "Edit profile"
      ),
      body: ListView(
        padding: scale.getPadding(1,2.5),
        children: [
          Center(
            child: InTouchWidget(
              callback: ()=>FunctionalWidget.modal(
                context: context,
                child: UploadWidget(
                    callback: (img){
                      print(img);
                    }
                )
              ),
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 50,
                      backgroundImage: NetworkImage(GeneralString.dummyImgUser)
                  ),
                  Container(
                    padding: scale.getPadding(0.2,1),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle
                    ),
                    child: Icon(FlutterIcons.pencil_alt_faw5s,size: scale.getTextSize(10),color: ColorConfig.bluePrimaryColor,),
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: scale.getHeight(4)),
          TextFormField(
            style: Theme.of(context).textTheme.headline2,
            controller: nameController,
            maxLength: 40,
            buildCounter: (_, {currentLength, maxLength, isFocused}) => Padding(
              padding: const EdgeInsets.all(0),
              child: Container(alignment: Alignment.bottomRight,child: Text(currentLength.toString() + "/" + maxLength.toString())),
            ),
            decoration: InputDecoration(
              labelText: "Nama",
              labelStyle: Theme.of(context).textTheme.subtitle1,
              focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: ColorConfig.yellowColor))
            ),
            cursorColor: ColorConfig.yellowColor,
          ),
          TextFormField(
            style: Theme.of(context).textTheme.headline2,
            controller: phoneController,
            maxLength: 50,
            buildCounter: (_, {currentLength, maxLength, isFocused}) => Padding(
              padding: const EdgeInsets.all(0),
              child: Container(alignment: Alignment.bottomRight,child: Text(currentLength.toString() + "/" + maxLength.toString())),
            ),
            decoration: InputDecoration(
                labelText: "Nomor telepon",
                labelStyle: Theme.of(context).textTheme.subtitle1,
                focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: ColorConfig.yellowColor))
            ),
            cursorColor: ColorConfig.yellowColor,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              LengthLimitingTextInputFormatter(13),
              FilteringTextInputFormatter.digitsOnly
            ],
          ),
          TextFormField(
            style: Theme.of(context).textTheme.headline2,
            controller: emailController,
            maxLength: 40,
            buildCounter: (_, {currentLength, maxLength, isFocused}) => Padding(
              padding: const EdgeInsets.all(0),
              child: Container(alignment: Alignment.bottomRight,child: Text(currentLength.toString() + "/" + maxLength.toString())),
            ),
            decoration: InputDecoration(
                labelText: "Email",
                labelStyle: Theme.of(context).textTheme.subtitle1,
                focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: ColorConfig.yellowColor))
            ),
            cursorColor: ColorConfig.yellowColor,
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: scale.getHeight(7),
        padding: scale.getPadding(1, 2.5),
        child: BackroundButtonWidget(
          callback: (){},
          color: ColorConfig.redColor,
          title: "Simpan",
        ),
      ),
    );
  }
}
