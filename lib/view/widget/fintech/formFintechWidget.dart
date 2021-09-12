import 'package:adscoin/config/color_config.dart';
import 'package:adscoin/helper/formatCurrencyHelper.dart';
import 'package:adscoin/helper/functionalWidgetHelper.dart';
import 'package:adscoin/service/provider/siteProvider.dart';
import 'package:adscoin/view/component/loadingComponent.dart';
import 'package:adscoin/view/widget/fintech/nominalWidget.dart';
import 'package:adscoin/view/widget/general/buttonWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:provider/provider.dart';

class FormFintechWidget extends StatefulWidget {
  Function(int amount) callback;
  bool type;
  FormFintechWidget({this.callback,this.type=true});
  @override
  _FormFintechWidgetState createState() => _FormFintechWidgetState();
}

class _FormFintechWidgetState extends State<FormFintechWidget> {
  int idx=10;
  MoneyMaskedTextControllerQ amountController = new MoneyMaskedTextControllerQ();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    amountController = MoneyMaskedTextControllerQ(decimalSeparator: '', thousandSeparator: ',');
    final config = Provider.of<SiteProvider>(context,listen: false);
    config.getConfig(context: context);
  }

  @override
  Widget build(BuildContext context) {
    ScreenScaler scale = ScreenScaler()..init(context);
    bool isValid = false;
    if(amountController.text!=""&&int.parse(amountController.text.replaceAll(",",""))>0){
      isValid=true;
    }
    final config = Provider.of<SiteProvider>(context);
    return ListView(
      padding: scale.getPadding(1,2.5),
      children: [
        Text("Cara cepat",style: Theme.of(context).textTheme.headline2),
        SizedBox(height: scale.getHeight(1)),
        NominalWidget(
          callback: (amount,index){
            print(amount);
            setState(() {
              amountController.text=amount;
              idx=index;
              isValid=true;
            });
          },
          idx: idx,
        ),
        SizedBox(height: scale.getHeight(1)),
        Text("Jumlah coin",style: Theme.of(context).textTheme.headline2),
        SizedBox(height: scale.getHeight(1)),
        FunctionalWidget.wrapContent(
          child: Container(
            padding: scale.getPadding(0, 2),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10)
            ),
            child: TextFormField(
              controller: amountController,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
              inputFormatters: <TextInputFormatter>[
                WhitelistingTextInputFormatter.digitsOnly,
                BlacklistingTextInputFormatter.singleLineFormatter,
              ],
              onChanged: (e){
                int amount;
                for(int i=0;i<MoneyFormat.dataNominal.length;i++){
                  if(MoneyFormat.dataNominal[i]==e){
                    amount=i;
                    break;
                  }
                  continue;
                }
                idx = amount!=null?amount:10;

                setState(() {});
              },
            ),
          )
        ),
        SizedBox(height: scale.getHeight(1)),
        Text("Konversi coin > rupiah",style: Theme.of(context).textTheme.headline2),
        SizedBox(height: scale.getHeight(1)),
        FunctionalWidget.wrapContent(
          child: Padding(
            padding: scale.getPadding(1,2),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                config.isLoadingConfig?BaseLoading(height: 1, width:10):Text("1 coin = Rp ${MoneyFormat.toFormat(double.parse(config.configModel.result[0].konversiCoin))}",style: Theme.of(context).textTheme.subtitle1,),
                SizedBox(height: scale.getHeight(0.5)),
                config.isLoadingConfig?BaseLoading(height: 1, width:20):Text("Total  = ${amountController.text} coin x Rp ${MoneyFormat.toFormat(double.parse(config.configModel.result[0].konversiCoin))} =  Rp ${MoneyFormat.toFormat(double.parse(config.configModel.result[0].konversiCoin)*double.parse(amountController.text))}",style: Theme.of(context).textTheme.subtitle1,),
              ],
            ),
          )
        ),
        SizedBox(height: scale.getHeight(2)),
        BackroundButtonWidget(
          backgroundColor: isValid?ColorConfig.redColor:ColorConfig.graySecondaryColor,
          color: isValid?ColorConfig.graySecondaryColor:ColorConfig.grayPrimaryColor,
          title: widget.type?"Pilih metode top up":"Lanjut",
          callback: (){
            if(isValid){
              int amountToInt = int.parse(amountController.text.replaceAll(",",""));
              if(amountToInt<1){
                FunctionalWidget.toast(context: context,msg: "nominal tidak boleh kosong");
              }else{
                widget.callback(amountToInt);
              }
            }
          },
        ),
      ],
    );
  }
}
