import 'package:adscoin/config/color_config.dart';
import 'package:adscoin/config/string_config.dart';
import 'package:adscoin/helper/functionalWidgetHelper.dart';
import 'package:adscoin/service/provider/bankMemberProvider.dart';
import 'package:adscoin/view/component/loadingComponent.dart';
import 'package:adscoin/view/widget/general/imageRoundedWidget.dart';
import 'package:adscoin/view/widget/general/touchWidget.dart';
import 'package:adscoin/view/widget/member/bank/modalActionBank.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:provider/provider.dart';

class BankMemberComponent extends StatefulWidget {
  @override
  _BankMemberComponentState createState() => _BankMemberComponentState();
}

class _BankMemberComponentState extends State<BankMemberComponent> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final bank = Provider.of<BankMemberProvider>(context,listen:false);
    bank.get(context: context);
  }

  @override
  Widget build(BuildContext context) {
    final bank = Provider.of<BankMemberProvider>(context);
    ScreenScaler scale = ScreenScaler()..init(context);
    return Scaffold(
      appBar: FunctionalWidget.appBarHelper(context: context,title: "Daftar akun bank anda"),
      body: Column(
        children: [
          Padding(
            padding: scale.getPadding(1, 2.5),
            child: InTouchWidget(
                callback: ()async{
                  bank.setIsAdd(true);
                  Navigator.of(context).pushNamed(RouteString.formBankMember);
                },
                child: Row(
                  children: [
                    Image.asset(GeneralString.imgLocalPng+"PaperPlus.png",height: scale.getHeight(1.5),color:ColorConfig.bluePrimaryColor,),
                    SizedBox(width: scale.getWidth(1)),
                    Text("Tambah bank",style: Theme.of(context).textTheme.headline2.copyWith(color:ColorConfig.bluePrimaryColor))
                  ],
                )
            ),
          ),
          Expanded(
              child: bank.isLoading?LoadingBankMember():ListView.separated(
                  padding: scale.getPadding(0,2.5),
                  itemBuilder: (context,index){
                    final val = bank.bankMemberModel.result[index];
                    return InTouchWidget(
                        radius: 10,
                        callback: (){
                          bank.setIndexBank(index);
                          FunctionalWidget.modal(context: context,child: ModalActionBankMember());
                        },
                        child: FunctionalWidget.wrapContent(
                            child: ListTile(
                              leading: ImageRoundedWidget(
                                img: val.bankLogo,
                                height: scale.getHeight(3),
                                width: scale.getWidth(8),
                              ),
                              title: Text(val.accName,style: Theme.of(context).textTheme.headline2),
                              subtitle: Text(val.accNo,style: Theme.of(context).textTheme.subtitle1),
                              trailing: InTouchWidget(
                                  callback: (){},
                                  child: Icon(FlutterIcons.ios_more_ion)
                              ),
                            )
                        )
                    );
                  },
                  separatorBuilder: (context,index){return SizedBox(height: scale.getHeight(1));},
                  itemCount: bank.bankMemberModel.result.length
              )
          )
        ],
      ),
    );
  }
}
