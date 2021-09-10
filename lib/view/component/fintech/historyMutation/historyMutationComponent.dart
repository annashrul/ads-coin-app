import 'package:adscoin/config/color_config.dart';
import 'package:adscoin/helper/dateHelper.dart';
import 'package:adscoin/helper/formatCurrencyHelper.dart';
import 'package:adscoin/helper/functionalWidgetHelper.dart';
import 'package:adscoin/service/provider/historyProvider.dart';
import 'package:adscoin/view/component/loadingComponent.dart';
import 'package:adscoin/view/widget/general/imageRoundedWidget.dart';
import 'package:adscoin/view/widget/general/noDataWidget.dart';
import 'package:adscoin/view/widget/general/touchWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:provider/provider.dart';

class HistoryMutationComponent extends StatefulWidget {
  @override
  _HistoryMutationComponentState createState() => _HistoryMutationComponentState();
}

class _HistoryMutationComponentState extends State<HistoryMutationComponent> {
  ScrollController controller;
  void scrollListener() {
    final history = Provider.of<HistoryProvider>(context, listen: false);
    if (!history.isLoadingHistoryMutation) {
      if (controller.position.pixels == controller.position.maxScrollExtent) {
        history.loadMoreHistoryMutation(context);

      }
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = new ScrollController()..addListener(scrollListener);
    final history = Provider.of<HistoryProvider>(context,listen:false);
    history.getHistoryMutation(context: context);
  }
  @override
  void dispose() {
    super.dispose();
    controller.removeListener(scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    ScreenScaler scale= ScreenScaler()..init(context);
    final history = Provider.of<HistoryProvider>(context);
    return Scaffold(
      appBar: FunctionalWidget.appBarHelper(
        context: context,title: "Mutasi"
      ),
      body: Column(
        children: [
          FunctionalWidget.filterDate(
            context: context,
            data: {"from":history.fromHistoryMutation,"to":history.toHistoryMutation},
            callback: (from,to){
              history.setDateFromDateToHistoryMutation(context: context,input: {"from":from,"to":to});
            }
          ),
          Expanded(
            child: history.isLoadingHistoryMutation?LoadingHistoryPurchase():history.historyMutationModel==null?NoDataWidget():ListView.separated(
              controller: controller,
              shrinkWrap: true,
              physics: ScrollPhysics(),
              padding: scale.getPadding(0.5,2.5),
              itemBuilder: (context,index){
                final val = history.historyMutationModel.result[index];
                String nominal="+ ${MoneyFormat.toCurrency(double.parse(val.trxIn))}";
                Color colorNominal = ColorConfig.blackPrimaryColor;
                if(double.parse(val.trxIn)<1){
                  nominal = "- ${MoneyFormat.toCurrency(double.parse(val.trxOut))}";
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
              itemCount: history.historyMutationModel.result.length,
              separatorBuilder: (context,index){return SizedBox(height: scale.getHeight(1));},
            ),
          )
        ],
      ),
      bottomNavigationBar: history.isLoadMoreHistoryMutation?Container(
        padding: scale.getPadding(1,2),
        child: CupertinoActivityIndicator(),
      ):SizedBox(),
    );
  }
}
