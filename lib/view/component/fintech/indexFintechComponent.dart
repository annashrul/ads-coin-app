import 'package:adscoin/config/color_config.dart';
import 'package:adscoin/config/string_config.dart';
import 'package:adscoin/helper/functionalWidgetHelper.dart';
import 'package:adscoin/view/widget/fintech/historyMutationWidget.dart';
import 'package:adscoin/view/widget/general/titleSectionWidget.dart';
import 'package:adscoin/view/widget/home/cardSaldoWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';


class IndexFintechComponent extends StatefulWidget {
  @override
  _IndexFintechComponentState createState() => _IndexFintechComponentState();
}

class _IndexFintechComponentState extends State<IndexFintechComponent> {
  @override
  Widget build(BuildContext context) {
    ScreenScaler scale = ScreenScaler()..init(context);
    return Scaffold(
      backgroundColor: Color(0xFFE5E5E5),
      appBar: FunctionalWidget.appBarHelper(context: context,title: "Ads Coin Wallet",backgroundColor: ColorConfig.redColor,titleColor: ColorConfig.graySecondaryColor),
      body: Column(
        children: [
          Stack(
            children: [
              DecoratedBox(
                  decoration: BoxDecoration(
                      color: ColorConfig.redColor,
                  ),
                  child: Container(
                    width: double.infinity,
                    height: scale.getHeight(5),
                  )
              ),
              Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children:<Widget>[
                    Container(height: scale.getHeight(2)),
                    Container(
                      padding: scale.getPadding(0,2.5),
                      child: CardSaldoWidget(),
                    ),
                  ]
              )
            ],
          ),
          SizedBox(height: scale.getHeight(1)),
          Padding(
            padding: scale.getPadding(1, 2.5),
            child: TitleSectionWidget(title: "Transaksi terakhir",callback: (){
              Navigator.of(context).pushNamed(RouteString.historyMutation);
            },),
          ),
          Expanded(
              flex: 1,
              child: Padding(
                padding: scale.getPadding(0, 2.5),
                child: FunctionalWidget.wrapContent(
                    child: ListView.separated(
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
                        itemCount: 100
                    )
                ),
              )
          ),
        ],
      ),
    );
  }
}
