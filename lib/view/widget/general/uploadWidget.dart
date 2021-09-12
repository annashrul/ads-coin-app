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
  Function(dynamic data) callback;
  String title;
  UploadWidget({@required this.callback,this.title});

  @override
  _UploadWidgetState createState() => _UploadWidgetState();
}

class _UploadWidgetState extends State<UploadWidget> {
  dynamic _image;

  Future toImage(img)async{
    if(img!=null){
      String fileName;
      String base64Image;
      fileName = img["file"].path.split("/").last;
      var type = fileName.split('.');
      base64Image = 'data:image/' + type[1] + ';base64,' + base64Encode(img["file"].readAsBytesSync());
      widget.callback({"path":img["path"],"preview":img["file"],"base64":base64Image});
    }
  }


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
              toImage(_image);
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
            if(widget.title!="Upload bukti transfer"){
              toImage(img);
            }
          },
        ),
        CardAction(
          icon: AntDesign.picture,
          title: "Pilih dari galeri",
          callback: ()async{
            var img = await FunctionalWidget.getImage("galeri");
            setState(()=>_image = img);
            if(widget.title!="Upload bukti transfer"){
              toImage(img);
            }
          },
        ),
        Container(
          padding:EdgeInsets.all(0.0),
          decoration: BoxDecoration(
            borderRadius:  BorderRadius.circular(10.0),
          ),
          child: _image == null ?Image.network(GeneralString.dummyImgUser,width: double.infinity,fit: BoxFit.contain): new Image.file(_image["file"],width: MediaQuery.of(context).size.width/1,height: MediaQuery.of(context).size.height/2,filterQuality: FilterQuality.high,),
        ),

      ],
    );
  }
}

