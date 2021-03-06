import 'package:adscoin/config/color_config.dart';
import 'package:adscoin/config/string_config.dart';
import 'package:adscoin/helper/functionalWidgetHelper.dart';
import 'package:adscoin/service/provider/siteProvider.dart';
import 'package:adscoin/service/provider/userProvider.dart';
import 'package:adscoin/view/component/loadingComponent.dart';
import 'package:adscoin/view/widget/general/imageRoundedWidget.dart';
import 'package:adscoin/view/widget/general/touchWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

class ReferralComponent extends StatefulWidget {
  @override
  _ReferralComponentState createState() => _ReferralComponentState();
}

class _ReferralComponentState extends State<ReferralComponent> {

  ScrollController controller;
  void scrollListener() {
    final referral = Provider.of<UserProvider>(context, listen: false);
    if (!referral.isLoadingListReferral) {
      if (controller.position.pixels == controller.position.maxScrollExtent) {
        referral.loadMoreListReferral(context);
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final referral = Provider.of<UserProvider>(context,listen: false);
    referral.getListReferral(context: context);
    controller = new ScrollController()..addListener(scrollListener);
    final config = Provider.of<SiteProvider>(context,listen: false);
    config.getConfig(context: context);
  }
  @override
  void dispose() {
    super.dispose();
    controller.removeListener(scrollListener);
  }
  @override
  Widget build(BuildContext context) {
    final member = Provider.of<UserProvider>(context);
    ScreenScaler scale = ScreenScaler()..init(context);
    final config = Provider.of<SiteProvider>(context);

    return Scaffold(
      appBar: FunctionalWidget.appBarHelper(context: context,title: "Kode referral"),
      body: SingleChildScrollView(
        controller: controller,
        padding: scale.getPadding(1,2.5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(GeneralString.imgLocalPng+"referal.png",height: scale.getHeight(30),),
            ),
            SizedBox(height: scale.getHeight(3)),
            Center(
              child: Text("Ajak teman, dapat cashback",style: Theme.of(context).textTheme.headline1),
            ),
            SizedBox(height: scale.getHeight(1)),
            Center(
              child: Text("Dapatkan cashback senilai ${config.configModel.result[0].komisiReferral}% untuk setiap teman yang mendaftar dan bertransaksi di AdsCoin menggunakan kode referal kamu.",style: Theme.of(context).textTheme.headline2,textAlign: TextAlign.center,),
            ),
            SizedBox(height: scale.getHeight(3)),
            Text("Bagikan kode referral kamu",style: Theme.of(context).textTheme.subtitle1),
            SizedBox(height: scale.getHeight(0.5)),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                    child: InTouchWidget(
                        callback: ()async{
                          await Share.share("https://reg.adscoin.id/${member.referral}");
                        },
                        child: Container(
                          width: double.infinity,
                          padding: scale.getPadding(1,2),
                          decoration: BoxDecoration(
                            border: Border.all(color: ColorConfig.bluePrimaryColor,width: 2),
                            color: Color(0xFF2D9CDB),
                            borderRadius: BorderRadius.circular(10),

                          ),
                          child:Text("${member.referral}",style: Theme.of(context).textTheme.headline1.copyWith(color: Colors.white),textAlign: TextAlign.center,),
                        )
                    )
                ),
                SizedBox(width:scale.getWidth(1)),
                InTouchWidget(
                    callback: ()=>FunctionalWidget.copy(context: context,text: member.referral),
                    child: Container(
                      padding: scale.getPadding(1,2),
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFFFFC72C),width: 2),
                        color: Color(0xFFF2F2F2),
                        borderRadius: BorderRadius.circular(10),

                      ),
                      child:Icon(FlutterIcons.copy1_ant,color:  Color(0xFFFFC72C),),
                    )
                ),
                SizedBox(width:scale.getWidth(1)),

                InTouchWidget(
                    callback: ()async{
                      await Share.share("https://reg.adscoin.id/${member.referral}");
                    },
                    child: Container(
                      padding: scale.getPadding(1,2),
                      decoration: BoxDecoration(
                        border: Border.all(color:Color(0xFF219653),width: 2),
                        color: Color(0xFFF2F2F2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child:Icon(FlutterIcons.share_alt_faw,color: Color(0xFF219653),),
                    )
                )
              ],
            ),
            member.isLoadingListReferral?LoadingReferral():member.listReferralMember==null?SizedBox():ListView.separated(
                padding: scale.getPaddingLTRB(0,1,0, 0),
                physics: ClampingScrollPhysics(),
                primary: false,
                shrinkWrap: true,

                itemBuilder: (context,index){
                  final val = member.listReferralMember.result[index];
                  String textSubtitle = "";
                  Color colorSub = ColorConfig.blackSecondaryColor;
                  if(val.produkReward==""){
                    textSubtitle="-";
                  }
                  else{
                    if(val.rewardCoin=="0"){
                      colorSub = ColorConfig.redColor;
                      textSubtitle = "belum closing";
                    }else{
                      colorSub = Color(0xFF219653);
                      textSubtitle = "Bonus : ${val.rewardCoin} coin";
                    }
                  }

                  return FunctionalWidget.wrapContent(
                    child: ListTile(
                      leading: ImageRoundedWidget(img:val.foto,height: scale.getHeight(3),width: scale.getWidth(6),fit: BoxFit.cover,),
                      title: Text(val.fullname==null?"-":val.fullname,style: Theme.of(context).textTheme.headline2),
                      subtitle: Text(textSubtitle,style: Theme.of(context).textTheme.subtitle1.copyWith(color: colorSub)),
                    )
                  );
                },
                separatorBuilder: (context,index){return SizedBox(height: scale.getHeight(1));},
                itemCount: member.listReferralMember.result.length
            )
          ],
        ),
      ),
      bottomNavigationBar: member.isLoadMoreListReferral?CupertinoActivityIndicator():SizedBox(),
    );
  }
}
