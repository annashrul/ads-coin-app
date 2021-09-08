import 'package:adscoin/config/string_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';

class NoDataWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenScaler scale = ScreenScaler()..init(context);
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(GeneralString.imgLocalPng+"eror.png",height:scale.getHeight(20),),
            SizedBox(height: scale.getHeight(1)),
            Text("Data tidak tersedia",style: Theme.of(context).textTheme.headline1)
          ],
        ),
      ),
    );
  }
}
