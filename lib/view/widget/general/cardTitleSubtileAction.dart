import 'package:adscoin/config/string_config.dart';
import 'package:adscoin/view/widget/general/touchWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';

class CardTitleSubtitleAction extends StatefulWidget {
  final String image;
  final String title;
  final String subtitle;
  final Function callback;

  CardTitleSubtitleAction({this.image,this.title,this.subtitle,this.callback});


  @override
  _CardTitleSubtitleActionState createState() => _CardTitleSubtitleActionState();
}

class _CardTitleSubtitleActionState extends State<CardTitleSubtitleAction> {
  @override
  Widget build(BuildContext context) {
    ScreenScaler scale = ScreenScaler()..init(context);
    return InTouchWidget(
        callback: ()=>widget.callback(),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 20,
              backgroundImage: NetworkImage(GeneralString.dummyImgProduct),
            ),
            SizedBox(width: scale.getWidth(2)),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Bank Mandiri",style: Theme.of(context).textTheme.headline2),
                Text("Ads coin",style: Theme.of(context).textTheme.subtitle1),
              ],
            )
          ],
        )
    );
  }
}
