import 'package:adscoin/config/string_config.dart';
import 'package:adscoin/helper/ScreenScaleHelper.dart';
import 'package:adscoin/helper/functionalWidgetHelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CheckoutComponent extends StatefulWidget {
  @override
  _CheckoutComponentState createState() => _CheckoutComponentState();
}

class _CheckoutComponentState extends State<CheckoutComponent> {
  @override
  Widget build(BuildContext context) {
    ScreenScaleHelper scale = ScreenScaleHelper()..init(context);
    return Scaffold(
      appBar: FunctionalWidget.appBarHelper(context: context,title: "Checkout"),
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
                          spaceText(
                              context: context,
                              title: "Pengerjaan",
                              desc: "2 hari"
                          ),
                          spaceText(
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
                  betweenText(title: "Harga produk",desc: "Rp 30,000"),
                  betweenText(title: "Harga kebutuhan lain",desc: "Rp 30,000"),
                  SizedBox(height: scale.getHeight(0.5)),
                  betweenText(title: "Subtotal",desc: "Rp 30,000",color: Colors.white54),
                ],
              ),
            )
          )
        ],
      ),
      bottomNavigationBar: FunctionalWidget.bottomBar(
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
      ),
    );
  }
  Widget betweenText({String title,String desc,Color color}){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,style: Theme.of(context).textTheme.headline2.copyWith(color: color==null?Theme.of(context).textTheme.subtitle1.color:Theme.of(context).textTheme.headline2.color)),
        Text(desc,style: Theme.of(context).textTheme.headline2),
      ],
    );
  }

  Widget spaceText({BuildContext context,String title, String desc}){
    ScreenScaleHelper scale = ScreenScaleHelper()..init(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          child: Text(title,style: Theme.of(context).textTheme.headline2.copyWith(color: Theme.of(context).textTheme.subtitle1.color)),
          width: scale.getWidth(20),
        ),
        Text(":",style: Theme.of(context).textTheme.subtitle1.copyWith(color: Theme.of(context).textTheme.subtitle2.color)),
        SizedBox(width: scale.getWidth(1)),
        Text(desc,style: Theme.of(context).textTheme.headline2),
      ],
    );
  }

}
