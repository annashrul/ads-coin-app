import 'package:adscoin/config/color_config.dart';
import 'package:adscoin/config/string_config.dart';
import 'package:adscoin/helper/functionalWidgetHelper.dart';
import 'package:adscoin/model/product/detailProductModel.dart';
import 'package:adscoin/service/provider/GeneralProvider.dart';
import 'package:adscoin/service/provider/historyProvider.dart';
import 'package:adscoin/service/provider/productProvider.dart';
import 'package:adscoin/view/component/loadingComponent.dart';
import 'package:adscoin/view/widget/general/buttonWidget.dart';
import 'package:adscoin/view/widget/general/touchWidget.dart';
import 'package:adscoin/view/widget/history/modalActionHistoryPurchaseWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HistoryPurchaseComponent extends StatefulWidget {
  @override
  _HistoryPurchaseComponentState createState() => _HistoryPurchaseComponentState();
}

class _HistoryPurchaseComponentState extends State<HistoryPurchaseComponent> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final history = Provider.of<HistoryProvider>(context, listen: false);
    history.getHistoryPurchase(context: context,where: "page=1");
    initializeDateFormatting('id');
  }

  @override
  Widget build(BuildContext context) {
    final general = Provider.of<GeneralProvider>(context);
    final history = Provider.of<HistoryProvider>(context);
    final product = Provider.of<ProductProvider>(context);

    ScreenScaler scale= ScreenScaler()..init(context);
    return Scaffold(
      appBar: FunctionalWidget.appBarHelper(context: context,title: "Laporan pembelian"),
      body: history.isLoading?LoadingHistoryPurchase():ListView.separated(
        padding: scale.getPadding(1,2.5),
        itemCount: history.historyPurchaseModel.result.length,
        itemBuilder: (context,index){
          final val = history.historyPurchaseModel.result[index];
          String tag = "historyPurchaseComponent" + val.idProduct;
          return FunctionalWidget.wrapContent(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: scale.getPaddingLTRB(2,1, 1,0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(val.kdTrx,style: Theme.of(context).textTheme.subtitle1),
                            SizedBox(height: 2.0),
                            Text("${DateFormat.yMMMMEEEEd('id').format(val.createdAt)} ${DateFormat.Hms().format(val.createdAt)}",style: Theme.of(context).textTheme.subtitle1),
                          ],
                        ),
                        InTouchWidget(
                          radius: 100,
                          callback: (){
                            FunctionalWidget.modal(
                              context: context,
                              child: ModalActionHistoryPurchaseWidget(
                                  dataJson: val.toJson()..addAll({"tag":tag})
                              )
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            padding: scale.getPadding(0.5, 1),
                            child:Icon(Ionicons.ios_more)
                          ),
                        )

                        // WidgetHelper().myStatus(context,val.status)
                      ],
                    ),
                  ),
                  Divider(),

                  Container(
                    padding: scale.getPaddingLTRB(2,0, 0,0),
                    child: Row(
                      children: [
                        Hero(
                          tag: tag,
                          child: Container(
                            height: scale.getHeight(5),
                            width: scale.getWidth(15),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(GeneralString.dummyImgProduct)
                                )
                            ),
                          ),
                          
                        ),
                        SizedBox(width: scale.getWidth(2)),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(val.title,style: Theme.of(context).textTheme.headline2,),
                            FunctionalWidget.spaceText(
                                context: context,
                                title: "Seller",
                                desc: val.seller
                            )
                          ],
                        )
                      ],
                    ),
                  ),

                  Container(
                      padding: scale.getPaddingLTRB(2,1, 0,1),

                      child:Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FunctionalWidget.spaceText(
                              context: context,
                              title: "Grand total",
                              desc:  FunctionalWidget.toCoin(double.parse(val.grandTotal))
                          ),
                          FunctionalWidget.spaceText(
                              context: context,
                              title: "Biaya admin",
                              desc: FunctionalWidget.toCoin(double.parse(val.biayaAdmin))
                          )
                        ],
                      )
                  )


                  // Container(
                  //   width: scale.getWidth(40),
                  //   alignment: Alignment.topCenter,
                  //   margin: scale.getMarginLTRB(0,0,2,1),
                  //   child: BackroundButtonWidget(
                  //     callback: (){
                  //       Navigator.of(context).pushNamed(RouteString.detailProduct,arguments: "");
                  //     },
                  //     backgroundColor: ColorConfig.redColor,
                  //     title: "Lihat produk",
                  //   ),
                  // )
                ],
              )
          );
        },
        separatorBuilder: (context,index){return SizedBox(height: scale.getHeight(1));},
      ),
    );
  }
}
