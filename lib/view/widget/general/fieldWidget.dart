import 'package:adscoin/config/color_config.dart';
import 'package:country_code_picker/country_code_picker.dart';
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
  double height;
  int maxLines;
  bool readOnly;
  bool isIcon;
  Function onTap;
  Function(String e) onChange;
  int maxLength;
  bool isPhone;
  final void Function(String code) onTapCountry;
  FieldWidget({
    @required this.controller,
    this.textInputType,
    this.textInputAction,
    this.hintText,
    this.width,
    this.height,
    this.maxLines=1,
    this.readOnly=false,
    this.isIcon=false,
    this.onTap,
    this.onChange,
    this.maxLength,
    this.isPhone,
    this.onTapCountry
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (isPhone)
            Container(
              width: scale.getWidth(20),
              child: CountryCodePicker(

                onInit:(CountryCode e) {
                  onTapCountry(e.dialCode.replaceAll('+', ''));
                  // countryCode="${e.dialCode.replaceAll('+', '')}";
                },
                onChanged: (CountryCode e) {
                  onTapCountry(e.dialCode.replaceAll('+', ''));
                  // countryCode="${e.dialCode.replaceAll('+', '')}";
                },
                initialSelection: 'ID',
                favorite: ['+62', 'ID'],
                showCountryOnly: true,
                showOnlyCountryWhenClosed: false,
                alignLeft: true,
                textStyle: Theme.of(context).textTheme.subtitle1,
              ),
            ),
          Expanded(
            child: TextField(
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
          )
        ],
      ),
    );
  }
}
