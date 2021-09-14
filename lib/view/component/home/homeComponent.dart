import 'package:adscoin/config/color_config.dart';
import 'package:adscoin/config/string_config.dart';
import 'package:adscoin/helper/functionalWidgetHelper.dart';
import 'package:adscoin/service/provider/favoriteProvider.dart';
import 'package:adscoin/service/provider/productProvider.dart';
import 'package:adscoin/service/provider/promoProvider.dart';
import 'package:adscoin/service/provider/userProvider.dart';
import 'package:adscoin/view/component/loadingComponent.dart';
import 'package:adscoin/view/widget/general/appBarWithActionWidget.dart';
import 'package:adscoin/view/widget/general/titleSectionWidget.dart';
import 'package:adscoin/view/widget/general/touchWidget.dart';
import 'package:adscoin/view/widget/home/cardSaldoWidget.dart';
import 'package:adscoin/view/widget/product/productWidget1.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class HomeComponent extends StatefulWidget {
  @override
  _HomeComponentState createState() => _HomeComponentState();
}

class _HomeComponentState extends State<HomeComponent> {
  TextEditingController anyController = new TextEditingController();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = new GlobalKey<RefreshIndicatorState>();
  Future onLoadService() async {
    _refreshIndicatorKey.currentState.show();
    final product = Provider.of<ProductProvider>(context, listen: false);
    final user = Provider.of<UserProvider>(context, listen: false);
    final favorite = Provider.of<FavoriteProvider>(context, listen: false);
    final promo = Provider.of<PromoProvider>(context, listen: false);
    favorite.get();
    user.getDetailMember(context: context);
    product.getNew(context: context);
    product.getBestSeller(context: context);
    user.getLeaderBoard(context: context);
    promo.checkPromo(context: context);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final product = Provider.of<ProductProvider>(context, listen: false);
    final user = Provider.of<UserProvider>(context, listen: false);
    final favorite = Provider.of<FavoriteProvider>(context, listen: false);
    final promo = Provider.of<PromoProvider>(context, listen: false);
    favorite.get();
    product.getNew(context: context);
    product.getBestSeller(context: context);
    user.getLeaderBoard(context: context);
    promo.checkPromo(context: context);
  }

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<ProductProvider>(context);
    final favorite = Provider.of<FavoriteProvider>(context);
    final user = Provider.of<UserProvider>(context);
    final promo = Provider.of<PromoProvider>(context);

