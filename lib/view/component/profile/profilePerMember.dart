import 'package:adscoin/config/color_config.dart';
import 'package:adscoin/config/string_config.dart';
import 'package:adscoin/helper/formatCurrencyHelper.dart';
import 'package:adscoin/helper/functionalWidgetHelper.dart';
import 'package:adscoin/service/provider/favoriteProvider.dart';
import 'package:adscoin/service/provider/productProvider.dart';
import 'package:adscoin/service/provider/profileSellerProvider.dart';
import 'package:adscoin/service/provider/siteProvider.dart';
import 'package:adscoin/service/provider/userProvider.dart';
import 'package:adscoin/view/component/loadingComponent.dart';
import 'package:adscoin/view/widget/general/cardAction.dart';
import 'package:adscoin/view/widget/general/imageRoundedWidget.dart';
import 'package:adscoin/view/widget/general/noDataWidget.dart';
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
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilePerMember extends StatefulWidget {
  final String id;
  ProfilePerMember({this.id});


  @override
  _ProfilePerMemberState createState() => _ProfilePerMemberState();
}

class _ProfilePerMemberState extends State<ProfilePerMember> {
  ScrollController controller;
  void scrollListener() {
    final seller = Provider.of<ProfileSellerProvider>(context, listen: false);
    if (!seller.isLoadingProduct) {
      if (controller.position.pixels == controller.position.maxScrollExtent) {
        seller.loadMoreContributor(context, widget.id);
      }
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final seller  = Provider.of<ProfileSellerProvider>(context,listen: false);
    final favorite = Provider.of<FavoriteProvider>(context,listen: false);
    favorite.get();
    seller.getProfile(context: context,id: widget.id);
    seller.getProduct(context: context,id: widget.id);
    controller = new ScrollController()..addListener(scrollListener);
  }
  @override
  void dispose() {
    super.dispose();
    controller.removeListener(scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    ScreenScaler scale= ScreenScaler()..init(context);
    final seller  = Provider.of<ProfileSellerProvider>(context);
    final favorite = Provider.of<FavoriteProvider>(context);
    return Scaffold(
      appBar: FunctionalWidget.appBarHelper(context: context,title: "profile kontributor"),
      body: Container(
        padding: scale.getPadding(1,2.5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                seller.isLoadingProfile?BaseLoading(height:10, width: 20):ImageRoundedWidget(
                  img: seller.profilePerMemberModel.result.foto,
                  // img: GeneralString.dummyImgProduct,
                  height: scale.getHeight(10),
                  width: scale.getWidth(20),
                  // fit: BoxFit.cover,
                ),
                SizedBox(width: scale.getWidth(1)),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          child: Text("Nama",style: Theme.of(context).textTheme.subtitle1.copyWith(color: Theme.of(context).textTheme.headline1.color)),
                          width: scale.getWidth(20),
                        ),
                        Text(":",style: Theme.of(context).textTheme.subtitle1.copyWith(color: Theme.of(context).textTheme.subtitle2.color)),
                        SizedBox(width: scale.getWidth(1)),
                        seller.isLoadingProfile?BaseLoading(height: 1, width:20):Text( seller.profilePerMemberModel.result.fullname,style: Theme.of(context).textTheme.subtitle1)
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          child: Text("Rating",style: Theme.of(context).textTheme.subtitle1.copyWith(color: Theme.of(context).textTheme.headline1.color)),
                          width: scale.getWidth(20),
                        ),
                        Text(":",style: Theme.of(context).textTheme.subtitle1.copyWith(color: Theme.of(context).textTheme.subtitle2.color)),
                        SizedBox(width: scale.getWidth(1)),
                        seller.isLoadingProfile?BaseLoading(height: 1, width:20):FunctionalWidget.rating(context: context,rate: double.parse("2.0"))
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          child: Text("Penjualan",style: Theme.of(context).textTheme.subtitle1.copyWith(color: Theme.of(context).textTheme.headline1.color)),
                          width: scale.getWidth(20),
                        ),
                        Text(":",style: Theme.of(context).textTheme.subtitle1.copyWith(color: Theme.of(context).textTheme.subtitle2.color)),
                        SizedBox(width: scale.getWidth(1)),
                        seller.isLoadingProfile?BaseLoading(height: 1, width:20):Text( seller.profilePerMemberModel.result.copyTerjual+" copy",style: Theme.of(context).textTheme.subtitle1)
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          child: Text("Website",style: Theme.of(context).textTheme.subtitle1.copyWith(color: Theme.of(context).textTheme.headline1.color)),
                          width: scale.getWidth(20),
                        ),
                        Text(":",style: Theme.of(context).textTheme.subtitle1.copyWith(color: Theme.of(context).textTheme.subtitle2.color)),
                        SizedBox(width: scale.getWidth(1)),
                        seller.isLoadingProfile?BaseLoading(height: 1, width:20):InkResponse(
                          onTap: ()async{
                            if(seller.profilePerMemberModel.result.website!=null){
                              _launchURL(seller.profilePerMemberModel.result.website);
                            }
                          },
                          child: Text(seller.profilePerMemberModel.result.website==null?"-":seller.profilePerMemberModel.result.website,style: Theme.of(context).textTheme.subtitle1.copyWith(color: ColorConfig.bluePrimaryColor)),
                        )
                      ],
                    ),
                    Container(
                      width: scale.getWidth(60),
                      child: seller.isLoadingProfile?BaseLoading(height: 1, width:20):Text(seller.profilePerMemberModel.result.bio==null?"-":seller.profilePerMemberModel.result.bio,style: Theme.of(context).textTheme.subtitle1,),
                    )
                  ],
                )
              ],
            ),
            Padding(
              padding: scale.getPaddingLTRB(0,1,0, 0),
              child: TitleSectionWidget(title: "Produk", callback: (){},isAction: false,),
            ),
            Divider(),
            Expanded(
                child: RefreshIndicator(
                  onRefresh: ()=>seller.getProduct(context: context,id: widget.id),
                  child: seller.isLoadingProduct? LoadingProduct():seller.productSellerModel==null?NoDataWidget():new StaggeredGridView.countBuilder(
                    padding: EdgeInsets.all(0.0),
                    primary: false,
                    shrinkWrap: true,
                    crossAxisCount: 4,
                    controller: controller,
                    itemCount:seller.productSellerModel.result.length,
                    staggeredTileBuilder: (int index) => new StaggeredTile.fit(2),
                    mainAxisSpacing: 10.0,
                    crossAxisSpacing: 10.0,
                    itemBuilder: (context,index){
                      final val = seller.productSellerModel.result[index];
                      if(favorite.data.length>0){
                        for(int i=0;i<favorite.data.length;i++){
                          if(favorite.data[i][TableString.idProduct] == val.id){
                            val.isFavorite = "1";
                            break;
                          }
                          continue;
                        }
                      }
                      return ProductWidget1(
                        marginWidth: index==0?0:0,
                        heroTag: "produkSeller"+val.id,
                        isFavorite:val.isFavorite=="1"?true:false,
                        id:val.id,
                        title: val.title,
                        price: val.price,
                        productSale:"${val.terjual} terjual" ,
                        image: val.image,
                        isContributor: false,
                      );
                    },
                  ),
                )
            ),
            seller.isLoadMoreProduct?Container(
                alignment: Alignment.center,
                padding: scale.getPaddingLTRB(0,1,0,0),
                child:Center(
                  child: CupertinoActivityIndicator(),
                )
            ):SizedBox(),
          ],
        ),
      ),
    );


  }

  void _launchURL(_url) async =>
      await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';



}
