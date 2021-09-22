import 'package:adscoin/config/color_config.dart';
import 'package:adscoin/config/string_config.dart';
import 'package:adscoin/helper/functionalWidgetHelper.dart';
import 'package:adscoin/service/provider/productProvider.dart';
import 'package:adscoin/view/widget/general/cardAction.dart';
import 'package:adscoin/view/widget/general/cardTitleAction.dart';
import 'package:adscoin/view/widget/general/touchWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:provider/provider.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class ModalActionHistoryPurchaseWidget extends StatefulWidget {
  final dynamic dataJson;
  ModalActionHistoryPurchaseWidget({this.dataJson});
  @override
  _ModalActionHistoryPurchaseWidgetState createState() => _ModalActionHistoryPurchaseWidgetState();
}

class _ModalActionHistoryPurchaseWidgetState extends State<ModalActionHistoryPurchaseWidget> {
  int rate=0;



  @override
  Widget build(BuildContext context) {
    print(widget.dataJson["rating"]);
    ScreenScaler scale = ScreenScaler()..init(context);
    final product = Provider.of<ProductProvider>(context);
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          if(widget.dataJson["rating"]==null||widget.dataJson["rating"]==0)CardAction(
            icon: FlutterIcons.star_border_mdi,
            title: "Beri rating",
            callback: (){
              print(widget.dataJson["rating"]);
              FunctionalWidget.dialog(
                context: context,
                child: AlertDialog(
                  title:Text("Beri rating untuk produk ${widget.dataJson["title"]}",style: Theme.of(context).textTheme.headline1),
                  content:SmoothStarRating(
                      allowHalfRating: false,
                      onRated: (v)async {
                        setState(() {
                          rate = int.parse(v.toString().replaceAll(".0", ""));
                        });
                      },
                      starCount: 5,
                      rating: 0,
                      size: scale.getTextSize(15),
                      isReadOnly:false,
                      color:ColorConfig.yellowColor,
                      borderColor:ColorConfig.yellowColor,
                      spacing:0.0
                  ),
                  actions: <Widget>[
                    TextButton(
                        onPressed:()=>Navigator.of(context).pop(),
                        child:Text("Kembali",style: Theme.of(context).textTheme.subtitle1)
                    ),
                    TextButton(
                        onPressed:(){
                          print(rate);
                          Navigator.of(context).pop();
                          product.storeRateProduct(context: context,rate:rate);
                        },
                        child:Text("Simpan",style: Theme.of(context).textTheme.subtitle1.copyWith(color: ColorConfig.yellowColor))
                    ),
                  ],
                )
              );
            },
            colorIcon: ColorConfig.blackSecondaryColor,
          ),
          CardAction(
            icon: FlutterIcons.eye_check_mco,
            title: "Lihat produk",
            callback: (){
              Navigator.of(context).pushNamed(RouteString.detailProduct,arguments: {
                "image":widget.dataJson["image_product"],
                "heroTag":widget.dataJson["tag"],
                "id":widget.dataJson["id_product"]
              });
            },
            colorIcon: ColorConfig.blackSecondaryColor,
          ),
          CardAction(
            icon: FlutterIcons.eye_check_mco,
            title: "Lihat detail laporan",
            callback: (){
              Navigator.of(context).pushNamed(RouteString.detailHistoryPurchase,arguments: FunctionalWidget.btoa(widget.dataJson["kd_trx"]));
            },
            colorIcon: ColorConfig.blackSecondaryColor,
          ),
          // InTouchWidget(
          //   callback: (){
          //   },
          //   child: Container(
          //     padding: scale.getPadding(1,2),
          //     child: Row(
          //       children: [
          //         Icon(FlutterIcons.eye_check_mco),
          //         SizedBox(width: scale.getWidth(1)),
          //         Text("Lihat produk",style: Theme.of(context).textTheme.headline2,)
          //       ],
          //     ),
          //   )
          // ),
          //
          // InTouchWidget(
          //     callback: (){
          //     },
          //     child: Container(
          //       padding: scale.getPadding(1,2),
          //       child: Row(
          //         children: [
          //           Icon(FlutterIcons.eye_check_mco),
          //           SizedBox(width: scale.getWidth(1)),
          //           Text("Lihat detail laporan",style: Theme.of(context).textTheme.headline2,)
          //         ],
          //       ),
          //     )
          // ),
        ],
      ),
    );
  }
}
