import 'dart:convert';
import 'dart:io';

import 'package:adscoin/config/string_config.dart';
import 'package:adscoin/helper/functionalWidgetHelper.dart';
import 'package:adscoin/view/widget/general/cardAction.dart';
import 'package:adscoin/view/widget/general/titleSectionWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';

// ignore: must_be_immutable
class UploadWidget extends StatefulWidget {
  Function(String img) callback;
  String title;
  UploadWidget({@required this.callback,this.title});

  @override
  _UploadWidgetState createState() => _UploadWidgetState();
}

class _UploadWidgetState extends State<UploadWidget> {
  File _image;

  @override
  Widget build(BuildContext context) {
    ScreenScaler scale= ScreenScaler()..init(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: scale.getPadding(1,2.5),
          child: TitleSectionWidget(
            title: widget.title==null?"Pilih foto":widget.title,
            callback: (){
              print("################################################################# $_image");
              if(_image!=null){
                String fileName;
                String base64Image;
                fileName = _image.path.split("/").last;
                var type = fileName.split('.');
                base64Image = 'data:image/' + type[1] + ';base64,' + base64Encode(_image.readAsBytesSync());
                widget.callback(base64Image);
              }
            },
            isAction: true,
            titleAction: "Simpan gambar",
          ),
        ),
        CardAction(
          icon:AntDesign.camera,
          title: "Pilih dari kamera",
          callback: ()async{
            var img = await FunctionalWidget.getImage("kamera");
            setState(()=>_image = img);
          },
        ),
        CardAction(
          icon: AntDesign.picture,
          title: "Pilih dari galeri",
          callback: ()async{
            var img = await FunctionalWidget.getImage("galeri");
            setState(()=>_image = img);
          },
        ),
        Container(
          padding:EdgeInsets.all(0.0),
          decoration: BoxDecoration(
            borderRadius:  BorderRadius.circular(10.0),
          ),
          child: _image == null ?Image.network(GeneralString.dummyImgUser,width: double.infinity,fit: BoxFit.contain): new Image.file(_image,width: MediaQuery.of(context).size.width/1,height: MediaQuery.of(context).size.height/2,filterQuality: FilterQuality.high,),
        ),

      ],
    );
  }
}

