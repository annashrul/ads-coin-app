import 'package:adscoin/config/color_config.dart';
import 'package:adscoin/config/string_config.dart';
import 'package:adscoin/helper/functionalWidgetHelper.dart';
import 'package:adscoin/service/provider/favoriteProvider.dart';
import 'package:adscoin/service/provider/listProductProvider.dart';
import 'package:adscoin/service/provider/userProvider.dart';
import 'package:adscoin/view/component/loadingComponent.dart';
import 'package:adscoin/view/widget/general/noDataWidget.dart';
import 'package:adscoin/view/widget/general/touchWidget.dart';
import 'package:adscoin/view/widget/home/modalSearchWidget.dart';
import 'package:adscoin/view/widget/product/productWidget1.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class SearchComponent extends StatefulWidget {
  final String any;
  SearchComponent({this.any});
  @override
  _SearchComponentState createState() => _SearchComponentState();
}

class _SearchComponentState extends State<SearchComponent> {
  TextEditingController anyController = new TextEditingController();
  FocusNode anyFocus = new FocusNode();
  String searchBy="produk";
  ScrollController productController;
  ScrollController memberController;
  void scrollListenerProduct() {
    final product = Provider.of<ListProductProvider>(context, listen: false);
    if (!product.isLoadingProductSearch) {
      if (productController.position.pixels == productController.position.maxScrollExtent) {
        product.loadMoreSearchProduct(context);
      }
    }
  }
  void scrollListenerMember() {
    final user = Provider.of<UserProvider>(context, listen: false);
    if (!user.isLoadingSearchMember) {
      if (memberController.position.pixels == memberController.position.maxScrollExtent) {
        user.loadMoreSearchMember(context);
      }
    }
  }

