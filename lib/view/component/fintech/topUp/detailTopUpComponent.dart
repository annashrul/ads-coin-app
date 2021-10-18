import 'package:adscoin/config/color_config.dart';
import 'package:adscoin/config/string_config.dart';
import 'package:adscoin/helper/formatCurrencyHelper.dart';
import 'package:adscoin/helper/functionalWidgetHelper.dart';
import 'package:adscoin/model/fintech/topUp/detailTopUpModel.dart';
import 'package:adscoin/service/provider/fintechProvider.dart';
import 'package:adscoin/view/widget/general/buttonWidget.dart';
import 'package:adscoin/view/widget/general/cardTitleAction.dart';
import 'package:adscoin/view/widget/general/imageRoundedWidget.dart';
import 'package:adscoin/view/widget/general/touchWidget.dart';
import 'package:adscoin/view/widget/general/uploadWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:getwidget/components/accordion/gf_accordion.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../successComponent.dart';

class DetailTopUpComponent extends StatefulWidget {
  @override
  _DetailTopUpComponentState createState() => _DetailTopUpComponentState();
}

class _DetailTopUpComponentState extends State<DetailTopUpComponent> with TickerProviderStateMixin  {
  AnimationController _controller;
  int levelClock = 86400;
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this,
        duration: Duration(seconds:levelClock)
    );
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    bool isTrue=false;
    ScreenScaler scale = ScreenScaler()..init(context);
    final fintech = Provider.of<FintechProvider>(context);
    final val = fintech.detailTopUpModel.result;
    return WillPopScope(
        child: Scaffold(
            appBar: FunctionalWidget.appBarWithFilterHelper(context: context,title: "Informasi pembayaran",callback:(){
              FunctionalWidget.backToHome(context);
            },action: <Widget>[
              IconButton(
                  onPressed: (){
                    fintech.refreshStatus(context: context);
                  },
                  icon: Icon(Icons.refresh,color: val.paymentType==0?ColorConfig.redColor:Colors.transparent,)
              )
            ]),
            body: ListView(
              // padding: scale.getPadding(1,2.5),
              children: [
                Image.asset( GeneralString.imgLocalPng+"paymentInfo.png",height:  scale.getHeight(20),),
                Container(
                    child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Jumlah yang harus dibayar",style: Theme.of(context).textTheme.headline2,textAlign: TextAlign.center,),
                        InTouchWidget(
                            callback: (){
                              FunctionalWidget.copy(context: context,text:MoneyFormat.toCurrency(double.parse(val.totalPay)) );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Rp "+MoneyFormat.toCurrency(double.parse(val.totalPay)),style: Theme.of(context).textTheme.headline2.copyWith(color: ColorConfig.bluePrimaryColor,fontWeight: FontWeight.bold,fontSize: scale.getTextSize(14))),
                                Icon(Icons.copy,size: scale.getTextSize(8))
                              ],
                            )
                        ),
                      ],
                    )
                ),
                Padding(
                  padding: scale.getPadding(1,2),
                  child: FunctionalWidget.wrapContent(
                      child: Padding(
                        padding: scale.getPadding(1,2),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(val.paymentType==0?"No virtual account":"No rekening",style: Theme.of(context).textTheme.subtitle1),
                            InTouchWidget(
                                callback: ()=>FunctionalWidget.copy(context: context,text:val.payCode),
                                child: Row(
                                  children: [
                                    Text(val.payCode,style: Theme.of(context).textTheme.headline2),
                                    Icon(Icons.copy,size: scale.getTextSize(8))
                                  ],
                                )
                            ),
                            if(val.paymentType==1)Divider(),
                            if(val.paymentType==1)Text("Nama bank",style: Theme.of(context).textTheme.subtitle1),
                            if(val.paymentType==1)Text(val.paymentName,style: Theme.of(context).textTheme.headline2),
                            Divider(),
                            Text("Jumlah coin",style: Theme.of(context).textTheme.subtitle1),
                            Text(MoneyFormat.toCurrency(double.parse(val.amount))+" coin",style: Theme.of(context).textTheme.headline2.copyWith(color: ColorConfig.bluePrimaryColor,fontWeight: FontWeight.bold)),
                          ],
                        ),
                      )
                  ),
                ),
                Padding(
                  padding: scale.getPadding(0.5,2),
                  child: Text("Cara pembayaran",style: Theme.of(context).textTheme.headline1),
                ),
                Container(
                  margin: scale.getMargin(0,2),
                  child: FunctionalWidget.wrapContent(
                      child: ListView.separated(
                        padding: scale.getPadding(0,0.0),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        physics: ScrollPhysics(),
                        itemCount: val.instruction.length,
                        itemBuilder: (context,index){
                          final resParent= val.instruction[index];
                          return GFAccordion(
                              contentBorderRadius: BorderRadius.only(bottomRight: Radius.circular(10),bottomLeft:Radius.circular(10)),
                              textStyle:Theme.of(context).textTheme.headline1,
                              collapsedTitleBackgroundColor:Colors.transparent,
                              contentBackgroundColor:Colors.transparent ,
                              expandedTitleBackgroundColor: ColorConfig.yellowColor,
                              collapsedIcon: Icon(Icons.arrow_drop_down),
                              expandedIcon:Icon(Icons.arrow_drop_up),
                              titlePadding: scale.getPaddingLTRB(2,0.5,2,0.5),
                              contentPadding: EdgeInsets.zero,
                              margin: EdgeInsets.zero,
                              titleChild: Text(resParent.title,style: Theme.of(context).textTheme.subtitle1.copyWith(color: isTrue?Colors.white:Colors.black),),
                              onToggleCollapsed: (isTrue){
                                setState(() {
                                  isTrue=isTrue;
                                });
                              },
                              contentChild: ListView.separated(
                                // padding: EdgeInsets.zero,
                                padding: scale.getPadding(1,2),
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                physics: ScrollPhysics(),
                                itemCount: resParent.steps.length,
                                itemBuilder: (c,i){
                                  final resChild=resParent.steps[i];
                                  return Html(
                                    data: resChild,
                                    style: {
                                      "body": Style(
                                        fontSize: FontSize(14.0),
                                        fontWeight: FontWeight.w400,
                                        margin: EdgeInsets.zero,
                                      ),
                                    },
                                    // defaultTextStyle: config.MyFont.style(context: context,color:Theme.of(context).textTheme.caption.color,style: Theme.of(context).textTheme.subtitle1,fontWeight: FontWeight.normal),
                                    onLinkTap: (String url){},
                                  );
                                },
                                separatorBuilder: (c,i){return Divider(color:Theme.of(context).textTheme.caption.color);},
                              )
                          );
                        },
                        separatorBuilder: (context,index){
                          return Divider();
                        },
                      )
                  ),
                ),
                SizedBox(height: scale.getHeight(1)),
                Container(
                    margin: scale.getMargin(0,2),
                    child: Container(
                      padding: scale.getPadding(1,2),
                      child: Column(
                        children: [
                          Text("Lakukan pembayaran sebelum tanggal ${FunctionalWidget.convertDateToDMY(val.expiredDate)}",style: Theme.of(context).textTheme.subtitle1,textAlign: TextAlign.center,),
                          if(val.paymentType==1)Text("mohon transfer tepat hingga 3 digit terakhir agar tidak menghambat proses verifikasi",style: Theme.of(context).textTheme.subtitle1,textAlign: TextAlign.center),
                          SizedBox(height: scale.getHeight(1)),
                          Countdown(animation: StepTween(begin: levelClock, end: 0).animate(_controller))
                        ],
                      ),
                    )
                ),
              ],
            ),
            bottomNavigationBar:Container(
              padding: scale.getPadding(1, 2.5),
              child:BackroundButtonWidget(
                backgroundColor: ColorConfig.redColor,
                color:ColorConfig.graySecondaryColor,
                title: val.paymentType==0?"Selesai":"Upload bukti transfer",
                callback: (){
                  if(val.paymentType==0){
                    FunctionalWidget.backToHome(context);
                  }else{
                    FunctionalWidget.modal(
                        context: context,
                        child: UploadWidget(
                          callback: (res){
                            print(res);
                            fintech.uploadBuktiTransfer(context: context,data: res["base64"]);
                          },
                          title: "Upload bukti transfer",
                        )
                    );
                  }
                },
              ),
            )
        ),
        onWillPop: (){
          FunctionalWidget.backToHome(context);
          return;
        }

    );
  }
}
// ignore: must_be_immutable
class Countdown extends AnimatedWidget {
  Countdown({Key key, this.animation}) : super(key: key, listenable: animation);
  Animation<int> animation;

  @override
  build(BuildContext context) {
    Duration clockTimer = Duration(seconds: animation.value);
    String timerText = '${clockTimer.inHours.remainder(60).toString()} : ${clockTimer.inMinutes.remainder(60).toString()} : ${clockTimer.inSeconds.remainder(60).toString().padLeft(2, '0')}';
    // return config.MyFont.title(context: context,text:"$timerText",fontSize: 12);
    return Text("$timerText",style: Theme.of(context).textTheme.headline1.copyWith(color: ColorConfig.yellowColor,fontSize: 24));
  }
}
