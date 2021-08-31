import 'package:adscoin/config/color_config.dart';
import 'package:adscoin/helper/ScreenScaleHelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

// ignore: must_be_immutable
class AppBarWithActionWidget extends StatefulWidget {
  final Color color;
  Function(String any) callback;
  AppBarWithActionWidget({this.color,this.callback});
  @override
  _AppBarWithActionWidgetState createState() => _AppBarWithActionWidgetState();
}

class _AppBarWithActionWidgetState extends State<AppBarWithActionWidget> {
  TextEditingController anyController;
  @override
  Widget build(BuildContext context) {
    ScreenScaleHelper scale = ScreenScaleHelper()..init(context);
    return SliverAppBar(
      toolbarHeight: scale.getHeight(7),
      backgroundColor: widget.color!=null? widget.color:Colors.white,
      pinned: true,
      title: Container(
        child:Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: scale.getPadding(0, 0),
              width:scale.getWidth(72),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xFFF2F2F2)
              ),
              child: TextField(
                controller: anyController,
                decoration: InputDecoration(
                  contentPadding: scale.getPadding(1,2),
                  hintStyle: Theme.of(context).textTheme.subtitle1,
                  hintText:"Ads copy, landingpage, caption",
                  border: InputBorder.none,
                  suffixIcon: Icon(FlutterIcons.search_fea,color: Theme.of(context).textTheme.subtitle1.color,),
                ),
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.search,
              ),
            ),
            InkResponse(
              onTap: (){},
              child: Icon(
                  FlutterIcons.share_alt_faw,
                  size: scale.getTextSize(15),
                  color:ColorConfig.graySecondaryColor
              ),
            )
          ],
        ),
      ),
    );
  }
}

