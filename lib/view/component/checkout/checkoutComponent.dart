import 'package:adscoin/config/string_config.dart';
import 'package:adscoin/helper/ScreenScaleHelper.dart';
import 'package:adscoin/helper/functionalWidgetHelper.dart';
import 'package:adscoin/service/provider/GeneralProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
    ScreenScaleHelper scale = ScreenScaleHelper()..init(context);
    final general = Provider.of<GeneralProvider>(context);
    return Scaffold(
      appBar: FunctionalWidget.appBarHelper(context: context,title: general.conditionCheckoutAndDetail?"Checkout":"Detail pembelian"),
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
                              title: "Pengerjaan",
                              desc: "2 hari"
                          ),
                          FunctionalWidget.spaceText(
                              context: context,
                              title: "Penulis",
                              desc: "Ari Yahya"
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
                  FunctionalWidget.betweenText(context:context,title: "Harga produk",desc: "Rp 30,000"),
                  FunctionalWidget.betweenText(context:context,title: "Harga kebutuhan lain",desc: "Rp 30,000"),
                  SizedBox(height: scale.getHeight(0.5)),
                  FunctionalWidget.betweenText(context:context,title: "Subtotal",desc: "Rp 30,000",color: Colors.white54),
                ],
              ),
            )
          )
        ],
      ),
      bottomNavigationBar: general.conditionCheckoutAndDetail?FunctionalWidget.bottomBar(
        context: context,
        title: "Saldo anda",
        desc: "Rp 300,000",
        btnText: "Bayar",
        callback: (){
          Navigator.of(context).pushNamed(RouteString.pin,arguments:(code)async{
            FunctionalWidget.loadingDialog(context);
            await Future.delayed(Duration(seconds: 2));
            Navigator.of(context).pop();
            Navigator.of(context).pushNamed(RouteString.detailCheckout);

          });
        }
      ):SizedBox(),
    );
  }



}
