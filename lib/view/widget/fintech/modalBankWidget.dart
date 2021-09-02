import 'package:adscoin/config/string_config.dart';
import 'package:adscoin/view/widget/general/cardTitleSubtileAction.dart';
import 'package:adscoin/view/widget/general/imageRoundedWidget.dart';
import 'package:adscoin/view/widget/general/titleSectionWidget.dart';
import 'package:adscoin/view/widget/general/touchWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';

// ignore: must_be_immutable
class ModalBankWidget extends StatefulWidget {
  Function(int index) callback;
  @override
  _ModalBankWidgetState createState() => _ModalBankWidgetState();
}

class _ModalBankWidgetState extends State<ModalBankWidget> {
  @override
  Widget build(BuildContext context) {
    ScreenScaler scale = ScreenScaler()..init(context);
    return Padding(
      padding: scale.getPadding(1,2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          TitleSectionWidget(title: "Pilih metode pembayaran", callback: (){},isAction: false),
          SizedBox(height: scale.getHeight(2)),
          ListView.separated(
              addRepaintBoundaries: true,
              primary: false,
              shrinkWrap: true,
              itemBuilder: (context,index){
                return CardTitleSubtitleAction(
                  image: GeneralString.dummyImgProduct,
                  title: "Bank mandiri",
                  subtitle: "Ads coin",
                  callback: (){
                    Navigator.of(context).pushNamed(RouteString.confirmWithdraw);
                  },
                );

              },
              separatorBuilder: (context,index){return Divider();},
              itemCount: 2
          )
        ],
      ),
    );
  }
}
