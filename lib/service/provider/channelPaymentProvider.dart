import 'package:adscoin/model/fintech/channelPaymentModel.dart';
import 'package:adscoin/service/httpService.dart';
import 'package:flutter/cupertino.dart';

class ChannelPaymentProvider with ChangeNotifier{
  ChannelPaymentModel channelPaymentModel;
  bool isLoading=true;
  String codeChannelPayment="";

  setCodeChannelPayment(input){
    codeChannelPayment=input;
    notifyListeners();
  }

  Future get({BuildContext context})async{
    if(channelPaymentModel==null) isLoading=true;
    final res = await HttpService().get(url: "transaction/payment/channel",context: context);
    isLoading=false;
    if(res["result"].length>0){
      ChannelPaymentModel result = ChannelPaymentModel.fromJson(res);
      channelPaymentModel = result;
      notifyListeners();
    }
    else{
      channelPaymentModel = null;
    }
  }
}