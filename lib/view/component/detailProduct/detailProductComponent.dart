import 'package:adscoin/config/color_config.dart';
import 'package:adscoin/config/string_config.dart';
import 'package:adscoin/helper/functionalWidgetHelper.dart';
import 'package:adscoin/service/provider/GeneralProvider.dart';
import 'package:adscoin/service/provider/favoriteProvider.dart';
import 'package:adscoin/service/provider/productProvider.dart';
import 'package:adscoin/service/provider/userProvider.dart';
import 'package:adscoin/view/component/loadingComponent.dart';
import 'package:adscoin/view/widget/general/buttonWidget.dart';
import 'package:adscoin/view/widget/general/cardAction.dart';
import 'package:adscoin/view/widget/general/imageRoundedWidget.dart';
import 'package:adscoin/view/widget/general/touchWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_share_me/flutter_share_me.dart';


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
    final favorite = Provider.of<FavoriteProvider>(context, listen: false);
    product.getDetailProduct(context: context,id: widget.data["id"]);
    favorite.getDetail(widget.data["id"]);
  }

  @override
  Widget build(BuildContext context) {
    final general = Provider.of<GeneralProvider>(context);
    final product = Provider.of<ProductProvider>(context);
    final favorite = Provider.of<FavoriteProvider>(context);
    final member = Provider.of<UserProvider>(context);
    bool isLoading=product.isLoadingDetailProduct;
    ScreenScaler scale= ScreenScaler()..init(context);
    return Scaffold(
      appBar: FunctionalWidget.appBarWithFilterHelper(
        context: context,
        title: "Detail produk",
        action: [
         if(!isLoading&& member.idUser==product.detailProductModel.result.idSeller)FunctionalWidget.iconAppbar(
              context: context,
              callback: (){
                product.setDataEditProductContributor(product.detailProductModel.result.toJson());
                product.setIsAdd(false);
                product.setStatusProduct(product.detailProductModel.result.status);
                Navigator.of(context).pushNamed(RouteString.formProductContributor);
              },
              image: "Edit",
              color:general.conditionFilterProductContributor?ColorConfig.bluePrimaryColor:ColorConfig.grayPrimaryColor
          ),
        ]
      ),
      body: ListView(
        padding: scale.getPadding(1,2),
        children: [
          isLoading?BaseLoading(
            height: 30,
            width: 100,
          ):Hero(
              tag: widget.data["heroTag"] + widget.data["id"],
              child:ImageRoundedWidget(
                img: widget.data["image"],
                // height: scale.getHeight(30),
                width: double.infinity,
                fit: BoxFit.cover,
            )
          ),
          SizedBox(height: scale.getHeight(1)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              isLoading?BaseLoading(height: 1, width: 50):Container(
                width: scale.getWidth(50),
                child: Text(product.detailProductModel.result.title,style: Theme.of(context).textTheme.headline1),
              ),
              isLoading?BaseLoading(height: 1.5, width: 4,radius: 100,):InkResponse(
                onTap: (){
                  favorite.store(
                    context: context,
                    resData: product.detailProductModel.result.toJson()
                  );
                },
                child: Icon(AntDesign.heart,color: favorite.detail.length>0&&favorite.detail[0]["checked"]=="1"?Colors.red:Colors.black),
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
                callback: ()=>Navigator.of(context).pushNamed(RouteString.profilePerMember,arguments: product.detailProductModel.result.idSeller),
                child: ListTile(
                  leading: isLoading?BaseLoading(height: 4, width: 10,radius:100):CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 20,
                      backgroundImage: NetworkImage(product.detailProductModel.result.sellerFoto)
                  ),
                  title: isLoading?BaseLoading(height: 1, width: 10):Text(product.detailProductModel.result.seller,style: Theme.of(context).textTheme.headline2,),
                  subtitle: isLoading?BaseLoading(height: 1, width: 1):Text(product.detailProductModel.result.sellerBio==null?"-":product.detailProductModel.result.sellerBio,style: Theme.of(context).textTheme.subtitle1,maxLines: 1,overflow: TextOverflow.ellipsis,),
                  trailing:isLoading?BaseLoading(height: 4, width: 10,radius:10):Container(
                    padding: scale.getPadding(0.5, 1.5),
                    decoration: BoxDecoration(
                        color: ColorConfig.yellowColor,
                        borderRadius:BorderRadius.circular(10)
                    ),
                    child:InkResponse(
                      onTap: ()async{

                      },
                      child:  Icon(FlutterIcons.web_mco,color: Colors.white,),
                    ),
                  ),
                )
            )
          ),

          SizedBox(height: scale.getHeight(1)),
          if(isLoading)BaseLoading(height: 1, width: 100),
          if(isLoading)BaseLoading(height: 1, width: 100),
          if(!isLoading&&member.idUser==product.detailProductModel.result.idSeller)Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Preview",style: Theme.of(context).textTheme.headline1),
              Text(product.detailProductModel.result.preview,style: Theme.of(context).textTheme.headline2,),
              SizedBox(height: scale.getHeight(1)),
              Text("Konten",style: Theme.of(context).textTheme.headline1),
              Text(product.detailProductModel.result.content,style: Theme.of(context).textTheme.headline2,),
            ],
          )
          else if(!isLoading&&member.idUser!=product.detailProductModel.result.idSeller) Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(product.detailProductModel.result.statusBeli==1?"Konten":"Preview",style: Theme.of(context).textTheme.headline1),
              Text(product.detailProductModel.result.statusBeli==1?product.detailProductModel.result.content:product.detailProductModel.result.preview,style: Theme.of(context).textTheme.headline2,)
            ],
          )

          // Html(
          //   data: product.detailProductModel.result.statusBeli==1?product.detailProductModel.result.content:product.detailProductModel.result.preview,
          //   onLinkTap: (String url){
          //     print(url);
          //   },
          //   style: {
          //     "body": Style(
          //         fontSize: FontSize(16.0),
          //         fontWeight: FontWeight.w400,
          //         margin: EdgeInsets.zero,
          //     ),
          //   },
          // ),
        ],
      ),
      bottomNavigationBar: FunctionalWidget.bottomBar(
          context: context,
          title:"Harga",
          desc: isLoading?"loading ......":FunctionalWidget.toCoin(double.parse(product.detailProductModel.result.price)),
          btnText: isLoading?"loading ......":product.detailProductModel.result.statusBeli==1?"Ambil tulisan":"Beli sekarang",
          callback: ()async{
            if(!isLoading&&product.detailProductModel.result.statusBeli==1){
              await Share.share(removeAllHtmlTags(product.detailProductModel.result.content));
              // FunctionalWidget.modal(
              //   context: context,
              //   child: ModalShare(obj: {
              //     "link":"https://adscoin.id/",
              //     "msg": product.detailProductModel.result.content
              //   })
              // );
            }else{
              general.setConditionCheckoutAndDetail(true);
              Navigator.of(context).pushNamed(RouteString.checkout);
            }

          }
      ),
    );
  }
  String removeAllHtmlTags(String htmlText) {
    RegExp exp = RegExp(
        r"<[^>]*>",
        multiLine: true,
        caseSensitive: true
    );
    return htmlText.replaceAll(exp, '');
  }
}


