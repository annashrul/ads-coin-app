import 'package:adscoin/helper/functionalWidgetHelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';

class InfoAdsComponent extends StatefulWidget {
  final String title;
  final String desc;
  InfoAdsComponent({this.title,this.desc});
  @override
  _InfoAdsComponentState createState() => _InfoAdsComponentState();
}

class _InfoAdsComponentState extends State<InfoAdsComponent> {
  @override
  Widget build(BuildContext context) {
    ScreenScaler scale = ScreenScaler()..init(context);
    return Scaffold(
      appBar: FunctionalWidget.appBarHelper(context: context,title: widget.title),
      body: Scrollbar(
        child: ListView(
          // padding: scale.getPadding(1,2.5),
          children: [
            Padding(
              padding: scale.getPadding(1,2.5),
              child: Text(widget.desc,style: Theme.of(context).textTheme.subtitle1),
              // child: Html(
              //   data:  widget.desc,
              //   onLinkTap: (String url){
              //     print(url);
              //   },
              //   style: {
              //     "body": Style(
              //       fontSize: FontSize(16.0),
              //       fontWeight: FontWeight.w400,
              //       margin: EdgeInsets.zero,
              //     ),
              //   },
              // ),
            ),

          ],
        ),
      ),
    );
  }
}
