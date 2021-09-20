import 'package:adscoin/config/color_config.dart';
import 'package:adscoin/config/string_config.dart';
import 'package:adscoin/helper/formatCurrencyHelper.dart';
import 'package:adscoin/helper/functionalWidgetHelper.dart';
import 'package:adscoin/service/provider/historyProvider.dart';
import 'package:adscoin/view/component/loadingComponent.dart';
import 'package:adscoin/view/widget/fintech/historyMutationWidget.dart';
import 'package:adscoin/view/widget/general/imageRoundedWidget.dart';
import 'package:adscoin/view/widget/general/noDataWidget.dart';
import 'package:adscoin/view/widget/general/titleSectionWidget.dart';
import 'package:adscoin/view/widget/home/cardSaldoWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:provider/provider.dart';


class IndexFintechComponent extends StatefulWidget {
  @override
  _IndexFintechComponentState createState() => _IndexFintechComponentState();
}

class _IndexFintechComponentState extends State<IndexFintechComponent> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final history = Provider.of<HistoryProvider>(context,listen:false);
    history.getHistoryMutation(context: context,isNow: true);
  }

  @override
  Widget build(BuildContext context) {
    ScreenScaler scale = ScreenScaler()..init(context);
    final history = Provider.of<HistoryProvider>(context);

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
              Navigator.of(context).pushNamed(RouteString.historyMutation).then((value) =>  history.getHistoryMutation(context: context,isNow: true));
            },),
          ),
          Expanded(
              flex: 1,
              child: Padding(
                padding: scale.getPadding(0, 2.5),
                child: history.isLoadingHistoryMutation?LoadingBankMember():history.historyMutationModel==null?NoDataWidget():ListView.separated(
                      padding: scale.getPadding(0,0),
                      itemBuilder: (context,index){
                        final val = history.historyMutationModel.result[index];
                        String nominal="+ ${FunctionalWidget.toCoin(double.parse(val.trxIn))}";
                        Color colorNominal = ColorConfig.blackPrimaryColor;
                        if(double.parse(val.trxOut)>0){
                          nominal = "- ${FunctionalWidget.toCoin(double.parse(val.trxOut))}";
                          colorNominal = ColorConfig.redColor;
                        }
                        Color color;
                        if(val.type=="Penarikan")color = ColorConfig.bluePrimaryColor;
                        else if(val.type=="Deposit")color = ColorConfig.yellowColor;
                        else color = ColorConfig.purplePrimaryColor;
                        return FunctionalWidget.wrapContent(
                            child:ListTile(
                              leading: ImageRoundedWidget(
                                img: val.foto,
                                height: scale.getHeight(3),
                                width: scale.getWidth(8),
                              ),
                              title: Text(val.note,style: Theme.of(context).textTheme.subtitle1,),
                              subtitle: Text(val.type,style: Theme.of(context).textTheme.subtitle1.copyWith(color:color),),
                              trailing: Text(nominal,style: Theme.of(context).textTheme.subtitle1.copyWith(color: colorNominal),),
                            )
                        );

                      },
                      separatorBuilder: (context,index){return SizedBox(height: scale.getHeight(0.5),);},
                      itemCount: history.historyMutationModel.result.length
                  )

              )
          ),
        ],
      ),
    );
  }
}
