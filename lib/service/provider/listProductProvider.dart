import 'package:adscoin/model/product/listProductModel.dart';
import 'package:adscoin/service/httpService.dart';
import 'package:flutter/cupertino.dart';

class ListProductProvider with ChangeNotifier{
  ListProductModel listProductModel;
  bool isLoading=true;
  bool isLoadMore=false;
  int perPage=10;
  String idCategory="";

  filterCategory(BuildContext context,input){
    isLoading=true;
    idCategory=input;
    get(context: context);
    notifyListeners();
  }

  Future get({BuildContext context})async{
    if(listProductModel==null) isLoading=true;
    String url  =  "product?page=1&perpage=$perPage";
    if(idCategory!="") url+="&id_category=$idCategory";
    final res = await HttpService().get(url: url,context: context);
    isLoading=false;
    isLoadMore=false;
    if(res["result"].length>0){
      ListProductModel result = ListProductModel.fromJson(res);
      listProductModel = result;
      notifyListeners();
    }else{
      listProductModel = null;
    }
  }
  loadMoreContributor(BuildContext context){
    if(perPage<listProductModel.meta.total){
      isLoadMore=true;
      perPage+=10;
      get(context: context);
    }
    else{
      isLoadMore=false;
    }
    notifyListeners();
  }
}