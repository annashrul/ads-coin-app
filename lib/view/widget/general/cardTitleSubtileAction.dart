import 'package:adscoin/config/string_config.dart';
import 'package:adscoin/view/widget/general/imageRoundedWidget.dart';
import 'package:adscoin/view/widget/general/touchWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';

class CardTitleSubtitleAction extends StatefulWidget {
  final String image;
  final String title;
  final String subtitle;
  final Function callback;
  final bool isIcon;

  CardTitleSubtitleAction({this.image,this.title,this.subtitle,this.callback,this.isIcon=false});


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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  child: ImageRoundedWidget(
                    img: widget.image,
                    height: scale.getHeight(3),
                    width: scale.getWidth(8),
                  ),
                ),
                SizedBox(width: scale.getWidth(2)),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.title,style: Theme.of(context).textTheme.headline2),
                    Text(widget.subtitle,style: Theme.of(context).textTheme.subtitle1),
                  ],
                )
              ],
            ),
            if(widget.isIcon) Icon(FlutterIcons.ios_arrow_dropright_ion)
          ],
        )
    );
  }
}
