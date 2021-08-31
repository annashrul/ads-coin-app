import 'package:adscoin/config/color_config.dart';
import 'package:adscoin/config/string_config.dart';
import 'package:adscoin/helper/functionalWidgetHelper.dart';
import 'package:adscoin/service/provider/GeneralProvider.dart';
import 'package:adscoin/view/widget/general/buttonWidget.dart';
import 'package:adscoin/view/widget/general/touchWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:provider/provider.dart';

class HistoryPurchaseComponent extends StatefulWidget {
  @override
  _HistoryPurchaseComponentState createState() => _HistoryPurchaseComponentState();
}

class _HistoryPurchaseComponentState extends State<HistoryPurchaseComponent> {
  @override
  Widget build(BuildContext context) {
    final general = Provider.of<GeneralProvider>(context);

    ScreenScaler scale= ScreenScaler()..init(context);
    return Scaffold(
      appBar: FunctionalWidget.appBarHelper(context: context,title: "Laporan pembelian"),
      body: ListView.separated(
        padding: scale.getPadding(1,2.5),
        itemCount: 10,
        itemBuilder: (context,index){
          return InTouchWidget(
            radius: 10,
              callback: (){
                general.setConditionCheckoutAndDetail(false);
                Navigator.of(context).pushNamed(RouteString.checkout);
              },
              child: FunctionalWidget.wrapContent(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        padding: scale.getPaddingLTRB(2,1, 0,0),
                        child: Row(
                          children: [
                            Container(
                              height: scale.getHeight(7),
                              width: scale.getWidth(15),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(GeneralString.dummyImgProduct)
                                  )
                              ),
                            ),
                            SizedBox(width: scale.getWidth(2)),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Copywriting untuk Website",style: Theme.of(context).textTheme.headline2,),
                                FunctionalWidget.spaceText(
                                    context: context,
                                    title: "Pengerjaan",
                                    desc: "2 hari"
                                ),
                                FunctionalWidget.spaceText(
                                    context: context,
                                    title: "Penulis",
                                    desc: "Ari Yahya"
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      Container(
                        alignment: Alignment.topCenter,
                        width: scale.getWidth(30),
                        margin: scale.getMarginLTRB(0,0,2,1),
                        child: BackroundButtonWidget(
                          callback: (){
                            Navigator.of(context).pushNamed(RouteString.checkout);
                          },
                          backgroundColor: ColorConfig.redColor,
                          title: "Pesan lagi",
                        ),
                      )
                    ],
                  )
              )
          );
        },
        separatorBuilder: (context,index){return SizedBox(height: scale.getHeight(1));},
      ),
    );
  }
}
