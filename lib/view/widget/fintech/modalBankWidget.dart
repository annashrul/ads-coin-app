import 'package:adscoin/config/string_config.dart';
import 'package:adscoin/service/provider/bankMemberProvider.dart';
import 'package:adscoin/service/provider/channelPaymentProvider.dart';
import 'package:adscoin/service/provider/siteProvider.dart';
import 'package:adscoin/view/component/loadingComponent.dart';
import 'package:adscoin/view/widget/general/cardTitleSubtileAction.dart';
import 'package:adscoin/view/widget/general/imageRoundedWidget.dart';
import 'package:adscoin/view/widget/general/titleSectionWidget.dart';
import 'package:adscoin/view/widget/general/touchWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ModalBankWidget extends StatefulWidget {
  Function(String idBank) callback;
  ModalBankWidget({this.callback});
  @override
  _ModalBankWidgetState createState() => _ModalBankWidgetState();
}

class _ModalBankWidgetState extends State<ModalBankWidget> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final bank = Provider.of<BankMemberProvider>(context,listen: false);
    bank.get(context: context);
  }

  @override
  Widget build(BuildContext context) {
    ScreenScaler scale = ScreenScaler()..init(context);
    final bank = Provider.of<BankMemberProvider>(context);
    return Padding(
      padding: scale.getPadding(1,2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          TitleSectionWidget(title: "Pilih bank", callback: (){},isAction: false),
          SizedBox(height: scale.getHeight(2)),
          ListView.separated(
              addRepaintBoundaries: true,
              primary: false,
              shrinkWrap: true,
              separatorBuilder: (context,index){return Divider();},
              itemCount: bank.isLoading?2:bank.bankMemberModel.result.length,
              itemBuilder: (context,index){
                return bank.isLoading?Container(
                  child: ListTile(
                    leading: BaseLoading(height: 4,width: 8,radius: 100),
                  ),
                ):CardTitleSubtitleAction(
                  image: bank.bankMemberModel.result[index].bankLogo,
                  title:bank.bankMemberModel.result[index].accName,
                  subtitle: bank.bankMemberModel.result[index].accNo,
                  callback: (){
                    widget.callback(bank.bankMemberModel.result[index].id);
                  },
                );
              },
          )
        ],
      ),
    );
  }
}