  void handleSearch(e){
    final product = Provider.of<ListProductProvider>(context,listen: false);
    final user = Provider.of<UserProvider>(context,listen: false);
    if(searchBy=="produk"){
      product.setAnySearchProduct(context: context,input: e.toString());
    }else{
      user.setAnySearchMember(context, e);
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    anyController.text=widget.any;
    anyFocus.requestFocus();
    final product = Provider.of<ListProductProvider>(context,listen: false);
    product.getSearchProduct(context: context);
    final favorite = Provider.of<FavoriteProvider>(context, listen: false);
    favorite.get();
    final user = Provider.of<UserProvider>(context, listen: false);
    user.getSearchMember(context: context);
    productController = new ScrollController()..addListener(scrollListenerProduct);
    memberController = new ScrollController()..addListener(scrollListenerMember);
  }
  @override
  void dispose() {
    super.dispose();
    productController.removeListener(scrollListenerProduct);
    memberController.removeListener(scrollListenerMember);
  }
  @override
  Widget build(BuildContext context) {
    ScreenScaler scale= ScreenScaler()..init(context);
    final product = Provider.of<ListProductProvider>(context);
    final user = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar:AppBar(

        elevation: 0,
        automaticallyImplyLeading: false,
        title:  Container(
          margin: scale.getMarginLTRB(0, 1, 0, 1),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child:  TextField(
                  autofocus: true,
                  focusNode: anyFocus,
                  controller: anyController,
                  decoration: InputDecoration(
                    hintText: "Pencarian $searchBy",
                    hintStyle: Theme.of(context).textTheme.subtitle2,
                    contentPadding: scale.getPadding(0,0),
                    // border: InputBorder.none,

                  ),
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.search,
                  onSubmitted: (e){
                    handleSearch(e);
                  },
                ),
              ),
              SizedBox(width: scale.getWidth(1)),
              Row(
                children: [
                  Container(
                    margin: scale.getMarginLTRB(0, 0, 1, 0),
                    decoration: BoxDecoration(
                      color:searchBy=="produk"?ColorConfig.bluePrimaryColor:ColorConfig.graySecondaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: InTouchWidget(
                      callback: (){
                        setState(() {
                          searchBy="produk";
                        });
                        handleSearch(anyController.text);
                      },
                      child: Padding(
                        padding: scale.getPadding(0.5, 1),
                        child: Text("Produk",style: Theme.of(context).textTheme.subtitle1.copyWith(color:searchBy=="produk"?ColorConfig.graySecondaryColor:ColorConfig.grayPrimaryColor,),textAlign: TextAlign.center,),
                      ),
                    ),
                  ),
                  Container(
                    margin: scale.getMarginLTRB(0, 0, 1, 0),
                    decoration: BoxDecoration(
                      color:searchBy=="kontributor"?ColorConfig.bluePrimaryColor:ColorConfig.graySecondaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: InTouchWidget(
                      callback: (){
                        setState(() {
                          searchBy="kontributor";
                        });
                        handleSearch(anyController.text);
                      },
                      child: Padding(
                        padding: scale.getPadding(0.5, 1),
                        child: Text("Kontributor",style: Theme.of(context).textTheme.subtitle1.copyWith(color:searchBy=="kontributor"?ColorConfig.graySecondaryColor:ColorConfig.grayPrimaryColor,),textAlign: TextAlign.center,),
                      )
                    ),
                  ),

                ],
              ),
            ],
          ),
        ),
      ),
      body: Scrollbar(
        child: Padding(
          padding: scale.getPadding(1,0),
          child: Column(
            children: [
              Expanded(
                  child:searchBy=="produk"?productSearch(context):memberSearch(context)
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: product.isLoadMoreProductSearch||user.isLoadMoreSearchMember?CupertinoActivityIndicator():SizedBox(),
    );
  }


  Widget productSearch(BuildContext context){
    ScreenScaler scale= ScreenScaler()..init(context);
    final product = Provider.of<ListProductProvider>(context);
    final favorite = Provider.of<FavoriteProvider>(context);
    return product.isLoadingProductSearch?LoadingProduct():product.productSearchModel==null?NoDataWidget():SingleChildScrollView(
      controller: productController,
      child: Container(
        padding: scale.getPadding(0.5,2.5),
        child: new StaggeredGridView.countBuilder(
          padding: EdgeInsets.all(0.0),
          primary: false,
          shrinkWrap: true,
          crossAxisCount: 4,
          itemCount:product.productSearchModel.result.length,
          staggeredTileBuilder: (int index) => new StaggeredTile.fit(2),
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0,
          itemBuilder: (context,index){
            if(favorite.data.length>0){
              for(int i=0;i<favorite.data.length;i++){
                if(favorite.data[i][TableString.idProduct] == product.productSearchModel.result[index].id){
                  product.productSearchModel.result[index].isFavorite = "1";
                  break;
                }
                continue;
              }
            }
            return ProductWidget1(
              marginWidth: index==0?0:0,
              heroTag: "produkTerbaru"+product.productSearchModel.result[index].id,
              isFavorite:product.productSearchModel.result[index].isFavorite=="0"?false:true,
              id:product.productSearchModel.result[index].id,
              title: product.productSearchModel.result[index].title,
              price: product.productSearchModel.result[index].price,
              productSale:"${product.productSearchModel.result[index].terjual} terjual" ,
              image: product.productSearchModel.result[index].image,
              isContributor: true,
              nameContributor: product.productSearchModel.result[index].seller,
              imageContributor: product.productSearchModel.result[index].sellerFoto,
              rateContributor: double.parse(product.productSearchModel.result[index].rating.toString()),
            );
          },
        ),
      ),
    );
  }
  
  
  Widget memberSearch(BuildContext context){
    final user = Provider.of<UserProvider>(context);
    ScreenScaler scale= ScreenScaler()..init(context);
    return user.isLoadingSearchMember?Container(
      padding: scale.getPadding(0,2.5),
      child: ListView.separated(
          padding: EdgeInsets.zero,
          primary: false,
          shrinkWrap: true,
          itemCount: 10,
          itemBuilder: (context,index){
            return BaseLoading(height:5, width: 70);
          },
          separatorBuilder: (context,index){return SizedBox(height: scale.getHeight(0.5),);},

    ),
    ):user.memberSearchModel==null?NoDataWidget():ListView.separated(
        controller: memberController,
        padding: scale.getPadding(0,2.5),
        primary: false,
        shrinkWrap: true,
        itemBuilder: (context,index){
          final val = user.memberSearchModel.result[index];
          return FunctionalWidget.wrapContent(
              child: ListTile(
                onTap: ()=>Navigator.of(context).pushNamed(RouteString.profilePerMember,arguments: val.id),
                leading: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 20,
                    backgroundImage: NetworkImage(val.foto)
                ),
                title: Text(val.fullname,style: Theme.of(context).textTheme.headline2),
                subtitle: Text(val.bio!=null?val.bio:"-",style: Theme.of(context).textTheme.subtitle1,maxLines: 1,overflow: TextOverflow.ellipsis),
                trailing: Container(
                  width: scale.getWidth(10),
                  child: FunctionalWidget.rating(context: context,rate:double.parse(val.rating.toString())),
                ),
              )
          );
        },
        separatorBuilder: (context,index){return SizedBox(height: scale.getHeight(0.5),);},
        itemCount: user.memberSearchModel.result.length
    );
  }
  
}
