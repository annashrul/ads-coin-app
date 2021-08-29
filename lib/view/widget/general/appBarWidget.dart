import 'package:adscoin/helper/ScreenScaleHelper.dart';
import 'package:adscoin/view/widget/general/touchWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class AppBarWidget extends StatelessWidget {
  bool isDefault;
  String title;

  @override
  Widget build(BuildContext context) {
    ScreenScaleHelper scale = ScreenScaleHelper()..init(context);
    return AppBar(
      titleSpacing: 0.0,
      automaticallyImplyLeading: false,
      toolbarHeight: scale.getHeight(4),
      elevation: 0.0,
      title:Row(
        children: [
          InTouchWidget(
            callback: (){},
            child: Container(
              padding: scale.getPadding(0.5, 2),
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: <Widget>[
                  Container(
                      alignment: Alignment.center,
                      child: Icon(Ionicons.ios_arrow_round_back,color: Theme.of(context).hintColor)
                  ),
                ],
              ),
            )
          ),

          SizedBox(width: scale.getWidth(1)),
          Text(title,style: Theme.of(context).textTheme.headline1,)
        ],
      ),

    );
  }
}
