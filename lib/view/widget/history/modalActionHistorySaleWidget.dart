import 'package:adscoin/config/string_config.dart';
import 'package:adscoin/helper/functionalWidgetHelper.dart';
import 'package:adscoin/view/widget/general/touchWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';

class ModalActionHistorySaleWidget extends StatefulWidget {
  final dynamic dataJson;
  ModalActionHistorySaleWidget({this.dataJson});
  @override
  _ModalActionHistorySaleWidgetState createState() => _ModalActionHistorySaleWidgetState();
}

class _ModalActionHistorySaleWidgetState extends State<ModalActionHistorySaleWidget> {
  @override
  Widget build(BuildContext context) {
    print(widget.dataJson);
    ScreenScaler scale = ScreenScaler()..init(context);
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          InTouchWidget(
              callback: (){
                Navigator.of(context).pushNamed(RouteString.detailProduct,arguments: {
                  "image":widget.dataJson["image_product"],
                  "heroTag":widget.dataJson["tag"],
                  "id":widget.dataJson["id_product"]
                });
              },
              child: Container(
                padding: scale.getPadding(1,2),
                child: Row(
                  children: [
                    Icon(FlutterIcons.eye_check_mco),
                    SizedBox(width: scale.getWidth(1)),
                    Text("Lihat produk",style: Theme.of(context).textTheme.headline2,)
                  ],
                ),
              )
          ),

          InTouchWidget(
              callback: (){
                Navigator.of(context).pushNamed(RouteString.detailHistorSale,arguments: FunctionalWidget.btoa(widget.dataJson["kd_trx"]));
              },
              child: Container(
                padding: scale.getPadding(1,2),
                child: Row(
                  children: [
                    Icon(FlutterIcons.eye_check_mco),
                    SizedBox(width: scale.getWidth(1)),
                    Text("Lihat detail laporan",style: Theme.of(context).textTheme.headline2,)
                  ],
                ),
              )
          ),
        ],
      ),
    );
  }
}