    ScreenScaler scale= ScreenScaler()..init(context);
    return Scaffold(
      body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxScrolled) {
            return <Widget>[
              AppBarWithActionWidget(
                color: ColorConfig.yellowColor,
                callback: (res){
                  // product.setQ(context: context,input: e.toString());
                },
              )
            ];
          },
          body: RefreshIndicator(
            key: _refreshIndicatorKey,
            child: ListView(
              padding: EdgeInsets.all(0),
              children: [
                Stack(
                  children: [
                    DecoratedBox(
                        decoration: BoxDecoration(
                          color: ColorConfig.yellowColor,
                        ),
                        child: Container(
                          width: double.infinity,
                          height: scale.getHeight(3),
                        )
                    ),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children:<Widget>[
                          Container(height: scale.getHeight(0)),
                          Container(
                            padding: scale.getPadding(0,2.5),
                            child: CardSaldoWidget(),
                          ),
                        ]
                    )
                  ],
                ),
                Padding(
                  padding: scale.getPadding(1,2.5),
                  child: InTouchWidget(
                    callback: (){
                      if(promo.promoModel!=null){
                        Navigator.of(context).pushNamed(RouteString.detailPromo);
                      }
                    },
                    radius: 10,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          fit:BoxFit.cover,
                            colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.2), BlendMode.dstATop),
                            image: NetworkImage(
                            !promo.isLoadingPromo||promo.promoModel==null?GeneralString.dummyImgProduct:promo.promoModel.result.image,
                          )
                        )
                      ),
                      padding: scale.getPadding(2, 2),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              child: promo.isLoadingPromo?Column(
                                children: [
                                  BaseLoading(height: 1, width: 30),
                                  SizedBox(height: scale.getHeight(0.5)),
                                  BaseLoading(height: 1, width: 50),
                                  SizedBox(height: scale.getHeight(0.5)),
                                  BaseLoading(height: 1, width: 60),
                                ],
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                              ):Text(promo.promoModel==null?"Situs kami memberi jaminan jam kerja tepat waktu dan penulisan memuaskan":promo.promoModel.result.deskripsi,style: Theme.of(context).textTheme.headline2.copyWith(fontWeight: FontWeight.w400),maxLines: 3,overflow: TextOverflow.ellipsis,)
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: scale.getPadding(0,2.5),
                  child: TitleSectionWidget(
                    title: "Produk terlaris",
                    callback: ()=>Navigator.of(context).pushReplacementNamed(RouteString.main,arguments: TabIndexString.tabProduct)
                  ),
                ),
                Container(
                  padding: scale.getPadding(0.5,2.5),
                  height: scale.getHeight(23),
                  child:  product.isLoadingBestSeller?LoadingProductHorizontal():ListView.builder(
                    padding: EdgeInsets.all(0.0),
                    physics: ClampingScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: product.productBestSellerModel.result.length,
                    itemBuilder: (BuildContext context, int index){
                      if(favorite.data.length>0){
                        for(int i=0;i<favorite.data.length;i++){
                          if(favorite.data[i][TableString.idProduct] == product.productBestSellerModel.result[index].id){
                            product.productBestSellerModel.result[index].isFavorite = "1";
                            break;
                          }
                          continue;
                        }
                      }
                      return ProductWidget1(
                        marginWidth: index==0?0:1,
                        heroTag: "produkTerlaris"+product.productBestSellerModel.result[index].id,
                        isFavorite:product.productBestSellerModel.result[index].isFavorite=="0"?false:true,
                        id:product.productBestSellerModel.result[index].id,
                        title: product.productBestSellerModel.result[index].title,
                        price: product.productBestSellerModel.result[index].price,
                        productSale:"${product.productBestSellerModel.result[index].terjual} terjual" ,
                        image: product.productBestSellerModel.result[index].image,
                        isContributor: false,
                      );
                    },
                  ),
                ),
                Padding(
                  padding: scale.getPadding(0,2.5),
                  child: TitleSectionWidget(
                    title: "Produk terbaru",
                    callback: ()=>Navigator.of(context).pushReplacementNamed(RouteString.main,arguments: TabIndexString.tabProduct),
                  ),
                ),
                product.isLoadingNew?LoadingProduct():Container(
                  padding: scale.getPadding(0.5,2.5),
                  child: new StaggeredGridView.countBuilder(
                    padding: EdgeInsets.all(0.0),
                    primary: false,
                    shrinkWrap: true,
                    crossAxisCount: 4,
                    itemCount:product.productNewModel.result.length,
                    staggeredTileBuilder: (int index) => new StaggeredTile.fit(2),
                    mainAxisSpacing: 10.0,
                    crossAxisSpacing: 10.0,
                    itemBuilder: (context,index){
                      if(favorite.data.length>0){
                        for(int i=0;i<favorite.data.length;i++){
                          if(favorite.data[i][TableString.idProduct] == product.productNewModel.result[index].id){
                            product.productNewModel.result[index].isFavorite = "1";
                            break;
                          }
                          continue;
                        }
                      }
                      return ProductWidget1(
                        marginWidth: index==0?0:0,
                        heroTag: "produkTerbaru"+product.productNewModel.result[index].id,
                        isFavorite:product.productNewModel.result[index].isFavorite=="0"?false:true,
                        id:product.productNewModel.result[index].id,
                        title: product.productNewModel.result[index].title,
                        price: product.productNewModel.result[index].price,
                        productSale:"${product.productNewModel.result[index].terjual} terjual" ,
                        image: product.productNewModel.result[index].image,
                        isContributor: true,
                        nameContributor: product.productNewModel.result[index].seller,
                        imageContributor: product.productNewModel.result[index].sellerFoto,
                        rateContributor: double.parse(product.productNewModel.result[index].rating.toString()),
                      );
                    },
                  ),
                ),
                if(!user.isLoadingLeaderBoard&&user.leaderBoardModel.result.length>0)Padding(
                  padding: scale.getPadding(0,2.5),
                  child: TitleSectionWidget(
                    title: "Leaderboard",
                    callback: (){},
                    isAction: false,
                  ),
                ),
                if(!user.isLoadingLeaderBoard&&user.leaderBoardModel.result.length>0)Container(
                  padding: scale.getPadding(0.5,2.5),
                  child:ListView.separated(
                      padding: EdgeInsets.zero,
                      primary: false,
                      shrinkWrap: true,
                      itemBuilder: (context,index){
                        final val = user.leaderBoardModel.result[index];
                        return FunctionalWidget.wrapContent(
                            child: ListTile(
                              leading: CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  radius: 20,
                                  backgroundImage: NetworkImage(val.foto)
                              ),
                              title: Text(val.fullname,style: Theme.of(context).textTheme.headline2),
                              subtitle: Text(val.bio,style: Theme.of(context).textTheme.subtitle1,maxLines: 1,overflow: TextOverflow.ellipsis),
                              trailing: Container(
                                width: scale.getWidth(10),
                                child: FunctionalWidget.rating(context: context,rate:double.parse(val.rating.toString())),
                              ),
                            )
                        );
                      },
                      separatorBuilder: (context,index){return SizedBox(height: scale.getHeight(0.5),);},
                      itemCount: user.leaderBoardModel.result.length
                  ),
                )
              ],
            ),
            onRefresh: ()=>onLoadService(),
          )
      ),
    );
  }
}
