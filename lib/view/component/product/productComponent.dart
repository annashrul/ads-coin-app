import 'package:adscoin/config/color_config.dart';
import 'package:adscoin/config/string_config.dart';
import 'package:adscoin/helper/ScreenScaleHelper.dart';
import 'package:adscoin/helper/functionalWidgetHelper.dart';
import 'package:adscoin/view/widget/general/appBarWithActionWidget.dart';
import 'package:adscoin/view/widget/general/imageRoundedWidget.dart';
import 'package:adscoin/view/widget/product/productWidget1.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';


class ProductComponent extends StatefulWidget {
  @override
  _ProductComponentState createState() => _ProductComponentState();
}

class _ProductComponentState extends State<ProductComponent> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController anyController;

  @override
  Widget build(BuildContext context) {
    ScreenScaleHelper scale = ScreenScaleHelper()..init(context);
    List<Widget> historyTab = [];
    List<Widget> historyView = [];
    for(int i=0;i<10;i++){
      historyView.add(buildContent(context));
      historyTab.add(
        Tab(
          child: Container(
            padding: scale.getPadding(0,1),
            // decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),border: Border.all(color:Color(0xFF2D9CDB), width: 1)),
            child: Align(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ImageRoundedWidget(img: "https://www.pngkey.com/png/full/817-8171322_computer-icons-book-clip-art-black-icon-transparent.png",height: scale.getHeight(1),),
                  SizedBox(width: scale.getWidth(1)),
                  Text("Copywriting")
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
          key: _scaffoldKey,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: scale.getPadding(0, 0),
                  width:scale.getWidth(72),
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
            bottom: TabBar(
              indicatorPadding: scale.getPadding(0,0),
              labelPadding: scale.getPadding(0,1),
              unselectedLabelColor: Theme.of(context).accentColor,
              labelColor:Colors.black,
              labelStyle: Theme.of(context).textTheme.subtitle1,
              isScrollable: true,
              tabs:historyTab,
              onTap: (e){
                this.setState(() {});
              },
            ),
          ),
          body: Container(
            padding: scale.getPadding(1,2.5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text("Kategori",style: Theme.of(context).textTheme.headline1),
                Expanded(
                    child:TabBarView(children:historyView)
                )
              ],
            ),
          )
        )
    );
  }


  Widget buildContent(BuildContext context){
    ScreenScaleHelper scale = ScreenScaleHelper()..init(context);
    return new StaggeredGridView.countBuilder(
      padding: EdgeInsets.all(0.0),
      primary: false,
      shrinkWrap: true,
      crossAxisCount: 4,
      itemCount:10,
      staggeredTileBuilder: (int index) => new StaggeredTile.fit(2),
      mainAxisSpacing: 10.0,
      crossAxisSpacing: 10.0,
      itemBuilder: (context,index)=>ProductWidget1(
        marginWidth: index==0?0:0,
        heroTag: "mainProduk"+index.toString(),
        isFavorite: index==0?true:false,
        id:"mainProduk"+index.toString(),
        title: "Killer Content Writing",
        price: "Rp 50.000",
        productSale:"110 terjual" ,
        image: GeneralString.dummyImgProduct,
        isContributor: true,
      ),
    );
  }

}