class ModalShare extends StatelessWidget {
  final dynamic obj;
  ModalShare({this.obj});
  @override
  Widget build(BuildContext context) {
    final FlutterShareMe flutterShareMe = FlutterShareMe();
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CardAction(
          title: "Facebook",
          callback: ()async{
            final res = await flutterShareMe.shareToFacebook(url:obj["link"], msg:obj["msg"]);

          },
          img: "",
          imgNetwork: "https://1.bp.blogspot.com/-Gk7PJfZlTKM/YI0265VKDVI/AAAAAAAAE20/tSbccfFLIPAGclfx2il52vPUdwR8TJJsQCLcBGAsYHQ/s1600/Logo%2BFacebook%2BFormat%2BPNG.png",
        ),
        CardAction(
          title: "WhatsApp",
          callback: ()async{
            final res =  await flutterShareMe.shareToWhatsApp(msg: obj["msg"]);
            if(res=="false"){
              FunctionalWidget.nofitDialog(context: context,msg: "aplikasi tidak ditemukan",callback2: ()=>Navigator.of(context).pop());
            }
            print("RESPONSE SHARE ${res.runtimeType}");
          },
          img: "",
          imgNetwork: "https://www.freepnglogos.com/uploads/whatsapp-logo-light-green-png-0.png",
        ),

        CardAction(
          title: "Twitter",
          callback: ()async{
            final res= await flutterShareMe.shareToTwitter(url: obj["url"], msg: obj["msg"]);
            if(res=="false"){
              FunctionalWidget.nofitDialog(context: context,msg: "aplikasi tidak ditemukan",callback2: ()=>Navigator.of(context).pop());
            }
          },
          img: "",
          imgNetwork: "https://4.bp.blogspot.com/-WYBZhMb9BMw/V-s6c2P9uXI/AAAAAAAABN8/dRa9fkfvz6A-nf3i2QAZIm8X87O5ja9GQCEw/s1600/logo-twitter-t-bulat-348x348.png",
        ),

        CardAction(
          title: "Clipboard",
          callback: ()async{
            FunctionalWidget.copy(context: context,text: obj["msg"]);
            FunctionalWidget.nofitDialog(context: context,msg: "konten berhasil disalin",callback2: ()=>Navigator.of(context).pop());

          },
          img: "",
          imgNetwork: "https://www.freeiconspng.com/uploads/copy-icon-23.png",
        ),
      ],
    );
  }
}
