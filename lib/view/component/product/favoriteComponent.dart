import 'package:adscoin/config/string_config.dart';
import 'package:adscoin/helper/functionalWidgetHelper.dart';
import 'package:adscoin/service/provider/favoriteProvider.dart';
import 'package:adscoin/view/widget/general/noDataWidget.dart';
import 'package:adscoin/view/widget/product/productWidget1.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class FavoriteComponent extends StatefulWidget {
  @override
  _FavoriteComponentState createState() => _FavoriteComponentState();
}

class _FavoriteComponentState extends State<FavoriteComponent> {
  @override
  Widget build(BuildContext context) {
    final favorite = Provider.of<FavoriteProvider>(context);
    ScreenScaler scale= ScreenScaler()..init(context);
    return Scaffold(
      appBar: FunctionalWidget.appBarHelper(context: context,title: "Favorite anda"),
      body: Container(
        padding: scale.getPadding(0.5,2.5),
        child: favorite.data.length<1?NoDataWidget(): new StaggeredGridView.countBuilder(
          padding: EdgeInsets.all(0.0),
          primary: false,
          shrinkWrap: true,
          crossAxisCount: 4,
          itemCount:favorite.data.length,
          staggeredTileBuilder: (int index) => new StaggeredTile.fit(2),
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0,
          itemBuilder: (context,index){
            final val=favorite.data[index];
            return ProductWidget1(
              marginWidth: index==0?0:0,
              heroTag: "produkFavorite"+val[TableString.idProduct],
              isFavorite:val["checled"]=="0"?false:true,
              id:val[TableString.idProduct],
              title:val[TableString.titleProduct],
              price:val[TableString.priceProduct],
              productSale:"${val[TableString.terjualProduct]} terjual" ,
              image:val[TableString.imageProduct],
              isContributor: true,
              nameContributor: val[TableString.sellerProduct],
              imageContributor:val[TableString.sellerFotoProduct],
              rateContributor: double.parse(val[TableString.ratingProduct]),
            );
          },
        ),
      ),
    );
  }
}
