import 'package:adscoin/config/color_config.dart';
import 'package:adscoin/helper/formatCurrencyHelper.dart';
import 'package:adscoin/helper/functionalWidgetHelper.dart';
import 'package:adscoin/service/provider/siteProvider.dart';
import 'package:adscoin/service/provider/userProvider.dart';
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
  dynamic minWd;
  FormFintechWidget({this.callback,this.type=true,this.minWd});
  @override
  _FormFintechWidgetState createState() => _FormFintechWidgetState();
}

class _FormFintechWidgetState extends State<FormFintechWidget> {
  int idx=10;
  MoneyMaskedTextControllerQ amountController = MoneyMaskedTextControllerQ(initialValue:0.0,decimalSeparator: '', thousandSeparator: ',');


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    ScreenScaler scale = ScreenScaler()..init(context);
    final config = Provider.of<SiteProvider>(context);
    bool isValid = false;
    final user = Provider.of<UserProvider>(context);
    if(amountController.text!=""&&int.parse(amountController.text.replaceAll(",",""))>0){
      isValid=true;
    }
    return ListView(
      padding: scale.getPadding(1,2.5),
      children: [
        Text("Cara cepat",style: Theme.of(context).textTheme.headline2),
        SizedBox(height: scale.getHeight(1)),
        NominalWidget(
          callback: (amount,index){
            setState(() {
              amountController.text=amount;
              idx=index;
              isValid=true;
            });
          },
          idx: idx,
        ),
        if(!widget.type)FunctionalWidget.wrapContent(
            child: FlatButton(
              color:amountController.text==user.saldo?ColorConfig.yellowColor:Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
              ),
              padding: scale.getPadding(1,1),
              onPressed: (){
                print(double.parse(user.saldo.toString()));
                print(widget.minWd.toString());
                if(double.parse(user.saldo.toString()) < double.parse(widget.minWd.toString())){
                  FunctionalWidget.toast(context: context,msg: "maaf saldo anda kurang dari ${widget.minWd.toString()} coin");
                }else{
                  setState(() {
                    amountController.text=user.saldo;
                    isValid=true;
                  });
                }
              },
              child: Text("Tarik semua saldo anda : ${user.saldo} coin",style: Theme.of(context).textTheme.subtitle1.copyWith(color:ColorConfig.grayPrimaryColor),),
            )
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
                // WhitelistingTextInputFormatter.digitsOnly,
                // BlacklistingTextInputFormatter.singleLineFormatter,
              ],
              onChanged: (e){
                int index = 10;
                if(e!=""){
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
                }else{
                  index=10;
                  amountController = MoneyMaskedTextControllerQ(initialValue:0.0,decimalSeparator: '', thousandSeparator: ',');
                  this.setState(() {});
                }
              },
            ),
          )
        ),
        SizedBox(height: scale.getHeight(1)),
        Text("Total  Rp ${MoneyFormat.toFormat(double.parse(config.configModel.result[0].konversiCoin)*double.parse(amountController.text.replaceAll(",","")))}",style: Theme.of(context).textTheme.headline2),
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
