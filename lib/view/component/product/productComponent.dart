import 'package:adscoin/config/color_config.dart';
import 'package:adscoin/config/string_config.dart';
import 'package:adscoin/helper/functionalWidgetHelper.dart';
import 'package:adscoin/service/provider/categoryProvider.dart';
import 'package:adscoin/service/provider/favoriteProvider.dart';
import 'package:adscoin/service/provider/listProductProvider.dart';
import 'package:adscoin/service/provider/userProvider.dart';
import 'package:adscoin/view/component/loadingComponent.dart';
import 'package:adscoin/view/widget/general/imageRoundedWidget.dart';
import 'package:adscoin/view/widget/general/noDataWidget.dart';
import 'package:adscoin/view/widget/product/productWidget1.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';


class ProductComponent extends StatefulWidget {
  @override
  _ProductComponentState createState() => _ProductComponentState();
}

class _ProductComponentState extends State<ProductComponent> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController anyController = new TextEditingController();
  ScrollController controller;
  void scrollListener() {
    final product = Provider.of<ListProductProvider>(context, listen: false);
    if (!product.isLoading) {
      if (controller.position.pixels == controller.position.maxScrollExtent) {
        product.loadMoreContributor(context);
      }
    }
  }
  Future onLoadService()async{
    // _refreshIndicatorKey.currentState.show();
    final product = Provider.of<ListProductProvider>(context, listen: false);
    final category = Provider.of<CategoryProvider>(context, listen: false);
    category.getCategoryProduct(context: context,isFilter: true);
    product.get(context: context);
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final product = Provider.of<ListProductProvider>(context, listen: false);
    final category = Provider.of<CategoryProvider>(context, listen: false);
    category.getCategoryProduct(context: context,isFilter: true);
    product.get(context: context);
    controller = new ScrollController()..addListener(scrollListener);
    final favorite = Provider.of<FavoriteProvider>(context, listen: false);
    favorite.get();
    if(product.q!=""){
      anyController.text=product.q;
      setState(() {});
    }
  }
  @override
  void dispose() {
    super.dispose();
    controller.removeListener(scrollListener);
  }
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<ListProductProvider>(context);
    final category = Provider.of<CategoryProvider>(context);
    final member = Provider.of<UserProvider>(context,listen: false);
    int max = category.isLoading?10:category.categoryProductModel.result.length;
    ScreenScaler scale= ScreenScaler()..init(context);
    List<Widget> historyTab = [];
    List<Widget> historyView = [];
    for(int i=0;i<max;i++){
      historyView.add(product.isLoading?LoadingProduct():product.listProductModel==null?NoDataWidget(): buildContent(context));
      historyTab.add(
        Tab(
          child: Container(
            padding: scale.getPadding(0,1),
            child: Align(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  category.isLoading?BaseLoading(height: 1, width: 10):ImageRoundedWidget(img:category.categoryProductModel.result[i].icon,height: scale.getHeight(1),),
                  if(!category.isLoading)SizedBox(width: scale.getWidth(1)),
                  if(!category.isLoading)Text(category.categoryProductModel.result[i].title)
                ],
              ),
            ),
          ),
        ),
      );
    }
    return DefaultTabController(
        initialIndex:  0,
        length: historyTab.length,
        child: Scaffold(
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
                        product.setQ(context: context,input: e.toString());
                      },
                    ),
                  ),
                  InkResponse(
                    onTap: ()async{
                      if(member.detailMemberModel.result.idType==1){
                        await Share.share(member.referral);
                      }else{
                        FunctionalWidget.toast(context: context,msg: "anda belum menjadi kontributor");
                      }
                    },
                    child: Icon(
                        FlutterIcons.share_alt_faw,
                        size: scale.getTextSize(15),
                        color:ColorConfig.graySecondaryColor
                    ),
                  )
                ],
              ),
            ),
            bottom: TabBar(
              indicatorPadding: scale.getPadding(0,0),
              labelPadding: scale.getPadding(0,1),
              unselectedLabelColor: Theme.of(context).accentColor,
              labelColor:Colors.black,
              labelStyle: Theme.of(context).textTheme.subtitle1,
              isScrollable: true,
              tabs:historyTab,
              onTap: (e){
                product.filterCategory(context, category.categoryProductModel.result[e].id);
              },
            ),
          ),
          body:  product.isLoading?LoadingProduct(): Container(
            padding: scale.getPadding(1,2.5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    child:TabBarView(children:historyView),
                ),
                product.isLoadMore?Container(
                    alignment: Alignment.center,
                    padding: scale.getPaddingLTRB(0,1,0,0),
                    child:Center(
                      child: CupertinoActivityIndicator(),
                    )
                ):SizedBox(),
              ],
            ),
          ),
        )
    );
  }

  Widget buildContent(BuildContext context){
    final product = Provider.of<ListProductProvider>(context);
    final favorite = Provider.of<FavoriteProvider>(context);
    return RefreshIndicator(
        child: new StaggeredGridView.countBuilder(
          padding: EdgeInsets.all(0.0),
          physics: AlwaysScrollableScrollPhysics(),
          crossAxisCount: 4,
          itemCount:product.listProductModel.result.length,
          staggeredTileBuilder: (int index) => new StaggeredTile.fit(2),
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0,
          controller: controller,
          itemBuilder: (context,index){
            if(favorite.data.length>0){
              for(int i=0;i<favorite.data.length;i++){
                if(favorite.data[i][TableString.idProduct] == product.listProductModel.result[index].id){
                  product.listProductModel.result[index].isFavorite = "1";
                  break;
                }
                continue;
              }
            }
            return ProductWidget1(
              marginWidth: index==0?0:0,
              heroTag: "mainProduk"+product.listProductModel.result[index].id,
              isFavorite:product.listProductModel.result[index].isFavorite=="0"?false:true,
              id: product.listProductModel.result[index].id,
              title:  product.listProductModel.result[index].title,
              price:  product.listProductModel.result[index].price,
              productSale:"${ product.listProductModel.result[index].terjual} terjual" ,
              image:  product.listProductModel.result[index].image,
              isContributor: true,
              nameContributor: product.listProductModel.result[index].seller,
              imageContributor: product.listProductModel.result[index].sellerFoto,
              rateContributor: double.parse(product.listProductModel.result[index].rating.toString()),
            );
          },
        ),
        onRefresh: ()=>onLoadService(),
    );
  }

}
