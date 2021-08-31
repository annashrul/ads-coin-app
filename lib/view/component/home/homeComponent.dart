import 'package:adscoin/config/color_config.dart';
import 'package:adscoin/config/string_config.dart';
import 'package:adscoin/service/provider/userProvider.dart';
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
  TextEditingController anyController;


  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    ScreenScaler scale= ScreenScaler()..init(context);
    return Scaffold(
      body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxScrolled) {
            return <Widget>[
              AppBarWithActionWidget(
                color: ColorConfig.yellowColor,
                callback: (res){},
              )
            ];
          },
          body: ListView(
            padding: EdgeInsets.all(0),
            children: [
              Stack(
                children: [
                  DecoratedBox(
                      decoration: BoxDecoration(
                        color: ColorConfig.yellowColor,
                        borderRadius: BorderRadius.vertical(bottom: Radius.circular(4))
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
                  callback: (){},
                  radius: 10,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color(0xFF2D9CDB),
                        borderRadius: BorderRadius.circular(10)
                    ),
                    padding: scale.getPadding(2, 2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text("Situs kami memberi jaminan jam kerja tepat waktu dan penulisan memuaskan",style: Theme.of(context).textTheme.headline1.copyWith(color: Colors.white,fontWeight: FontWeight.w400))
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: 30,
                          backgroundImage: NetworkImage('https://www.iconpacks.net/icons/1/free-user-group-icon-296-thumb.png')
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: scale.getPadding(0,2.5),
                child: TitleSectionWidget(
                  title: "Produk terlaris",
                  callback: (){},
                ),
              ),
              Container(
                padding: scale.getPadding(0.5,2.5),
                height: scale.getHeight(23),
                child: ListView.builder(
                  padding: EdgeInsets.all(0.0),
                  physics: ClampingScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: 15,
                  itemBuilder: (BuildContext context, int index) => ProductWidget1(
                    marginWidth: index==0?0:1,
                    heroTag: "produkTerlaris"+index.toString(),
                    isFavorite: index==0?true:false,
                    id:"produkTerlaris"+index.toString(),
                    title: "Killer Content Writing",
                    price: "Rp 50.000",
                    productSale:"110 terjual" ,
                    image: GeneralString.dummyImgProduct,
                    isContributor: false,
                  ),

                ),
              ),
              Padding(
                padding: scale.getPadding(0,2.5),
                child: TitleSectionWidget(
                  title: "Produk terbaru",
                  callback: (){},
                ),
              ),
              Container(
                padding: scale.getPadding(0.5,2.5),
                child: new StaggeredGridView.countBuilder(
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
                    heroTag: "produkTerbaru"+index.toString(),
                    isFavorite: index==0?true:false,
                    id:"produkTerbaru"+index.toString(),
                    title: "Killer Content Writing",
                    price: "Rp 50.000",
                    productSale:"110 terjual" ,
                    image: GeneralString.dummyImgProduct,
                    isContributor: true,
                  ),
                ),
              )
            ],
          )
      ),
    );
  }
}
