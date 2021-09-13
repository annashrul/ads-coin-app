import 'dart:io';

import 'package:adscoin/config/color_config.dart';
import 'package:adscoin/helper/functionalWidgetHelper.dart';
import 'package:adscoin/service/provider/userProvider.dart';
import 'package:adscoin/view/widget/general/buttonWidget.dart';
import 'package:adscoin/view/widget/general/touchWidget.dart';
import 'package:adscoin/view/widget/general/uploadWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:provider/provider.dart';


class FormProfileComponent extends StatefulWidget {
  @override
  _FormProfileComponentState createState() => _FormProfileComponentState();
}

class _FormProfileComponentState extends State<FormProfileComponent> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController websiteController = TextEditingController();
  String image="";
  bool isFile=false;
  File imageUpload;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final user = Provider.of<UserProvider>(context, listen: false);
    nameController.text=user.detailMemberModel.result.fullname;
    emailController.text=user.detailMemberModel.result.email;
    phoneController.text=user.detailMemberModel.result.mobileNo;
    image = user.detailMemberModel.result.foto;
    bioController.text=user.detailMemberModel.result.bio;
    websiteController.text=user.detailMemberModel.result.website;
  }

  @override
  Widget build(BuildContext context) {
    final profle = Provider.of<UserProvider>(context);
    ScreenScaler scale= ScreenScaler()..init(context);
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
                      Navigator.of(context).pop();
                      setState(() {
                        imageUpload = img["preview"];
                        image=img["base64"];
                      }); 
                    }
                )
              ),
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 50,
                      backgroundImage: imageUpload==null?NetworkImage(image):FileImage(imageUpload)
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
            maxLength: 80,
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
            controller: emailController,
            maxLength: 80,
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
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.done,
          ),

          TextFormField(
            readOnly: true,
            style: Theme.of(context).textTheme.headline2,
            controller: phoneController,
            maxLength: 15,
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
              LengthLimitingTextInputFormatter(14),
              FilteringTextInputFormatter.digitsOnly
            ],
          ),
          TextFormField(
            style: Theme.of(context).textTheme.headline2,
            controller: websiteController,
            maxLength: 100,
            buildCounter: (_, {currentLength, maxLength, isFocused}) => Padding(
              padding: const EdgeInsets.all(0),
              child: Container(alignment: Alignment.bottomRight,child: Text(currentLength.toString() + "/" + maxLength.toString())),
            ),
            decoration: InputDecoration(
                labelText: "Website",
                labelStyle: Theme.of(context).textTheme.subtitle1,
                focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: ColorConfig.yellowColor))
            ),
            cursorColor: ColorConfig.yellowColor,
            keyboardType: TextInputType.url,
          ),
          TextFormField(
            style: Theme.of(context).textTheme.headline2,
            controller: bioController,
            maxLength: 150,
            maxLines: 3,
            buildCounter: (_, {currentLength, maxLength, isFocused}) => Padding(
              padding: const EdgeInsets.all(0),
              child: Container(alignment: Alignment.bottomRight,child: Text(currentLength.toString() + "/" + maxLength.toString())),
            ),
            decoration: InputDecoration(
                labelText: "Bio",
                labelStyle: Theme.of(context).textTheme.subtitle1,
                focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: ColorConfig.yellowColor))
            ),
            cursorColor: ColorConfig.yellowColor,
            keyboardType: TextInputType.text,
          ),

        ],
      ),
      bottomNavigationBar: Container(
        padding: scale.getPadding(1, 2.5),
        child: BackroundButtonWidget(
          callback: ()async{
            await profle.store(context: context,fields: {
              "fullname":nameController.text,
              "email":emailController.text,
              "bio":bioController.text,
              "website":websiteController.text,
              "foto":imageUpload!=null?image:"-"
            });
          },
          backgroundColor: ColorConfig.redColor,
          title: "Simpan",
        ),
      ),
    );
  }
}
