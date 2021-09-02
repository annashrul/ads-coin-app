import 'package:adscoin/config/color_config.dart';
import 'package:adscoin/config/string_config.dart';
import 'package:adscoin/helper/functionalWidgetHelper.dart';
import 'package:adscoin/view/widget/general/imageRoundedWidget.dart';
import 'package:adscoin/view/widget/general/touchWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';

// ignore: must_be_immutable
class ProductWidget1 extends StatelessWidget {
  double marginWidth;
  String heroTag;
  bool isFavorite;
  String id;
  String title;
  String price;
  String productSale;
  String image;
  bool isContributor;
  String nameContributor;
  String imageContributor;
  double rateContributor;
  ProductWidget1({
    this.marginWidth,
    this.heroTag,
    this.isFavorite,
    this.id,
    this.title,
    this.price,
    this.productSale,
    this.image,
    this.isContributor,
    this.nameContributor="",
    this.imageContributor=GeneralString.dummyImgUser,
    this.rateContributor=0.0,
  });

  @override
  Widget build(BuildContext context) {
    ScreenScaler scale= ScreenScaler()..init(context);
    return Container(
      width: scale.getWidth(35),
      padding: scale.getPadding(0,0),
      margin: scale.getMargin(0,marginWidth),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Theme.of(context).primaryColor.withOpacity(0.9),
      ),
      child: InTouchWidget(
        radius: 10,
        callback: (){
          Navigator.of(context).pushNamed(RouteString.detailProduct,arguments: {
            "image":image,
            "heroTag":heroTag,
            "id":id
          });
        },
        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Stack(
              alignment: Alignment.topRight,
              children: [
                Hero(
                  tag: this.heroTag + id,
                  child: ImageRoundedWidget(
                    img: image,
                    width:scale.getWidth(42),
                    height: scale.getHeight(13),
                    fit: BoxFit.cover
                  ),
                ),
                Container(
                  margin: scale.getMargin(0,1),
                  padding: scale.getPadding(1,1),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: ColorConfig.graySecondaryColor
                  ),
                  child: Icon(AntDesign.heart,color:isFavorite?ColorConfig.redColor:Colors.white,),
                )
              ],
            ),
            Padding(
              padding: scale.getPaddingLTRB(1,1,1,0),
              child: Column(

                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,overflow:TextOverflow.ellipsis,maxLines: 1,style: Theme.of(context).textTheme.headline2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(price+" coin",overflow:TextOverflow.ellipsis,maxLines: 1,style: Theme.of(context).textTheme.headline1),
                      Text(productSale,overflow:TextOverflow.ellipsis,maxLines: 1,style: Theme.of(context).textTheme.subtitle1),
                    ],
                  ),
                  if(isContributor) SizedBox(height: scale.getHeight(1)),
                  if(isContributor) Row(
                    children: [
                      CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: 15,
                          backgroundImage: NetworkImage(this.imageContributor)
                      ),
                      SizedBox(width: scale.getWidth(1)),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(this.nameContributor,style: Theme.of(context).textTheme.headline2),
                          FunctionalWidget.rating(context: context,rate: this.rateContributor)
                        ],
                      ),
                    ],
                  ),
                  if(isContributor) SizedBox(height: scale.getHeight(1)),
                ],
              ),
            )

          ],
        ),
      ),
    );
  }
}
