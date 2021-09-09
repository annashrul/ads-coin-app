import 'package:adscoin/config/string_config.dart';
import 'package:adscoin/helper/functionalWidgetHelper.dart';
import 'package:adscoin/service/provider/bankMemberProvider.dart';
import 'package:adscoin/service/provider/fintechProvider.dart';
import 'package:adscoin/view/component/fintech/methodChannel/methodChannelComponent.dart';
import 'package:adscoin/view/widget/fintech/formFintechWidget.dart';
import 'package:adscoin/view/widget/fintech/modalBankWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:provider/provider.dart';

class WithdrawComponent extends StatefulWidget {
  @override
  _WithdrawComponentState createState() => _WithdrawComponentState();
}

class _WithdrawComponentState extends State<WithdrawComponent> {


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
    final fintech = Provider.of<FintechProvider>(context);
    final bank = Provider.of<BankMemberProvider>(context);

    return Scaffold(
      appBar: FunctionalWidget.appBarHelper(context: context,title: "Penarikan"),
      body: FormFintechWidget(
        type: false,
        callback: (amount){
          if(amount<50000){
            FunctionalWidget.toast(context: context,msg: "top up minimal Rp 50,000");
          }
          else{
            print(bank.bankMemberModel);
            if(bank.bankMemberModel!=null){
              FunctionalWidget.modal(
                  context: context,
                  child: ModalBankWidget(callback: (id){
                    Navigator.of(context).pushNamed(RouteString.pin,arguments: (pin){
                      fintech.createWithDraw(context: context,data: {
                        "id_bank":id,
                        "amount":amount.toString(),
                        "member_pin":pin.toString()
                      });
                    });
                  })
              );
            }else{
              FunctionalWidget.nofitDialog(
                context: context,
                msg: "silahkan buat akun bank terlebih dahulu",
                callback2: (){
                  Navigator.of(context).pushNamed(RouteString.bankMember);
                }
              );
            }

          }
        },
      ),
    );
  }
}
