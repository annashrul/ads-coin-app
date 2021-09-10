import 'package:adscoin/helper/functionalWidgetHelper.dart';
import 'package:adscoin/model/history/detailHistoryPurchaseModel.dart';
import 'package:adscoin/model/history/detailHistorySaleModel.dart';
import 'package:adscoin/model/history/historyMutationModel.dart';
import 'package:adscoin/model/history/historyPurchaseModel.dart';
import 'package:adscoin/model/history/historySaleModel.dart';
import 'package:adscoin/service/httpService.dart';
import 'package:flutter/cupertino.dart';

class HistoryProvider with ChangeNotifier{
  bool isLoadingHistoryPurchase=true, isLoadingHistoryMutation=true,isLoadingHistorySale=true;
  bool isLoadMoreHistoryPurchase=false,isLoadMoreHistoryMutation=false,isLoadMoreHistorySale=false;
  bool isLoadingDetailHistoryPurchase=true,isLoadingDetailHistorySale=false;
  int perPageHistoryPurchase=10,perPageHistoryMutation=10,perPageHistorySale=10;
  DateTime fromHistoryPurchase=DateTime.now(),toHistoryPurchase=DateTime.now();
  DateTime fromHistoryMutation=DateTime.now(),toHistoryMutation=DateTime.now();
  DateTime fromHistorySale=DateTime.now(),toHistorySale=DateTime.now();
  HistoryPurchaseModel historyPurchaseModel;
  DetailHistoryPurchaseModel detailHistoryPurchaseModel;
  DetailHistorySaleModel detailHistorySaleModel;
  HistoryMutationModel historyMutationModel;
  HistorySaleModel historySaleModel;


  /* ###################################################### PURCHASE ############################################### */
  Future getHistoryPurchase({BuildContext context})async{
    if(historyPurchaseModel==null) isLoadingHistoryPurchase=true;
    final res = await HttpService().get(url: "transaction/report/pembelian?page=1&perpage=$perPageHistoryPurchase&datefrom=${FunctionalWidget.convertDateToYMD(fromHistoryPurchase)}&dateto=${FunctionalWidget.convertDateToYMD(toHistoryPurchase)}",context: context);
    isLoadingHistoryPurchase=false;
    isLoadMoreHistoryPurchase=false;
    if(res["result"].length>0){
      HistoryPurchaseModel result = HistoryPurchaseModel.fromJson(res);
      historyPurchaseModel = result;
    }else{
      historyPurchaseModel=null;
    }
    notifyListeners();
  }
  Future getDetailHistoryPurchase({BuildContext context,String id})async{
    if(detailHistoryPurchaseModel==null) isLoadingDetailHistoryPurchase=true;
    final res = await HttpService().get(url: "transaction/report/detail/$id",context: context);
    DetailHistoryPurchaseModel result = DetailHistoryPurchaseModel.fromJson(res);
    detailHistoryPurchaseModel = result;
    isLoadingDetailHistoryPurchase=false;
    notifyListeners();
  }
  loadMoreHistoryPurchase(BuildContext context){
    if(perPageHistoryPurchase<historyPurchaseModel.meta.total){
      isLoadMoreHistoryPurchase=true;
      perPageHistoryPurchase+=10;
      getHistoryPurchase(context: context);
    }
    else{
      isLoadMoreHistoryPurchase=false;
    }
    notifyListeners();
  }
  setDateFromDateToHistoryPurchase({BuildContext context, input}){
    fromHistoryPurchase = input["from"];
    toHistoryPurchase = input["to"];
    getHistoryPurchase(context: context);
    notifyListeners();
  }

  /* ###################################################### MUTATION ############################################### */
  Future getHistoryMutation({BuildContext context,bool isNow=false})async{
    int perPageNow=10;
    String url="transaction/history?page=1";
    if(isNow||historyMutationModel==null) isLoadingHistoryMutation=true;
    if(isNow){
      url+="&perpage=$perPageNow";
    }else{
      url+="&perpage=$perPageHistoryMutation&datefrom=${FunctionalWidget.convertDateToYMD(fromHistoryMutation)}&dateto=${FunctionalWidget.convertDateToYMD(toHistoryMutation)}";
    }
    final res = await HttpService().get(url: url,context: context);
    isLoadingHistoryMutation=false;
    isLoadMoreHistoryMutation=false;
    if(res["result"].length>0){
      HistoryMutationModel result = HistoryMutationModel.fromJson(res);
      historyMutationModel = result;
    }else{
      historyMutationModel=null;
    }
    notifyListeners();
  }
  loadMoreHistoryMutation(BuildContext context){
    if(perPageHistoryMutation<historyMutationModel.meta.total){
      isLoadMoreHistoryMutation=true;
      perPageHistoryMutation+=10;
      getHistoryMutation(context: context);
    }
    else{
      isLoadMoreHistoryMutation=false;
    }
    notifyListeners();
  }
  setDateFromDateToHistoryMutation({BuildContext context, input}){
    fromHistoryMutation = input["from"];
    toHistoryMutation = input["to"];
    getHistoryMutation(context: context);
    notifyListeners();
  }

  /* ###################################################### SALE ############################################### */
  Future getHistorySale({BuildContext context})async{
    if(historySaleModel==null) isLoadingHistorySale=true;
    final res = await HttpService().get(url: "transaction/report/penjualan?page=1&perpage=$perPageHistorySale&datefrom=${FunctionalWidget.convertDateToYMD(fromHistorySale)}&dateto=${FunctionalWidget.convertDateToYMD(toHistorySale)}",context: context);
    isLoadingHistorySale=false;
    isLoadMoreHistorySale=false;
    if(res["result"].length>0){
      HistorySaleModel result = HistorySaleModel.fromJson(res);
      historySaleModel = result;
    }else{
      historySaleModel=null;
    }
    notifyListeners();
  }
  Future getDetailHistorySale({BuildContext context,String id})async{
    if(detailHistorySaleModel==null) isLoadingDetailHistorySale=true;
    final res = await HttpService().get(url: "transaction/report/detail/$id",context: context);
    DetailHistorySaleModel result = DetailHistorySaleModel.fromJson(res);
    detailHistorySaleModel = result;
    isLoadingDetailHistorySale=false;
    notifyListeners();
  }
  loadMoreHistorySale(BuildContext context){
    if(perPageHistorySale<historySaleModel.meta.total){
      isLoadMoreHistorySale=true;
      perPageHistorySale+=10;
      getHistorySale(context: context);
    }
    else{
      isLoadMoreHistorySale=false;
    }
    notifyListeners();
  }
  setDateFromDateToHistorySale({BuildContext context, input}){
    fromHistorySale = input["from"];
    toHistorySale = input["to"];
    getHistorySale(context: context);
    notifyListeners();
  }

}