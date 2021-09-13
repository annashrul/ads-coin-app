import 'package:adscoin/helper/formatCurrencyHelper.dart';
import 'package:adscoin/helper/functionalWidgetHelper.dart';
import 'package:adscoin/service/provider/promoProvider.dart';
import 'package:adscoin/view/widget/general/imageRoundedWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DetailPromoComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final promo = Provider.of<PromoProvider>(context);
    ScreenScaler scale= ScreenScaler()..init(context);

    return Scaffold(
      appBar: FunctionalWidget.appBarHelper(context: context,title: "Detail promo"),
      body: ListView(
        padding: scale.getPadding(0,2),
        children: [
          ImageRoundedWidget(
            img: promo.promoModel.result.image,
            height: scale.getHeight(30),
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          SizedBox(height: scale.getHeight(1)),
          Text(promo.promoModel.result.title,style: Theme.of(context).textTheme.headline1,),
          Text(promo.promoModel.result.deskripsi,style: Theme.of(context).textTheme.headline2,),

        ],
      ),
      bottomNavigationBar: Container(
        padding: scale.getPadding(1,2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            FunctionalWidget.spaceText(context: context,title: "mulai dari",desc: FunctionalWidget.convertDateToDMY(promo.promoModel.result.periodeStart),width: 40),
            FunctionalWidget.spaceText(context: context,title: "sampai dengan",desc:FunctionalWidget.convertDateToDMY(promo.promoModel.result.periodeEnd),width: 40),
            FunctionalWidget.spaceText(context: context,title: "Maksimal pemakaian",desc:promo.promoModel.result.maxUserUses.toString()+" kali",width: 40),
            if(promo.promoModel.result.type==0)FunctionalWidget.spaceText(context: context,title: "Minimal deposit",desc:promo.promoModel.result.kelipatan,width: 40),
            if(promo.promoModel.result.type==0)FunctionalWidget.spaceText(context: context,title: "bonus",desc:FunctionalWidget.toCoin(double.parse(promo.promoModel.result.nominal)),width: 40),
            if(promo.promoModel.result.type==1)FunctionalWidget.spaceText(context: context,title: "Konversi",desc:"Rp "+MoneyFormat.toFormat(double.parse(promo.promoModel.result.nominal)),width: 40),

          ],
        ),
      ),
    );
  }
}
