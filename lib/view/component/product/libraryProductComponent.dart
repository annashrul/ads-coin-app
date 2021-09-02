import 'package:adscoin/config/color_config.dart';
import 'package:adscoin/service/provider/productProvider.dart';
import 'package:adscoin/view/component/loadingComponent.dart';
import 'package:adscoin/view/widget/product/productWidget1.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class LibraryProductComponent extends StatefulWidget {
  @override
  _LibraryProductComponentState createState() => _LibraryProductComponentState();
}

class _LibraryProductComponentState extends State<LibraryProductComponent> {
  TextEditingController anyController = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final product = Provider.of<ProductProvider>(context, listen: false);
    product.getLibrary(context: context);
  }

  @override
  Widget build(BuildContext context) {
    ScreenScaler scale= ScreenScaler()..init(context);

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
                  ),
                ),
                InkResponse(
                  onTap: (){},
                  child: Icon(
                      FlutterIcons.share_alt_faw,
                      size: scale.getTextSize(15),
                      color:ColorConfig.graySecondaryColor
                  ),
                )
              ],
            ),
          ),

        ),
        body: buildContent(context)
    );
  }
  Widget buildContent(BuildContext context){
    ScreenScaler scale= ScreenScaler()..init(context);
    final product = Provider.of<ProductProvider>(context);
    return new StaggeredGridView.countBuilder(
      padding:scale.getPadding(1,2.5),
      primary: false,
      shrinkWrap: true,
      crossAxisCount: 4,
      itemCount:product.isLoadingLibrary?10:product.productLibraryModel.result.length,
      staggeredTileBuilder: (int index) => new StaggeredTile.fit(2),
      mainAxisSpacing: 10.0,
      crossAxisSpacing: 10.0,
      itemBuilder: (context,index){
        return product.isLoadingLibrary?LoadingProduct():ProductWidget1(
          marginWidth: index==0?0:0,
          heroTag: "mainProduk"+index.toString(),
          isFavorite: index==0?true:false,
          id:"mainProduk"+index.toString(),
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
    );
  }
}
