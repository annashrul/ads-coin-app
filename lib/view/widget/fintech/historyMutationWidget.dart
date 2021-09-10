import 'package:adscoin/config/color_config.dart';
import 'package:adscoin/config/string_config.dart';
import 'package:adscoin/helper/formatCurrencyHelper.dart';
import 'package:adscoin/view/widget/general/touchWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';

class HistoryMutationWidget extends StatelessWidget {
  final String note;
  final double trxIn;
  final double trxOut;
  final String image;
  final String status;
  HistoryMutationWidget({this.note,this.trxIn,this.trxOut,this.image,this.status});

  @override
  Widget build(BuildContext context) {
    ScreenScaler scale = ScreenScaler()..init(context);
    String nominal="+ ${MoneyFormat.toCurrency(trxIn)}";
    if(trxIn<1){
      nominal = "- ${MoneyFormat.toCurrency(trxOut)}";
    }

    return InTouchWidget(
        callback: (){},
        child: Padding(
          padding: scale.getPadding(1,2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.transparent,
                    backgroundImage: NetworkImage(GeneralString.dummyImgProduct),
                    radius: 25,
                  ),
                  SizedBox(width: scale.getWidth(1)),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(this.note,style: Theme.of(context).textTheme.headline2,),
                      Text(this.status,style: Theme.of(context).textTheme.subtitle1.copyWith(color: ColorConfig.yellowColor),),
                    ],
                  )
                ],
              ),
              Text(nominal,style: Theme.of(context).textTheme.subtitle1.copyWith(color: ColorConfig.blackPrimaryColor),),
            ],
          ),
        )
    );
  }
}
