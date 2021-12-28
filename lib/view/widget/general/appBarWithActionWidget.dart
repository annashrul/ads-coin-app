import 'package:adscoin/config/color_config.dart';
import 'package:adscoin/config/string_config.dart';
import 'package:adscoin/helper/functionalWidgetHelper.dart';
import 'package:adscoin/service/provider/listProductProvider.dart';
import 'package:adscoin/service/provider/userProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

// ignore: must_be_immutable
class AppBarWithActionWidget extends StatefulWidget {
  final Color color;
  Function(String any) callback;
  AppBarWithActionWidget({this.color,this.callback});
  @override
  _AppBarWithActionWidgetState createState() => _AppBarWithActionWidgetState();
}

class _AppBarWithActionWidgetState extends State<AppBarWithActionWidget> {
  TextEditingController anyController;
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<ListProductProvider>(context);
    final member = Provider.of<UserProvider>(context);
    ScreenScaler scale= ScreenScaler()..init(context);
    return SliverAppBar(
      titleSpacing: 0.0,
      toolbarHeight: scale.getHeight(7),
      backgroundColor: widget.color!=null? widget.color:Colors.white,
      pinned: true,
      title: Container(
        margin: scale.getMarginLTRB(2.5, 0, 2.5, 0),
        child:Row(
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
                readOnly: true,
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
                  // product.setQ(context: context,input: e);
                  Navigator.of(context).pushNamed(RouteString.search,arguments: e.toString());
                },
                onTap: (){
                  Navigator.of(context).pushNamed(RouteString.search,arguments: "");
                },

              ),
            ),
            InkResponse(
              onTap: ()async{
                await Share.share("https://reg.adscoin.id/${member.referral}");
                // if(member.detailMemberModel.result.idType==1){
                //   await Share.share("https://reg.adscoin.id/${member.referral}");
                // }else{
                //   FunctionalWidget.toast(context: context,msg: "anda belum menjadi kontributor");
                // }
              },
              child: Container(
                padding: scale.getPadding(0.7,2),
                decoration: BoxDecoration(
                  border: Border.all(color:Color(0xFF219653),width: 2),
                  color: Color(0xFFF2F2F2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child:Icon(FlutterIcons.share_alt_faw,color: Color(0xFF219653),),
              ),
              // child: Icon(
              //     FlutterIcons.share_alt_faw,
              //     size: scale.getTextSize(15),
              //     color:ColorConfig.graySecondaryColor
              // ),
            )
          ],
        ),
      ),
    );
  }
}

