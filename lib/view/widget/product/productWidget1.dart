import 'package:adscoin/config/color_config.dart';
import 'package:adscoin/config/string_config.dart';
import 'package:adscoin/helper/ScreenScaleHelper.dart';
import 'package:adscoin/helper/functionalWidgetHelper.dart';
import 'package:adscoin/view/widget/general/imageRoundedWidget.dart';
import 'package:adscoin/view/widget/general/touchWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

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
  });

  @override
  Widget build(BuildContext context) {
    ScreenScaleHelper scale = ScreenScaleHelper()..init(context);
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
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                      Text(price,overflow:TextOverflow.ellipsis,maxLines: 1,style: Theme.of(context).textTheme.headline1),
                      Text(productSale,overflow:TextOverflow.ellipsis,maxLines: 1,style: Theme.of(context).textTheme.subtitle1),
                    ],
                  ),
                  if(isContributor) SizedBox(height: scale.getHeight(1)),
                  if(isContributor) Row(
                    children: [
                      CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: 15,
                          backgroundImage: NetworkImage(GeneralString.dummyImgUser)
                      ),
                      SizedBox(width: scale.getWidth(1)),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Gendis Langit",style: Theme.of(context).textTheme.headline2),
                          FunctionalWidget.rating(context: context)
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
