import 'package:adscoin/config/color_config.dart';
import 'package:adscoin/config/string_config.dart';
import 'package:adscoin/helper/functionalWidgetHelper.dart';
import 'package:adscoin/service/provider/userProvider.dart';
import 'package:adscoin/view/component/loadingComponent.dart';
import 'package:adscoin/view/widget/general/imageRoundedWidget.dart';
import 'package:adscoin/view/widget/general/touchWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:provider/provider.dart';

class ReferralComponent extends StatefulWidget {
  @override
  _ReferralComponentState createState() => _ReferralComponentState();
}

class _ReferralComponentState extends State<ReferralComponent> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final referral = Provider.of<UserProvider>(context,listen: false);
    referral.getListReferral(context: context);
  }

  @override
  Widget build(BuildContext context) {
    final member = Provider.of<UserProvider>(context);
    ScreenScaler scale = ScreenScaler()..init(context);
    return Scaffold(
      appBar: FunctionalWidget.appBarHelper(context: context,title: "Kode referral"),
      body: SingleChildScrollView(
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
              child: Text("Dapatkan cashback senilai Rp 25.000 untuk setiap teman yang mendaftar dan bertransaksi di AdsCoin menggunakan kode referal kamu.",style: Theme.of(context).textTheme.headline2,textAlign: TextAlign.center,),
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
                        callback: (){},
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
                    callback: (){},
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
                    callback: (){},
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
                  return FunctionalWidget.wrapContent(
                    child: ListTile(
                      leading: ImageRoundedWidget(img: GeneralString.dummyImgUser,height: scale.getHeight(3),width: scale.getWidth(6),),
                      title: Text(val.fullname,style: Theme.of(context).textTheme.headline2),
                      subtitle: Text(val.produkReward=="-"?val.rewardCoin:val.produkReward,style: Theme.of(context).textTheme.subtitle1),
                    )
                  );
                },
                separatorBuilder: (context,index){return SizedBox(height: scale.getHeight(1));},
                itemCount: member.listReferralMember.result.length
            )
          ],
        ),
      )
    );
  }
}
