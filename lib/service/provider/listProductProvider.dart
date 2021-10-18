import 'package:adscoin/model/product/listProductModel.dart';
import 'package:adscoin/model/product/productSearchModel.dart';
import 'package:adscoin/service/httpService.dart';
import 'package:flutter/cupertino.dart';

class ListProductProvider with ChangeNotifier{
  ListProductModel listProductModel;
  ProductSearchModel productSearchModel;
  bool isLoading=true,isLoadingProductSearch=true;
  bool isLoadMore=false,isLoadMoreProductSearch=false;
  int perPage=10,perPageSearchProduct=10;
  String anySearchProduct="";
  String idCategory="";
  String q="";
  setQ({BuildContext context,input}){
    isLoading=true;
    q=input;
    get(context: context);
    notifyListeners();
  }
  setAnySearchProduct({BuildContext context,input}){
    anySearchProduct=input;
    getSearchProduct(context: context);
    notifyListeners();
  }
  filterCategory(BuildContext context,input){
    isLoading=true;
    idCategory=input;
    get(context: context);
    notifyListeners();
  }
  Future getSearchProduct({BuildContext context})async{
    if(productSearchModel==null) isLoadingProductSearch=true;
    String url  =  "product?page=1&perpage=$perPageSearchProduct";
    if(anySearchProduct!="") url+="&q=$anySearchProduct";
    final res = await HttpService().get(url: url,context: context);
    isLoadingProductSearch=false;
    isLoadMoreProductSearch=false;
    if(res["result"].length>0){
      ProductSearchModel result = ProductSearchModel.fromJson(res);
      productSearchModel = result;
      notifyListeners();
    }else{
      productSearchModel = null;
      notifyListeners();

    }
  }
  Future get({BuildContext context})async{
    if(listProductModel==null) isLoading=true;
    String url  =  "product?page=1&perpage=$perPage";
    if(idCategory!="") url+="&id_category=$idCategory";
    if(q!="") url+="&q=$q";
    final res = await HttpService().get(url: url,context: context);
    isLoading=false;
    isLoadMore=false;
    print(res["result"].length);
    if(res["result"].length>0){
      ListProductModel result = ListProductModel.fromJson(res);
      listProductModel = result;
      notifyListeners();
    }else{
      listProductModel = null;
      notifyListeners();

    }
  }
  loadMoreProduct(BuildContext context){
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
  loadMoreSearchProduct(BuildContext context){
    if(perPageSearchProduct<productSearchModel.meta.total){
      isLoadMoreProductSearch=true;
      perPageSearchProduct+=10;
      getSearchProduct(context: context);
    }
    else{
      isLoadMoreProductSearch=false;
    }
    notifyListeners();
  }
}