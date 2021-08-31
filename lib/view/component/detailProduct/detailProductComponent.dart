import 'package:adscoin/config/color_config.dart';
import 'package:adscoin/config/string_config.dart';
import 'package:adscoin/helper/functionalWidgetHelper.dart';
import 'package:adscoin/service/provider/GeneralProvider.dart';
import 'package:adscoin/view/widget/general/buttonWidget.dart';
import 'package:adscoin/view/widget/general/imageRoundedWidget.dart';
import 'package:adscoin/view/widget/general/touchWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:provider/provider.dart';


// ignore: must_be_immutable
class DetailProductComponent extends StatefulWidget {
  dynamic data;
  DetailProductComponent({this.data});
  @override
  _DetailProductComponentState createState() => _DetailProductComponentState();
}

class _DetailProductComponentState extends State<DetailProductComponent> {
  @override
  Widget build(BuildContext context) {
    final general = Provider.of<GeneralProvider>(context);
    ScreenScaler scale= ScreenScaler()..init(context);
    String desc="Glory Perfume,parfum keluaran terbaru kami. Bahan 100% original dan penggunaannya tahan lama hingga 16 jam. For women only. Harga Rp 150.000 untuk 100ml. Desain botolnya juga unik dan cocok dibawa kemanapun.";
    String splitDesc = desc.split(". ")[0];
    return Scaffold(
      // backgroundColor:Color(0xFFE5E5E5),
      appBar: FunctionalWidget.appBarHelper(
        context: context,
        title: "Detail produk",
      ),
      body: ListView(
        padding: scale.getPadding(1,2),
        children: [
          Hero(
              tag: widget.data["heroTag"] + widget.data["id"],
              child:Container(
                height: scale.getHeight(30),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(GeneralString.dummyImgProduct)
                  )
              ),

            )
          ),
          SizedBox(height: scale.getHeight(1)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Copywriting untuk Website",style: Theme.of(context).textTheme.headline1),
              InkResponse(
                onTap: (){},
                child: Icon(AntDesign.heart,color: Colors.red,),
              )
            ],
          ),
          SizedBox(height: scale.getHeight(0.5)),
          Row(
            children: [
              FunctionalWidget.rating(context: context),
              SizedBox(width: scale.getWidth(1)),
              Container(
                width: 2,
                height: 10,
                color: Colors.grey,
              ),
              SizedBox(width: scale.getWidth(1)),
              Text("Terjual",style: Theme.of(context).textTheme.subtitle1),
              SizedBox(width: scale.getWidth(0.5)),
              Text("100",style: Theme.of(context).textTheme.subtitle1.copyWith(color: ColorConfig.blackPrimaryColor,fontWeight: FontWeight.w400)),
            ],
          ),
          SizedBox(height: scale.getHeight(1)),
          FunctionalWidget.wrapContent(
            child: InTouchWidget(
                callback: (){},
                child: ListTile(
                  leading: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 20,
                      backgroundImage: NetworkImage(GeneralString.dummyImgUser)
                  ),
                  title: Text("Ari Yahya",style: Theme.of(context).textTheme.headline2,),
                  subtitle: Text("Digital Marketing di TulisTerus.id",style: Theme.of(context).textTheme.subtitle1,),
                  trailing:Container(
                    padding: scale.getPadding(0.5, 1.5),
                    decoration: BoxDecoration(
                        color: ColorConfig.yellowColor,
                        borderRadius:BorderRadius.circular(10)
                    ),
                    child:InkResponse(
                      onTap: (){},
                      child:  Icon(FlutterIcons.share_alt_faw,color: Colors.white,),
                    ),
                  ),
                )
            )
          ),

          SizedBox(height: scale.getHeight(1)),
          Text("Konten",style: Theme.of(context).textTheme.headline1),
          SizedBox(height: scale.getHeight(1)),
          Text(splitDesc+".",style: Theme.of(context).textTheme.subtitle1.copyWith(color:ColorConfig.blackSecondaryColor)),
          Text(desc.substring(splitDesc.length+2,desc.length),style: Theme.of(context).textTheme.subtitle1.copyWith(color: const Color(0xFF0E3311).withOpacity(0.1))),
        ],
      ),
      bottomNavigationBar: FunctionalWidget.bottomBar(
          context: context,
          title: "Saldo anda",
          desc: "Rp 300,000",
          btnText: "Beli sekarang",
          callback: (){
            general.setConditionCheckoutAndDetail(true);
            Navigator.of(context).pushNamed(RouteString.checkout);
          }
      ),
    );
  }
}
