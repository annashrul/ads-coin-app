import 'package:adscoin/config/color_config.dart';
import 'package:adscoin/config/string_config.dart';
import 'package:adscoin/helper/functionalWidgetHelper.dart';
import 'package:adscoin/service/provider/GeneralProvider.dart';
import 'package:adscoin/service/provider/productProvider.dart';
import 'package:adscoin/view/component/loadingComponent.dart';
import 'package:adscoin/view/widget/general/buttonWidget.dart';
import 'package:adscoin/view/widget/general/imageRoundedWidget.dart';
import 'package:adscoin/view/widget/general/touchWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
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
  void initState() {
    // TODO: implement initState
    super.initState();
    final product = Provider.of<ProductProvider>(context, listen: false);
    product.getDetailProduct(context: context,id: widget.data["id"]);
  }

  @override
  Widget build(BuildContext context) {
    final general = Provider.of<GeneralProvider>(context);
    final product = Provider.of<ProductProvider>(context);
    print("product.detailProductModel ${product.detailProductModel}");
    bool isLoading=product.isLoadingDetailProduct;
    ScreenScaler scale= ScreenScaler()..init(context);
    String desc="Glory Perfume,parfum keluaran terbaru kami. Bahan 100% original dan penggunaannya tahan lama hingga 16 jam. For women only. Harga Rp 150.000 untuk 100ml. Desain botolnya juga unik dan cocok dibawa kemanapun.";
    String splitDesc = desc.split(". ")[0];
    return Scaffold(
      appBar: FunctionalWidget.appBarHelper(
        context: context,
        title: "Detail produk",
      ),
      body: ListView(
        padding: scale.getPadding(1,2),
        children: [
          isLoading?BaseLoading(
            height: 30,
            width: 100,
          ):Hero(
              tag: widget.data["heroTag"] + widget.data["id"],
              child:Container(
                height: scale.getHeight(30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(product.detailProductModel.result.image)
                  )
              ),

            )
          ),
          SizedBox(height: scale.getHeight(1)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              isLoading?BaseLoading(height: 1, width: 50):Text(product.detailProductModel.result.title,style: Theme.of(context).textTheme.headline1),
              isLoading?BaseLoading(height: 1.5, width: 4,radius: 100,):InkResponse(
                onTap: (){},
                child: Icon(AntDesign.heart,color: Colors.red,),
              )
            ],
          ),
          SizedBox(height: scale.getHeight(0.5)),
          Row(
            children: [
              isLoading?BaseLoading(height: 1, width: 10):FunctionalWidget.rating(context: context,rate: double.parse(product.detailProductModel.result.rating.toString())),
              SizedBox(width: scale.getWidth(1)),
              Container(
                width: 2,
                height: 10,
                color: Colors.grey,
              ),
              SizedBox(width: scale.getWidth(1)),
              isLoading?BaseLoading(height: 1, width: 10):Text("Terjual",style: Theme.of(context).textTheme.subtitle1),
              SizedBox(width: scale.getWidth(0.5)),
              isLoading?BaseLoading(height: 1, width: 10):Text(product.detailProductModel.result.terjual,style: Theme.of(context).textTheme.subtitle1.copyWith(color: ColorConfig.blackPrimaryColor,fontWeight: FontWeight.w400)),
            ],
          ),
          SizedBox(height: scale.getHeight(1)),
          FunctionalWidget.wrapContent(
            child: InTouchWidget(
                callback: (){},
                child: ListTile(
                  leading: isLoading?BaseLoading(height: 4, width: 10,radius:100):CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 20,
                      backgroundImage: NetworkImage(product.detailProductModel.result.sellerFoto)
                  ),
                  title: isLoading?BaseLoading(height: 1, width: 10):Text(product.detailProductModel.result.seller,style: Theme.of(context).textTheme.headline2,),
                  subtitle: isLoading?BaseLoading(height: 1, width: 1):Text(product.detailProductModel.result.sellerBio,style: Theme.of(context).textTheme.subtitle1,maxLines: 1,overflow: TextOverflow.ellipsis,),
                  trailing:isLoading?BaseLoading(height: 4, width: 10,radius:10):Container(
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
          isLoading?BaseLoading(height: 1, width: 100):Text(product.detailProductModel.result.statusBeli==1?"Konten":"Preview",style: Theme.of(context).textTheme.headline1),
          SizedBox(height: scale.getHeight(1)),
          isLoading?BaseLoading(height: 1, width: 100):Html(
            data: product.detailProductModel.result.statusBeli==1?product.detailProductModel.result.content:product.detailProductModel.result.preview,
            onLinkTap: (String url){
              print(url);
            },
            style: {
              "body": Style(
                  fontSize: FontSize(16.0),
                  fontWeight: FontWeight.w400,
                  margin: EdgeInsets.zero,
              ),
            },
          ),
        ],
      ),
      bottomNavigationBar: FunctionalWidget.bottomBar(
          context: context,
          title:"Saldo anda",
          desc: isLoading?"loading ......":"Rp 300,000",
          btnText: "Beli sekarang",
          callback: (){

            general.setConditionCheckoutAndDetail(true);
            Navigator.of(context).pushNamed(RouteString.checkout);
          }
      ),
    );
  }
}
