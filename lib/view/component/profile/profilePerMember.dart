import 'package:adscoin/config/color_config.dart';
import 'package:adscoin/config/string_config.dart';
import 'package:adscoin/helper/formatCurrencyHelper.dart';
import 'package:adscoin/helper/functionalWidgetHelper.dart';
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
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

class ProfilePerMember extends StatefulWidget {
  final String id;
  ProfilePerMember({this.id});


  @override
  _ProfilePerMemberState createState() => _ProfilePerMemberState();
}

class _ProfilePerMemberState extends State<ProfilePerMember> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final seller  = Provider.of<ProfileSellerProvider>(context,listen: false);
    seller.getProfile(context: context,id: widget.id);
    seller.getProduct(context: context,id: widget.id);
  }

  @override
  Widget build(BuildContext context) {
    ScreenScaler scale= ScreenScaler()..init(context);
    final seller  = Provider.of<ProfileSellerProvider>(context);
    // final member = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: FunctionalWidget.appBarHelper(context: context,title: "profile seller"),
      body: Container(
        padding: scale.getPadding(1,2.5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: scale.getPaddingLTRB(0,1,0, 0),
              child: FunctionalWidget.wrapContent(
                  child: ListTile(
                    leading: seller.isLoadingProfile?BaseLoading(height: 3, width: 6):ImageRoundedWidget(
                      img: seller.profilePerMemberModel.result.foto,
                      height: scale.getHeight(3),
                      width: scale.getWidth(6),
                    ),
                    title: seller.isLoadingProfile?BaseLoading(height: 1, width: 30):Text(seller.profilePerMemberModel.result.fullname,style: Theme.of(context).textTheme.headline2,),
                    subtitle: seller.isLoadingProfile?BaseLoading(height: 1, width: 20):Text(seller.profilePerMemberModel.result.mobileNo,style: Theme.of(context).textTheme.subtitle1,),
                    trailing: Container(
                      width: scale.getWidth(30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InTouchWidget(
                              callback: ()=>FunctionalWidget.copy(context: context,text:seller.profilePerMemberModel.result.referral),
                              child: Container(
                                padding: scale.getPadding(0.5,1),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Color(0xFFFFC72C),width: 2),
                                  color: Color(0xFFF2F2F2),
                                  borderRadius: BorderRadius.circular(10),

                                ),
                                child:Icon(FlutterIcons.copy1_ant,color:  Color(0xFFFFC72C),size: scale.getTextSize(10)),
                              )
                          ),
                          SizedBox(width:scale.getWidth(1)),

                          InTouchWidget(
                              callback: ()async{
                                await Share.share(seller.profilePerMemberModel.result.referral);
                              },
                              child: Container(
                                padding: scale.getPadding(0.5,1),
                                decoration: BoxDecoration(
                                  border: Border.all(color:Color(0xFF219653),width: 2),
                                  color: Color(0xFFF2F2F2),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child:Icon(FlutterIcons.share_alt_faw,color: Color(0xFF219653),size: scale.getTextSize(10),),
                              )
                          )
                        ],
                      ),
                    ),
                  )
              ),
            ),
            Padding(
              padding: scale.getPaddingLTRB(0,1,0, 0),
              child: TitleSectionWidget(title: "Produk", callback: (){},isAction: false,),
            ),
            Expanded(
                child: seller.isLoadingProduct?ListView.separated(
                    padding: scale.getPaddingLTRB(0,1,0, 0),
                    itemBuilder: (context,index){
                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        onTap: (){},
                        leading: BaseLoading(height: 5, width: 10),
                        title: seller.isLoadingProfile?BaseLoading(height: 1, width: 30):Text("val.fullname",style: Theme.of(context).textTheme.headline2),
                        subtitle: seller.isLoadingProfile?BaseLoading(height: 1, width: 30):Text("asd",style: Theme.of(context).textTheme.subtitle1),
                      );
                    },
                    separatorBuilder: (context,index){return Divider();},
                    itemCount: 10
                ):seller.productSellerModel==null?NoDataWidget():ListView.separated(
                  padding: scale.getPaddingLTRB(0,1,0, 0),
                  itemBuilder: (context,index){
                    final val = seller.productSellerModel.result[index];
                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      onTap: (){
                        Navigator.of(context).pushNamed(RouteString.detailProduct,arguments: {
                          "image":val.image,
                          "heroTag":"productSeller${val.id}",
                          "id":val.id
                        });
                      },
                      leading: Hero(
                        tag: "productSeller${val.id}"+val.id,
                        child: ImageRoundedWidget(img:val.image,height: scale.getHeight(5),width: scale.getWidth(10),fit: BoxFit.cover,),
                      ),
                      title: Text(val.title,style: Theme.of(context).textTheme.headline2),
                      subtitle: Text(val.preview,style: Theme.of(context).textTheme.subtitle1),
                    );
                  },
                  separatorBuilder: (context,index){return Divider();},
                  itemCount: seller.productSellerModel.result.length
                )
            )
          ],
        ),
      ),
    );
  }


}
