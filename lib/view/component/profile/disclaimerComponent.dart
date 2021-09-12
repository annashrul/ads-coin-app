import 'package:adscoin/config/color_config.dart';
import 'package:adscoin/config/string_config.dart';
import 'package:adscoin/helper/functionalWidgetHelper.dart';
import 'package:adscoin/service/provider/siteProvider.dart';
import 'package:adscoin/view/widget/general/buttonWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:provider/provider.dart';

class DisclaimerComponent extends StatefulWidget {
  Function callback;
  DisclaimerComponent({this.callback});
  @override
  _DisclaimerComponentState createState() => _DisclaimerComponentState();
}

class _DisclaimerComponentState extends State<DisclaimerComponent> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    // final site = Provider.of<SiteProvider>(context);
    ScreenScaler scale = ScreenScaler()..init(context);
    return Scaffold(
      appBar: FunctionalWidget.appBarHelper(context: context,title: "Disclaimer"),
      body: Scrollbar(
        child: ListView(
          // padding: scale.getPadding(1,2.5),
          children: [
            Padding(
              padding: scale.getPadding(1,2.5),
              child: Text(GeneralString.lorem+GeneralString.lorem+GeneralString.lorem,style: Theme.of(context).textTheme.headline2,),
            ),
            SizedBox(height: scale.getHeight(1)),
            Container(
              alignment: Alignment.centerLeft,
              child:Row(
                children: [
                  Checkbox(
                    // checkColor: ColorConfig.redColor,
                    value: isChecked,
                    onChanged: (value) {
                      print(isChecked);
                      setState(() {
                        isChecked = !isChecked;
                      });
                    },
                  ),
                  Text("saya mengerti dan menyetujui",style: Theme.of(context).textTheme.headline2,),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: scale.getPadding(1,2.5),
        child: BackroundButtonWidget(
          callback: (){
            if(isChecked){
              widget.callback();
            }
          },
          color: !isChecked?ColorConfig.grayPrimaryColor:ColorConfig.graySecondaryColor,
          backgroundColor: !isChecked?ColorConfig.graySecondaryColor:ColorConfig.redColor,
          title: "Lanjut",
        ),
      ),
    );
  }
}
