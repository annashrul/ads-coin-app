import 'package:adscoin/config/color_config.dart';
import 'package:adscoin/view/widget/general/touchWidget.dart';
import 'package:flutter/material.dart';

class TitleSectionWidget extends StatelessWidget {
  final String title;
  final Function callback;
  final String titleAction;
  final bool isAction;
  TitleSectionWidget({@required this.title, @required this.callback,this.titleAction,this.isAction=true});

  @override
  Widget build(BuildContext context) {
    return InTouchWidget(
        callback: (){callback();},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title,style: Theme.of(context).textTheme.headline1),
            if(isAction)Text(titleAction==null?"Lihat semua":titleAction,style: Theme.of(context).textTheme.subtitle1.copyWith(color: ColorConfig.bluePrimaryColor)),
          ],
        )
    );
  }
}
