import 'package:adscoin/config/color_config.dart';
import 'package:adscoin/helper/functionalWidgetHelper.dart';
import 'package:adscoin/service/provider/bankMemberProvider.dart';
import 'package:adscoin/service/provider/siteProvider.dart';
import 'package:adscoin/view/component/site/allBankComponent.dart';
import 'package:adscoin/view/widget/general/buttonWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:provider/provider.dart';

class FormBankMemberComponent extends StatefulWidget {
  @override
  _FormBankMemberComponentState createState() =>
      _FormBankMemberComponentState();
}

class _FormBankMemberComponentState extends State<FormBankMemberComponent> {
  TextEditingController accNameController = new TextEditingController();
  TextEditingController accNoController = new TextEditingController();
  TextEditingController idBankController = new TextEditingController();
  TextEditingController nameBankController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    final site = Provider.of<SiteProvider>(context, listen: false);
    final bank = Provider.of<BankMemberProvider>(context, listen: false);
    site.getAllBank(context: context);
    if (!bank.isAdd) {
      accNameController.text =
          bank.bankMemberModel.result[bank.indexBank].accName;
      accNoController.text = bank.bankMemberModel.result[bank.indexBank].accNo;
      nameBankController.text =
          bank.bankMemberModel.result[bank.indexBank].bankName;
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenScaler scale = ScreenScaler()..init(context);
    final bank = Provider.of<BankMemberProvider>(context);
    final site = Provider.of<SiteProvider>(context);
    int indexAllBank = site.indexAllBank;
    if (indexAllBank != 10000) {
      nameBankController.text = site.isLoadingAllBank
          ? ""
          : site.allBankModel.result[indexAllBank].name;
    }
    return Scaffold(
      appBar: FunctionalWidget.appBarHelper(
          context: context,
          title: bank.isAdd ? "Tambah bank" : "Ubah bank",
          callback: () {
            Navigator.of(context).pop();
            bank.setIndexBank(10000);
          }),
      body: Column(
        children: [
          Padding(
              padding: scale.getPadding(1, 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  customField(
                      label: "Atas nama",
                      maxLength: 80,
                      controller: accNameController),
                  SizedBox(height: scale.getHeight(0.5)),
                  customField(
                      label: "No rekening",
                      maxLength: 20,
                      controller: accNoController,
                      textInputType: TextInputType.number),
                  SizedBox(height: scale.getHeight(0.5)),
                  customField(
                      readOnly: true,
                      label: "Bank",
                      controller: nameBankController,
                      textInputType: TextInputType.number,
                      onTap: () {
                        FunctionalWidget.modal(
                            context: context,
                            child: Container(
                              height: scale.getHeight(90),
                              child: AllBankComponent(),
                            ));
                      })

                  // Text("Atas nama",style: Theme.of(context).textTheme.subtitle1),
                  // FieldWidget(
                  //   controller: accNameController,
                  //   maxLines: 1,
                  //   textInputAction: TextInputAction.done,
                  // ),
                  // SizedBox(height: scale.getHeight(1)),
                  // Text("No.Rekening",style: Theme.of(context).textTheme.subtitle1),
                  // FieldWidget(
                  //   controller: accNoController,
                  //   maxLines: 1,
                  //   textInputAction: TextInputAction.done,
                  //   textInputType: TextInputType.number,
                  // ),
                  // SizedBox(height: scale.getHeight(1)),
                  // Text("Bank",style: Theme.of(context).textTheme.subtitle1),
                  // InTouchWidget(
                  //   radius: 10,
                  //   callback: (){
                  //     FunctionalWidget.modal(
                  //         context: context,
                  //         child: Container(
                  //           height: scale.getHeight(90),
                  //           child: AllBankComponent(),
                  //         )
                  //     );
                  //   },
                  //   child: FunctionalWidget.wrapContent(
                  //     child: ListTile(
                  //       leading: ImageRoundedWidget(img:site.isLoadingAllBank?GeneralString.dummyImgUser:site.allBankModel.result[indexAllBank].logo,height: scale.getHeight(3),width: scale.getWidth(8),),
                  //       title: Text(site.isLoadingAllBank?"loading .....":site.allBankModel.result[indexAllBank].name,style: Theme.of(context).textTheme.headline2),
                  //       subtitle:Text( site.isLoadingAllBank?"loading .....":site.allBankModel.result[indexAllBank].code,style: Theme.of(context).textTheme.subtitle1),
                  //       trailing: Icon(FlutterIcons.ios_arrow_dropright_ion)
                  //     )
                  //   ),
                  // ),
                  // SizedBox(height: scale.getHeight(4)),
                  // BackroundButtonWidget(
                  //   callback: (){
                  //     final data = {
                  //       "bank_name":"-",
                  //       "id":bank.isAdd?"":bank.bankMemberModel.result[bank.indexBank].id,
                  //       "id_bank":site.allBankModel.result[indexAllBank].id,
                  //       "acc_name":accNameController.text,
                  //       "acc_no":accNoController.text
                  //     };
                  //     bank.store(context: context,data: data);
                  //   },
                  //   color: ColorConfig.graySecondaryColor,
                  //   title: "Simpan",
                  //   backgroundColor:ColorConfig.redColor,
                  // )
                ],
              ))
        ],
      ),
      bottomNavigationBar: Container(
        padding: scale.getPadding(1, 2.5),
        child: BackroundButtonWidget(
          callback: () {
            final data = {
              "bank_name": "-",
              "id": bank.isAdd
                  ? ""
                  : bank.bankMemberModel.result[bank.indexBank].id,
              "id_bank": site.allBankModel.result[indexAllBank].id,
              "acc_name": accNameController.text,
              "acc_no": accNoController.text
            };
            bank.store(context: context, data: data);
          },
          color: ColorConfig.graySecondaryColor,
          title: "Simpan",
          backgroundColor: ColorConfig.redColor,
        ),
      ),
    );
  }

  Widget customField(
      {Function onTap,
      bool readOnly = false,
      String label,
      int maxLength,
      TextEditingController controller,
      TextInputType textInputType = TextInputType.text,
      TextCapitalization textCapitalization = TextCapitalization.words}) {
    ScreenScaler scale = ScreenScaler()..init(context);
    return Wrap(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "$label *",
              style: Theme.of(context).textTheme.subtitle1,
            ),
            if (maxLength != null)
              Text(
                "${controller.text.length}/$maxLength",
                style: Theme.of(context).textTheme.subtitle2,
              )
          ],
        ),
        Container(
          padding: scale.getPadding(0, 2),
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: ColorConfig.graySecondaryColor),
          child: TextFormField(
            onTap: () {
              if (onTap != null) onTap();
            },
            readOnly: readOnly,
            textCapitalization: textCapitalization,
            controller: controller,
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
            keyboardType: textInputType,
            inputFormatters: <TextInputFormatter>[
              LengthLimitingTextInputFormatter(maxLength),
              if (textInputType == TextInputType.number)
                FilteringTextInputFormatter.digitsOnly
            ],
            onChanged: (e) => this.setState(() {}),
          ),
        )
      ],
    );
  }
}
