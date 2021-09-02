import 'package:adscoin/config/string_config.dart';
import 'package:adscoin/helper/functionalWidgetHelper.dart';
import 'package:adscoin/view/widget/fintech/historyMutationWidget.dart';
import 'package:adscoin/view/widget/general/titleSectionWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';

class HistoryMutationComponent extends StatefulWidget {
  @override
  _HistoryMutationComponentState createState() => _HistoryMutationComponentState();
}

class _HistoryMutationComponentState extends State<HistoryMutationComponent> {
  @override
  Widget build(BuildContext context) {
    ScreenScaler scale= ScreenScaler()..init(context);
    return Scaffold(
      appBar: FunctionalWidget.appBarHelper(
        context: context,title: "Mutasi"
      ),
      body: ListView.separated(
        shrinkWrap: true,
        physics: ScrollPhysics(),
          padding: scale.getPadding(1,2.5),
          itemBuilder: (context,index){
            return Wrap(
              children: [
                TitleSectionWidget(title: "Hari ini", callback:(){},isAction: false),
                SizedBox(height: scale.getHeight(2)),
                FunctionalWidget.wrapContent(
                    child: ListView.separated(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        physics: ScrollPhysics(),
                        padding: scale.getPadding(1,2),
                        itemBuilder: (context,index){
                          return HistoryMutationWidget(
                            note: "Copywriting webstite",
                            trxIn: index%2==0?120000.00:0.00,
                            trxOut: index%2!=0?120000.700000:0.00,
                            image: GeneralString.dummyImgProduct,
                            status: "Pembayaran",
                          );

                        },
                        separatorBuilder: (context,index){return Divider();},
                        itemCount: 2
                    )
                )
              ],
            );
          },
        itemCount: 10,
        separatorBuilder: (context,index){return SizedBox(height: scale.getHeight(1));},
      ),
    );
  }
}
