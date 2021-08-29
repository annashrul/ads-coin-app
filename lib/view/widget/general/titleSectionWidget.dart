import 'package:adscoin/config/color_config.dart';
import 'package:adscoin/helper/ScreenScaleHelper.dart';
import 'package:adscoin/view/widget/general/touchWidget.dart';
import 'package:flutter/material.dart';

class TitleSectionWidget extends StatelessWidget {
  final String title;
  final Function callback;
  TitleSectionWidget({@required this.title, @required this.callback});

  @override
  Widget build(BuildContext context) {
    ScreenScaleHelper scale = ScreenScaleHelper()..init(context);
    return InTouchWidget(
        callback: ()=>callback,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title,style: Theme.of(context).textTheme.headline1),
            Text("Lihat semua",style: Theme.of(context).textTheme.subtitle1.copyWith(color: ColorConfig.yellowColor)),
          ],
        )
    );
  }
}
