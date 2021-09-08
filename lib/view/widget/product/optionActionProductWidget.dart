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
    print(widget.dataJson);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        CardAction(
          title: "Edit",
          callback: ()async{
            product.setIsAdd(false);
            product.setDataEditProductContributor(widget.dataJson);
            product.setStatusProduct(widget.dataJson["status"]);
            Navigator.of(context).pushNamed(RouteString.formProductContributor);
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
        if(product.filterStatusProduct==1)CardAction(
          title: "Ubah menjadi draft",
          callback: ()async{
            await product.updateToDraft(context: context);
          },
          img: "analytics1",
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
