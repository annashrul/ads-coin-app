import 'package:adscoin/config/string_config.dart';
import 'package:adscoin/service/provider/bankMemberProvider.dart';
import 'package:adscoin/view/widget/general/cardAction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ModalActionBankMember extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bank = Provider.of<BankMemberProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        CardAction(
          title: "Edit",
          callback: ()async{
            bank.setIsAdd(false);
            Navigator.of(context).pushNamed(RouteString.formBankMember);
          },
          img: "Edit",
        ),
        CardAction(
          title: "Hapus",
          callback: ()async{
            bank.delete(context: context);
          },
          img: "Delete1",
        ),

      ],
    );
  }
}
