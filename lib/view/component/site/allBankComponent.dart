import 'package:adscoin/helper/functionalWidgetHelper.dart';
import 'package:adscoin/service/provider/siteProvider.dart';
import 'package:adscoin/view/widget/general/imageRoundedWidget.dart';
import 'package:adscoin/view/widget/general/touchWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:provider/provider.dart';

class AllBankComponent extends StatefulWidget {
  @override
  _AllBankComponentState createState() => _AllBankComponentState();
}

class _AllBankComponentState extends State<AllBankComponent> {
  @override
  Widget build(BuildContext context) {
    final site = Provider.of<SiteProvider>(context);
    ScreenScaler scale = ScreenScaler()..init(context);

    return Scaffold(
      appBar: FunctionalWidget.appBarHelper(context: context,title: "Daftar bank"),
      body: ListView.separated(
          padding: scale.getPadding(0, 2.5),
          itemBuilder: (context,index){
            final val = site.allBankModel.result[index];
            return InTouchWidget(
              radius: 10,
              callback: (){
                site.setIndexAllBank(index);
                Navigator.of(context).pop();
              },
              child: FunctionalWidget.wrapContent(
                  child: ListTile(
                      leading: ImageRoundedWidget(img: val.logo,height: scale.getHeight(3),width: scale.getWidth(8),),
                      title: Text(val.name,style: Theme.of(context).textTheme.headline2),
                      subtitle:Text(val.code,style: Theme.of(context).textTheme.subtitle1),
                  )
              ),
            );
          },
          separatorBuilder: (context,index){return SizedBox(height: scale.getHeight(0.5));},
          itemCount:site.allBankModel.result.length
      ),
    );
  }
}
