import 'package:adscoin/config/string_config.dart';
import 'package:adscoin/helper/functionalWidgetHelper.dart';
import 'package:adscoin/service/provider/GeneralProvider.dart';
import 'package:adscoin/service/provider/productProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class CheckoutComponent extends StatefulWidget {
  @override
  _CheckoutComponentState createState() => _CheckoutComponentState();
}

class _CheckoutComponentState extends State<CheckoutComponent> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<GeneralProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    ScreenScaler scale= ScreenScaler()..init(context);
    final general = Provider.of<GeneralProvider>(context);
    final product = Provider.of<ProductProvider>(context);
    return Scaffold(
      appBar: FunctionalWidget.appBarHelper(context: context,title:"Checkout"),
      body: ListView(
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
                          Text("Copywriting untuk Website",style: Theme.of(context).textTheme.headline2,),
                          FunctionalWidget.spaceText(
                              context: context,
                              title: "Rating",
                              desc: "2 hari",
                            child: FunctionalWidget.rating(context: context,rate: double.parse(product.detailProductModel.result.rating.toString()))
                          ),
                          FunctionalWidget.spaceText(
                              context: context,
                              title: "Penulis",
                              desc: product.detailProductModel.result.seller
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
                  FunctionalWidget.betweenText(context:context,title: "Harga produk",desc: FunctionalWidget.toCoin(double.parse(product.detailProductModel.result.price))),
                  FunctionalWidget.betweenText(context:context,title: "Biaya admin",desc: FunctionalWidget.toCoin(double.parse("0"))),
                  SizedBox(height: scale.getHeight(0.5)),
                  FunctionalWidget.betweenText(context:context,title: "Subtotal",desc:FunctionalWidget.toCoin(double.parse(product.detailProductModel.result.price)),color: Colors.white54),
                ],
              ),
            )
          )
        ],
      ),
      bottomNavigationBar:FunctionalWidget.bottomBar(
        context: context,
        title: "Saldo anda",
        desc: "Rp 300,000",
        btnText: "Bayar",
        callback: (){
          // Navigator.of(context).pushNamed(RouteString.detailCheckout);
          //
          Navigator.of(context).pushNamed(RouteString.pin,arguments:(code)async{
            product.storeCheckoutProduct(
              context: context,
              pin: code
            );
          });
        }
      )
    );
  }



}
