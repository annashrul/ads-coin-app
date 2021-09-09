import 'package:adscoin/config/color_config.dart';
import 'package:adscoin/config/string_config.dart';
import 'package:adscoin/helper/functionalWidgetHelper.dart';
import 'package:adscoin/service/provider/bankMemberProvider.dart';
import 'package:adscoin/service/provider/siteProvider.dart';
import 'package:adscoin/view/component/site/allBankComponent.dart';
import 'package:adscoin/view/widget/general/buttonWidget.dart';
import 'package:adscoin/view/widget/general/fieldWidget.dart';
import 'package:adscoin/view/widget/general/imageRoundedWidget.dart';
import 'package:adscoin/view/widget/general/touchWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:provider/provider.dart';

class FormBankMemberComponent extends StatefulWidget {
  @override
  _FormBankMemberComponentState createState() => _FormBankMemberComponentState();
}

class _FormBankMemberComponentState extends State<FormBankMemberComponent> {
  TextEditingController accNameController = new TextEditingController();
  TextEditingController accNoController = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final site = Provider.of<SiteProvider>(context,listen:false);
    final bank = Provider.of<BankMemberProvider>(context,listen:false);
    site.getAllBank(context: context);
    if(!bank.isAdd){
      accNameController.text = bank.bankMemberModel.result[bank.indexBank].accName;
      accNoController.text = bank.bankMemberModel.result[bank.indexBank].accNo;
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenScaler scale = ScreenScaler()..init(context);
    final bank = Provider.of<BankMemberProvider>(context);
    final site = Provider.of<SiteProvider>(context);
    int indexAllBank = site.indexAllBank;

    return Scaffold(
      appBar: FunctionalWidget.appBarHelper(context: context,title:bank.isAdd? "Tambah bank":"Ubah bank"),
      body: Column(
        children: [
          Padding(
              padding: scale.getPadding(1,2),
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Atas nama",style: Theme.of(context).textTheme.subtitle1),
                  FieldWidget(
                    controller: accNameController,
                    maxLines: 1,
                    textInputAction: TextInputAction.done,
                  ),
                  SizedBox(height: scale.getHeight(1)),
                  Text("No.Rekening",style: Theme.of(context).textTheme.subtitle1),
                  FieldWidget(
                    controller: accNoController,
                    maxLines: 1,
                    textInputAction: TextInputAction.done,
                    textInputType: TextInputType.number,
                  ),
                  SizedBox(height: scale.getHeight(1)),
                  Text("Bank",style: Theme.of(context).textTheme.subtitle1),
                  InTouchWidget(
                    radius: 10,
                    callback: (){
                      FunctionalWidget.modal(
                          context: context,
                          child: Container(
                            height: scale.getHeight(90),
                            child: AllBankComponent(),
                          )
                      );
                    },
                    child: FunctionalWidget.wrapContent(
                      child: ListTile(
                        leading: ImageRoundedWidget(img:site.isLoadingAllBank?GeneralString.dummyImgUser:site.allBankModel.result[indexAllBank].logo,height: scale.getHeight(3),width: scale.getWidth(8),),
                        title: Text(site.isLoadingAllBank?"loading .....":site.allBankModel.result[indexAllBank].name,style: Theme.of(context).textTheme.headline2),
                        subtitle:Text( site.isLoadingAllBank?"loading .....":site.allBankModel.result[indexAllBank].code,style: Theme.of(context).textTheme.subtitle1),
                        trailing: Icon(FlutterIcons.ios_arrow_dropright_ion)
                      )
                    ),
                  ),
                  SizedBox(height: scale.getHeight(4)),
                  BackroundButtonWidget(
                    callback: (){
                      final data = {
                        "bank_name":"-",
                        "id":bank.isAdd?"":bank.bankMemberModel.result[bank.indexBank].id,
                        "id_bank":site.allBankModel.result[indexAllBank].id,
                        "acc_name":accNameController.text,
                        "acc_no":accNoController.text
                      };
                      bank.store(context: context,data: data);
                    },
                    color: ColorConfig.graySecondaryColor,
                    title: "Simpan",
                    backgroundColor:ColorConfig.redColor,
                  )
                ],
              )
          )
        ],
      ),
    );
  }
}




