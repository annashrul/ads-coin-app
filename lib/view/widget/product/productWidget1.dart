import 'package:adscoin/config/color_config.dart';
import 'package:adscoin/helper/ScreenScaleHelper.dart';
import 'package:adscoin/view/widget/general/touchWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

// ignore: must_be_immutable
class ProductWidget1 extends StatelessWidget {
  double marginWidth;
  String heroTag;
  bool isFavorite;
  String title;
  String price;
  String productSale;
  String image;
  bool isContributor;
  ProductWidget1({
    this.marginWidth,
    this.heroTag,
    this.isFavorite,
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
      width: scale.getWidth(40),
      padding: scale.getPadding(0,0),
      margin: scale.getMargin(0,marginWidth),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Theme.of(context).primaryColor.withOpacity(0.9),
      ),
      child: InTouchWidget(
        radius: 10,
        callback: (){},
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Stack(
              alignment: Alignment.topRight,
              children: [
                Hero(
                  tag: heroTag,
                  child: Container(
                    height: scale.getHeight(13),
                    width: scale.getWidth(40),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      image: DecorationImage(image: NetworkImage(image), fit: BoxFit.cover),
                    ),
                  ),
                ),
                Container(
                  margin: scale.getMargin(0,1),
                  padding: scale.getPadding(1,1),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: ColorConfig.graySecondaryColor
                  ),
                  child: Icon(AntDesign.hearto,color:isFavorite?ColorConfig.redColor:Colors.white,),
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
                          radius: 20,
                          backgroundImage: NetworkImage('https://freepikpsd.com/media/2019/10/user-png-image-9.png')
                      ),
                      SizedBox(width: scale.getWidth(1)),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Gendis Langit",style: Theme.of(context).textTheme.headline2),
                          Row(
                            children: [
                              Icon(AntDesign.staro,size: scale.getTextSize(9),color: ColorConfig.yellowColor,),
                              SizedBox(width: scale.getWidth(1)),
                              Text("5.0",style: Theme.of(context).textTheme.subtitle1)
                            ],
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            )

          ],
        ),
      ),
    );
  }
}
