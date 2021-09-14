import 'package:adscoin/config/color_config.dart';
import 'package:adscoin/config/string_config.dart';
import 'package:adscoin/helper/functionalWidgetHelper.dart';
import 'package:adscoin/service/provider/GeneralProvider.dart';
import 'package:adscoin/service/provider/productProvider.dart';
import 'package:adscoin/view/component/loadingComponent.dart';
import 'package:adscoin/view/widget/general/buttonWidget.dart';
import 'package:adscoin/view/widget/general/imageRoundedWidget.dart';
import 'package:adscoin/view/widget/general/noDataWidget.dart';
import 'package:adscoin/view/widget/general/touchWidget.dart';
import 'package:adscoin/view/widget/product/optionActionProductWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:provider/provider.dart';

class ProductContributorComponent extends StatefulWidget {
  @override
  _ProductContributorComponentState createState() => _ProductContributorComponentState();
}

class _ProductContributorComponentState extends State<ProductContributorComponent> {
  TextEditingController anyController = TextEditingController();
  ScrollController controller;
  void scrollListener() {
    final product = Provider.of<ProductProvider>(context, listen: false);
    if (!product.isLoadingProductContributor) {
      if (controller.position.pixels == controller.position.maxScrollExtent) {
        product.loadMoreContributor(context);

      }
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final product = Provider.of<ProductProvider>(context, listen: false);
    product.getProductContributor(context: context);
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
    final general = Provider.of<GeneralProvider>(context);
    final product = Provider.of<ProductProvider>(context);
    return Scaffold(
      appBar: FunctionalWidget.appBarWithFilterHelper(
        context: context,
        title: "Daftar produk",
        action: <Widget>[
          FunctionalWidget.iconAppbar(
            context: context,
            callback: (){general.setConditionFilterProductContributor(true);},
            image: "Group",
            color:general.conditionFilterProductContributor?ColorConfig.bluePrimaryColor:ColorConfig.grayPrimaryColor
          ),
          FunctionalWidget.iconAppbar(
              context: context,
              callback: (){general.setConditionFilterProductContributor(false);},
              image: "Search",
              color:!general.conditionFilterProductContributor?ColorConfig.bluePrimaryColor:ColorConfig.grayPrimaryColor
          )
        ]
      ),
      body: Padding(
        padding: scale.getPadding(1,2.5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            !general.conditionFilterProductContributor?Container(
              padding: scale.getPadding(0, 0),
              width:scale.getWidth(100),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xFFF2F2F2)
              ),
              child: TextField(
                controller: anyController,
                decoration: InputDecoration(
                  contentPadding: scale.getPadding(1,2),
                  hintStyle: Theme.of(context).textTheme.subtitle1,
                  hintText:"Ads copy, landingpage, caption",
                  border: InputBorder.none,
                  suffixIcon: Icon(FlutterIcons.search_fea,color: Theme.of(context).textTheme.subtitle1.color,),
                ),
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.search,
                onSubmitted: (e){
                  product.setAnyProductContributor(context, e);
                },
              ),
            ):
            Row(
              children: [
                Container(
                  margin: scale.getMarginLTRB(0, 0, 1, 0),
                  decoration: BoxDecoration(
                    color: product.filterStatusProduct==2?ColorConfig.bluePrimaryColor:ColorConfig.graySecondaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: FlatButton(
                    onPressed: (){
                      product.setFilterStatusProductContributor(context: context,input: 2);
                    },
                    child: Text("Semua",style: Theme.of(context).textTheme.headline1.copyWith(color:product.filterStatusProduct==2?ColorConfig.graySecondaryColor:ColorConfig.grayPrimaryColor,),textAlign: TextAlign.center,),
                  ),
                ),
                Container(
                  margin: scale.getMarginLTRB(0, 0, 1, 0),
                  decoration: BoxDecoration(
                    color: product.filterStatusProduct==1?ColorConfig.bluePrimaryColor:ColorConfig.graySecondaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: FlatButton(
                    onPressed: (){
                      product.setFilterStatusProductContributor(context: context,input: 1);
                    },
                    child: Text("Publish",style: Theme.of(context).textTheme.headline1.copyWith(color:product.filterStatusProduct==1?ColorConfig.graySecondaryColor:ColorConfig.grayPrimaryColor,),textAlign: TextAlign.center,),
                  ),
                ),
                Container(
                  margin: scale.getMarginLTRB(0, 0, 0, 0),
                  decoration: BoxDecoration(
                    color: product.filterStatusProduct==0?ColorConfig.bluePrimaryColor:ColorConfig.graySecondaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: FlatButton(
                    onPressed: (){
                      product.setFilterStatusProductContributor(context: context,input: 0);
                    },
                    child: Text("Draft",style: Theme.of(context).textTheme.headline1.copyWith(color:product.filterStatusProduct==0?ColorConfig.graySecondaryColor:ColorConfig.grayPrimaryColor,),textAlign: TextAlign.center,),
                  ),
                ),
              ],
            ),
            SizedBox(height: scale.getHeight(1)),
            InTouchWidget(
                callback: (){
                  product.setIsAdd(true);
                  Navigator.of(context).pushNamed(RouteString.formProductContributor).whenComplete(() => product.getProductContributor(context: context));
                },
                child: Row(
                  children: [
                    Image.asset(GeneralString.imgLocalPng+"PaperPlus.png",height: scale.getHeight(1.5),color:ColorConfig.bluePrimaryColor,),
                    SizedBox(width: scale.getWidth(1)),
                    Text("Tambah produk",style: Theme.of(context).textTheme.headline2.copyWith(color:ColorConfig.bluePrimaryColor))
                  ],
                )
            ),
            SizedBox(height: scale.getHeight(1)),
            Expanded(
                child: RefreshIndicator(
                  onRefresh: ()=>product.getProductContributor(context: context),
                  child: product.isLoadingProductContributor?LoadingProductContributor():product.productContributorModel==null?NoDataWidget():ListView.separated(
                    physics: AlwaysScrollableScrollPhysics(),
                    itemBuilder: (context,index){
                      final val = product.productContributorModel.result[index];
                      String heroTag="productContributor" + val.id;
                      String status = "";Color colorStatus;
                      if(val.status==0) {
                        status = "Draft";
                        colorStatus = ColorConfig.redColor;
                      }
                      if(val.status==1){
                        status = "Publish";
                        colorStatus = ColorConfig.bluePrimaryColor;
                      }
                      return InTouchWidget(
                          radius: 10,
                          callback: (){
                            product.setDataEditProductContributor(val.toJson());
                            FunctionalWidget.modal(
                                context: context,
                                child: OptionActionProductWidget(dataJson: val.toJson()..addAll({"heroTag":heroTag}))
                            );
                          },
                          child:FunctionalWidget.wrapContent(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                ),
                                child: Row(
                                  children: [
                                    Hero(
                                      tag: heroTag,
                                      child: ImageRoundedWidget(
                                        img: val.image,
                                        width:scale.getWidth(16),
                                        height: scale.getHeight(7),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    SizedBox(width: scale.getWidth(2)),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(val.title,style: Theme.of(context).textTheme.headline2,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text("terjual",style: Theme.of(context).textTheme.subtitle1),
                                                SizedBox(width: scale.getWidth(1)),
                                                Text(":",style: Theme.of(context).textTheme.subtitle1),
                                                SizedBox(width: scale.getWidth(1)),
                                                Text(val.terjual,style: Theme.of(context).textTheme.subtitle1.copyWith(color: ColorConfig.blackPrimaryColor)),
                                              ],
                                            ),
                                            SizedBox(width: scale.getWidth(1)),
                                            Row(
                                              children: [
                                                Text("status",style: Theme.of(context).textTheme.subtitle1),
                                                SizedBox(width: scale.getWidth(1)),
                                                Text(":",style: Theme.of(context).textTheme.subtitle1),
                                                SizedBox(width: scale.getWidth(1)),
                                                Text(status.toString(),style: Theme.of(context).textTheme.subtitle1.copyWith(color:colorStatus)),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Container(
                                          width: scale.getWidth(60),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(FunctionalWidget.toCoin(double.parse(val.price)),style: Theme.of(context).textTheme.headline2),
                                              InTouchWidget(
                                                callback: ()async{
                                                  product.setDataEditProductContributor(val.toJson());
                                                  FunctionalWidget.modal(
                                                      context: context,
                                                      child: OptionActionProductWidget(dataJson: val.toJson()..addAll({"heroTag":heroTag}))
                                                  );
                                                },
                                                child: Icon(FlutterIcons.ios_more_ion),
                                                radius: 0,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              )
                          )
                      );
                    },
                    separatorBuilder: (context,index){return SizedBox(height: scale.getHeight(1));},
                    itemCount: product.productContributorModel.result.length,
                    controller:controller,
                  ),
                )
            ),
            product.isLoadMoreProductContributor?Container(
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
}
