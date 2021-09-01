import 'package:adscoin/config/color_config.dart';
import 'package:adscoin/config/string_config.dart';
import 'package:adscoin/helper/functionalWidgetHelper.dart';
import 'package:adscoin/service/provider/GeneralProvider.dart';
import 'package:adscoin/service/provider/productProvider.dart';
import 'package:adscoin/view/widget/general/buttonWidget.dart';
import 'package:adscoin/view/widget/general/touchWidget.dart';
import 'package:adscoin/view/widget/product/optionActionProductWidget.dart';
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
  @override
  Widget build(BuildContext context) {
    ScreenScaler scale= ScreenScaler()..init(context);
    final general = Provider.of<GeneralProvider>(context);
    final product = Provider.of<ProductProvider>(context);
    print(general.conditionStatusProductContributor);
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
              ),
            ):
            Row(
              children: [
                Container(
                  width: scale.getWidth(30),
                  child: BackroundButtonWidget(
                    callback: (){
                      general.setConditionStatusProductContributor(true);
                    },
                    backgroundColor: general.conditionStatusProductContributor?ColorConfig.bluePrimaryColor:ColorConfig.graySecondaryColor,
                    color: general.conditionStatusProductContributor?ColorConfig.graySecondaryColor:ColorConfig.grayPrimaryColor,
                    title: "Selesai",
                  ),
                ),
                SizedBox(width: scale.getWidth(1)),
                Container(
                  width: scale.getWidth(30),
                  child: BackroundButtonWidget(
                    callback: (){
                      general.setConditionStatusProductContributor(false);
                    },
                    backgroundColor: !general.conditionStatusProductContributor?ColorConfig.bluePrimaryColor:ColorConfig.graySecondaryColor,
                    color: !general.conditionStatusProductContributor?ColorConfig.graySecondaryColor:ColorConfig.grayPrimaryColor,
                    title: "Draf",
                  ),
                )
              ],
            ),
            SizedBox(height: scale.getHeight(1)),
            InTouchWidget(
                callback: ()async{
                  await product.setIsAdd(true);
                  Navigator.of(context).pushNamed(RouteString.formProductContributor);
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
                child: ListView.separated(
                    itemBuilder: (context,index){
                      return InTouchWidget(
                        radius: 10,
                          callback: (){},
                          child:FunctionalWidget.wrapContent(
                            child: Padding(
                              padding: scale.getPadding(0.5,2),
                              child: Row(
                                children: [
                                  Container(
                                    height: scale.getHeight(7),
                                    width: scale.getWidth(14),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(GeneralString.dummyImgProduct)
                                        )
                                    ),
                                  ),
                                  SizedBox(width: scale.getWidth(2)),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Copywriting untuk Website",style: Theme.of(context).textTheme.headline2,),
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
                                              Text("2",style: Theme.of(context).textTheme.subtitle1.copyWith(color: ColorConfig.blackPrimaryColor)),
                                            ],
                                          ),
                                          SizedBox(width: scale.getWidth(1)),
                                          Row(
                                            children: [
                                              Text("Pengerjaan",style: Theme.of(context).textTheme.subtitle1),
                                              SizedBox(width: scale.getWidth(1)),
                                              Text(":",style: Theme.of(context).textTheme.subtitle1),
                                              SizedBox(width: scale.getWidth(1)),
                                              Text("2 hari",style: Theme.of(context).textTheme.subtitle1.copyWith(color: ColorConfig.blackPrimaryColor)),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Container(
                                        width: scale.getWidth(60),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("Rp 50,000",style: Theme.of(context).textTheme.headline2),
                                            InTouchWidget(
                                              callback: ()async{
                                                FunctionalWidget.modal(
                                                  context: context,
                                                  child: OptionActionProductWidget()
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
                    itemCount: 10
                )
            )
          ],
        ),
      ),
    );
  }
}
