import 'package:adscoin/config/string_config.dart';
import 'package:adscoin/service/provider/productProvider.dart';
import 'package:adscoin/view/widget/general/cardAction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:provider/provider.dart';

class OptionActionProductWidget extends StatefulWidget {
  final dynamic dataJson;
  OptionActionProductWidget({this.dataJson});
  @override
  _OptionActionProductWidgetState createState() => _OptionActionProductWidgetState();
}

class _OptionActionProductWidgetState extends State<OptionActionProductWidget> {
  @override
  Widget build(BuildContext context) {
    ScreenScaler scale = ScreenScaler()..init(context);
    final product = Provider.of<ProductProvider>(context);
    dynamic status = StatusProduct.funcStatusProduct(widget.dataJson["status"].toString());
    print(status);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        CardAction(
          title: "Edit",
          callback: ()async{
            Navigator.of(context).pop();
            product.setIsAdd(false);
            product.setStatusProduct(widget.dataJson["status"]);
            Navigator.of(context).pushNamed(RouteString.formProductContributor).whenComplete(() => product.getProductContributor(context: context));
          },
          img: "Edit",
        ),
        CardAction(
          title: "Hapus",
          callback: ()async{
            product.deleteProductContributor(context: context,id: widget.dataJson["id"]);
          },
          img: "Delete1",
        ),
        CardAction(
          title: "Ubah menjadi ${widget.dataJson["status"]==1?"draft":"publish"}",
          callback: ()async{
            if(widget.dataJson["status"]==0){
              await product.updateToDraft(context: context,status: "1");
            }else{
              await product.updateToDraft(context: context,status: "0");
            }
          },
          img: widget.dataJson["status"]==1?"analytics1":"TickSquare",
        ),
        CardAction(
          title: "Lihat produk",
          callback: ()async{
            Navigator.of(context).pushNamed(RouteString.detailProduct,arguments: {
              "image":widget.dataJson["image"],
              "heroTag":widget.dataJson["heroTag"],
              "id":widget.dataJson["id"],
            });
          },
          img: "analytics",
        ),
      ],
    );
  }
}
