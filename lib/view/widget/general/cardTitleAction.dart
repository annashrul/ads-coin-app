import 'package:adscoin/config/string_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';

class CardTitleAction extends StatelessWidget {
  final String image;
  final String title;
  CardTitleAction({this.image,this.title});


  @override
  Widget build(BuildContext context) {
    ScreenScaler scale = ScreenScaler()..init(context);
    bool isError=false;
    return Row(
      children: [
        CircleAvatar(
          onBackgroundImageError: (e, _){
            print(e);
            isError=true;
          },
          foregroundImage: NetworkImage(GeneralString.dummyImgUser),
          backgroundColor: Colors.transparent,
          radius: 20,
          backgroundImage: NetworkImage(isError?GeneralString.dummyImgUser:this.image),
        ),
        SizedBox(width: scale.getWidth(2)),
        Text(this.title,style: Theme.of(context).textTheme.headline2),
      ],
    );
  }
}
