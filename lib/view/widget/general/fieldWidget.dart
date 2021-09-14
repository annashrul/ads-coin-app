import 'package:adscoin/config/color_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';

// ignore: must_be_immutable
class FieldWidget extends StatelessWidget {
  TextEditingController controller;
  TextInputType textInputType = TextInputType.text;
  TextInputAction textInputAction = TextInputAction.done;
  String hintText;
  double width;
  int maxLines;
  bool readOnly;
  bool isIcon;
  Function onTap;
  Function(String e) onChange;
  int maxLength;
  FieldWidget({
    @required this.controller,
    this.textInputType,
    this.textInputAction,
    this.hintText,
    this.width,
    this.maxLines=1,
    this.readOnly=false,
    this.isIcon=false,
    this.onTap,
    this.onChange,
    this.maxLength,
  });
  @override
  Widget build(BuildContext context) {
    ScreenScaler scale= ScreenScaler()..init(context);
    return Container(
      padding: scale.getPadding(0, 2),
      width: width==null?double.infinity:scale.getWidth(width),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: ColorConfig.graySecondaryColor
      ),
      child: TextFormField(
        maxLines: maxLines,
        controller: controller,
        readOnly: readOnly,
        decoration: InputDecoration(
          hintText:hintText,
          border: InputBorder.none,
        ),
        keyboardType: textInputType,
        textInputAction: textInputAction,
        inputFormatters: <TextInputFormatter>[
          if(maxLength!=null)LengthLimitingTextInputFormatter(maxLength),
          if(textInputType == TextInputType.number) FilteringTextInputFormatter.digitsOnly
        ],
        onTap: (){
          if(onTap!=null){
            onTap();
            print("onTap");
          }
        },
        onChanged: (e){
          if(onChange!=null) onChange(e);

        },
      ),
    );
  }
}
