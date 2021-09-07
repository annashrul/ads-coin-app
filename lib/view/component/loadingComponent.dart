import 'package:adscoin/config/color_config.dart';
import 'package:adscoin/helper/functionalWidgetHelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:shimmer/shimmer.dart';


class BaseLoading extends StatelessWidget {
  final double height;
  final double width;
  final double radius;

  BaseLoading({@required this.height,@required this.width,this.radius=10});
  @override
  Widget build(BuildContext context) {
    ScreenScaler scale = ScreenScaler()..init(context);
    return Shimmer.fromColors(
      baseColor: Theme.of(context).unselectedWidgetColor,
      highlightColor: Colors.grey[100],
      enabled: true,
      child: Container(
        width:scale.getWidth(this.width),
        height: scale.getHeight(this.height),
        decoration: BoxDecoration(
          color:Colors.grey[200],
          borderRadius: BorderRadius.all(Radius.circular(this.radius))
        ),
      ),
    );

  }
}


class LoadingProduct extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenScaler scale = ScreenScaler()..init(context);
    return Container(
      margin: scale.getMarginLTRB(0,0,1,0),
      width: scale.getWidth(35),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          BaseLoading(width:42,height:13),
          SizedBox(height: scale.getHeight(0.5)),
          BaseLoading(width:42,height:1),
          SizedBox(height: scale.getHeight(0.5)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BaseLoading(width:20,height:1),
              BaseLoading(width:10,height:1),
            ],
          ),
        ],
      ),
    );

  }
}

class LoadingHistoryPurchase extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenScaler scale = ScreenScaler()..init(context);

    return ListView.separated(
      padding: scale.getPadding(1,2.5),
      itemCount:5,
      itemBuilder: (context,index){
        return FunctionalWidget.wrapContent(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: scale.getPaddingLTRB(2,1, 1,0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BaseLoading(height: 1, width: 50),
                          SizedBox(height: 2.0),
                          BaseLoading(height: 1, width: 50),
                        ],
                      ),
                    ],
                  ),
                ),
                Divider(),
                Container(
                  padding: scale.getPaddingLTRB(2,0, 0,0),
                  child: Row(
                    children: [
                      BaseLoading(radius:10,height: 5,width:12),
                      SizedBox(width: scale.getWidth(2)),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BaseLoading(height: 1, width:30 ),
                          SizedBox(height: scale.getHeight(0.5)),
                          BaseLoading(height: 1, width:50 ),
                        ],
                      )
                    ],
                  ),
                ),

                Container(
                    padding: scale.getPaddingLTRB(2,1, 0,1),
                    child:Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BaseLoading(height: 1, width:30 ),
                      ],
                    )
                )


                // Container(
                //   width: scale.getWidth(40),
                //   alignment: Alignment.topCenter,
                //   margin: scale.getMarginLTRB(0,0,2,1),
                //   child: BackroundButtonWidget(
                //     callback: (){
                //       Navigator.of(context).pushNamed(RouteString.detailProduct,arguments: "");
                //     },
                //     backgroundColor: ColorConfig.redColor,
                //     title: "Lihat produk",
                //   ),
                // )
              ],
            )
        );
      },
      separatorBuilder: (context,index){return SizedBox(height: scale.getHeight(1));},
    );
  }
}

