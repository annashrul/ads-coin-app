import 'package:adscoin/config/color_config.dart';
import 'package:adscoin/config/string_config.dart';
import 'package:adscoin/helper/functionalWidgetHelper.dart';
import 'package:adscoin/service/provider/favoriteProvider.dart';
import 'package:adscoin/service/provider/listProductProvider.dart';
import 'package:adscoin/service/provider/productProvider.dart';
import 'package:adscoin/service/provider/userProvider.dart';
import 'package:adscoin/view/component/loadingComponent.dart';
import 'package:adscoin/view/widget/general/noDataWidget.dart';
import 'package:adscoin/view/widget/product/productWidget1.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

class LibraryProductComponent extends StatefulWidget {
  @override
  _LibraryProductComponentState createState() => _LibraryProductComponentState();
}

class _LibraryProductComponentState extends State<LibraryProductComponent> {
  TextEditingController anyController = new TextEditingController();
  ScrollController controller;
  void scrollListener() {
    final product = Provider.of<ProductProvider>(context, listen: false);
    if (!product.isLoadingLibrary) {
      if (controller.position.pixels == controller.position.maxScrollExtent) {
        product.loadMoreProductLibrary(context);
      }
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final product = Provider.of<ProductProvider>(context, listen: false);
    product.getLibrary(context: context);
    final favorite = Provider.of<FavoriteProvider>(context, listen: false);
    favorite.get();
    controller = new ScrollController()..addListener(scrollListener);
    this.setState(() {
      anyController.text = product.anyProductLibrary;
    });
  }
  @override
  void dispose() {
    super.dispose();
    controller.removeListener(scrollListener);
  }
  @override
  Widget build(BuildContext context) {
    ScreenScaler scale= ScreenScaler()..init(context);
    final product = Provider.of<ProductProvider>(context);
    final member = Provider.of<UserProvider>(context,listen: false);

    return Scaffold(
        appBar: AppBar(
          titleSpacing: 0.0,
          automaticallyImplyLeading: false,
          elevation: 0,
          title: Container(
            margin: scale.getMarginLTRB(2.5, 0, 2.5, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: scale.getPadding(0, 2),
                  width:scale.getWidth(72),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xFFF2F2F2)
                  ),
                  child: TextField(
                    controller: anyController,
                    decoration: InputDecoration(
                      contentPadding: scale.getPadding(1,0),
                      hintStyle: Theme.of(context).textTheme.subtitle1,
                      hintText:"Ads copy, landingpage, caption",
                      border: InputBorder.none,
                      suffixIcon: Icon(FlutterIcons.search_fea,color: Theme.of(context).textTheme.subtitle1.color,),
                      suffixIconConstraints: BoxConstraints(
                          minHeight: scale.getHeight(1),
                          minWidth: scale.getWidth(1)
                      ),
                    ),
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.search,
                    onSubmitted: (e){
                      product.setAnyProductLibrary(context, e.toString());
                    },
                  ),
                ),
                InkResponse(
                  onTap: ()async{
                    if(member.detailMemberModel.result.idType==1){
                      await Share.share("https://reg.adscoin.id/${member.referral}");

                    }else{
                      FunctionalWidget.toast(context: context,msg: "anda belum menjadi kontributor");
                    }
                  },
                  child: Container(
                    padding: scale.getPadding(0.7,2),
                    decoration: BoxDecoration(
                      border: Border.all(color:Color(0xFF219653),width: 2),
                      color: Color(0xFFF2F2F2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child:Icon(FlutterIcons.share_alt_faw,color: Color(0xFF219653),),
                  ),
                  // child: Icon(
                  //     FlutterIcons.share_alt_faw,
                  //     size: scale.getTextSize(15),
                  //     color:ColorConfig.graySecondaryColor
                  // ),
                )
              ],
            ),
          ),
        ),
        body: buildContent(context),
      bottomNavigationBar: product.isLoadMoreProductLibrary?Container(
        padding: scale.getPadding(1,0),
        child: CupertinoActivityIndicator(),
      ):SizedBox(),
    );
  }
  Widget buildContent(BuildContext context){
    ScreenScaler scale= ScreenScaler()..init(context);
    final product = Provider.of<ProductProvider>(context);
    final favorite = Provider.of<FavoriteProvider>(context);
    return RefreshIndicator(
        child: product.isLoadingLibrary?LoadingProduct():product.productLibraryModel==null?NoDataWidget():new StaggeredGridView.countBuilder(
          padding:scale.getPadding(1,2.5),
          primary: false,
          shrinkWrap: true,
          crossAxisCount: 4,
          itemCount:product.isLoadingLibrary?10:product.productLibraryModel.result.length,
          staggeredTileBuilder: (int index) => new StaggeredTile.fit(2),
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0,
          controller: controller,
          itemBuilder: (context,index){
            if(favorite.data.length>0){
              for(int i=0;i<favorite.data.length;i++){
                if(favorite.data[i][TableString.idProduct] == product.productLibraryModel.result[index].id){
                  product.productLibraryModel.result[index].isFavorite = "1";
                  break;
                }
                continue;
              }
            }
            return ProductWidget1(
              marginWidth: index==0?0:0,
              heroTag: "mainProduk"+product.productLibraryModel.result[index].id,
              isFavorite:product.productLibraryModel.result[index].isFavorite=="0"?false:true,
              id: product.productLibraryModel.result[index].id,
              title:  product.productLibraryModel.result[index].title,
              price:  product.productLibraryModel.result[index].price,
              productSale:"${ product.productLibraryModel.result[index].terjual} terjual" ,
              image:  product.productLibraryModel.result[index].image,
              isContributor: true,
              nameContributor: product.productLibraryModel.result[index].seller,
              imageContributor: product.productLibraryModel.result[index].sellerFoto,
              rateContributor: double.parse(product.productLibraryModel.result[index].rating.toString()),
            );
          },
        ),
        onRefresh: ()=>product.getLibrary(context: context)
    );
  }
}
