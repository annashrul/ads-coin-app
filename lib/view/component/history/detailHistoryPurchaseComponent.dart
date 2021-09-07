import 'package:adscoin/config/string_config.dart';
import 'package:adscoin/helper/functionalWidgetHelper.dart';
import 'package:adscoin/service/provider/historyProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:provider/provider.dart';

class DetailHistoryPurchaseComponent extends StatefulWidget {
  final String id;
  DetailHistoryPurchaseComponent({this.id});
  @override
  _DetailHistoryPurchaseComponentState createState() => _DetailHistoryPurchaseComponentState();
}

class _DetailHistoryPurchaseComponentState extends State<DetailHistoryPurchaseComponent> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final history = Provider.of<HistoryProvider>(context, listen: false);
    history.getDetailHistoryPurchase(context: context,id:widget.id);
  }
  @override
  Widget build(BuildContext context) {
    ScreenScaler scale= ScreenScaler()..init(context);
    final history = Provider.of<HistoryProvider>(context);

    return Scaffold(
      appBar: FunctionalWidget.appBarHelper(context: context,title: "Detail pembelian"),
      body: history.isLoadingDetailPurchase?Text("loading"):ListView(
        padding: scale.getPadding(1,2),
        children: [
          FunctionalWidget.wrapContent(
              child: Container(
                padding: scale.getPadding(1,2),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Detail pesanan",style: Theme.of(context).textTheme.headline1),
                    SizedBox(height: scale.getHeight(1)),
                    Row(
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
                            Text(history.detailHistoryPurchaseModel.result.title,style: Theme.of(context).textTheme.headline2,),
                            FunctionalWidget.spaceText(
                                context: context,
                                title: "Rating",
                                child: FunctionalWidget.rating(context: context,rate: double.parse(2.toString()))
                            ),
                            FunctionalWidget.spaceText(
                                context: context,
                                title: "Penulis",
                                desc:history.detailHistoryPurchaseModel.result.seller
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ),
              )
          ),
          SizedBox(height: scale.getHeight(1)),
          FunctionalWidget.wrapContent(
              child: Container(
                padding: scale.getPadding(1,2),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Ringkasan belanja",style: Theme.of(context).textTheme.headline1),
                    SizedBox(height: scale.getHeight(1)),
                    FunctionalWidget.betweenText(context:context,title: "Harga produk",desc: FunctionalWidget.toCoin(double.parse(history.detailHistoryPurchaseModel.result.grandTotal))),
                    FunctionalWidget.betweenText(context:context,title: "Biaya admin",desc: FunctionalWidget.toCoin(double.parse(history.detailHistoryPurchaseModel.result.biayaAdmin))),
                    SizedBox(height: scale.getHeight(0.5)),
                    FunctionalWidget.betweenText(context:context,title: "Subtotal",desc:FunctionalWidget.toCoin(double.parse(history.detailHistoryPurchaseModel.result.grandTotal)),color: Colors.white54),
                  ],
                ),
              )
          )
        ],
      ),

    );
  }
}
