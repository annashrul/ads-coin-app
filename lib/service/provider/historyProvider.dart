import 'package:adscoin/model/history/detailHistoryPurchaseModel.dart';
import 'package:adscoin/model/history/historyPurchaseModel.dart';
import 'package:adscoin/service/httpService.dart';
import 'package:flutter/cupertino.dart';

class HistoryProvider with ChangeNotifier{
  bool isLoading=true, isLoadingDetailPurchase=true;
  HistoryPurchaseModel historyPurchaseModel;
  DetailHistoryPurchaseModel detailHistoryPurchaseModel;

  Future getHistoryPurchase({BuildContext context,String where})async{
    if(historyPurchaseModel==null) isLoading=true;
    final res = await HttpService().get(url: "transaction/report/pembelian",context: context);
    HistoryPurchaseModel result = HistoryPurchaseModel.fromJson(res);
    historyPurchaseModel = result;
    print(res);
    isLoading=false;
    notifyListeners();
  }
  Future getDetailHistoryPurchase({BuildContext context,String id})async{
    if(detailHistoryPurchaseModel==null) isLoadingDetailPurchase=true;
    final res = await HttpService().get(url: "transaction/report/detail/$id",context: context);
    DetailHistoryPurchaseModel result = DetailHistoryPurchaseModel.fromJson(res);
    detailHistoryPurchaseModel = result;
    print(res);
    isLoadingDetailPurchase=false;
    notifyListeners();
  }


}