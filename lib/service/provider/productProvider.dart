import 'package:adscoin/model/product/productBestSellerModel.dart';
import 'package:adscoin/model/product/productLibraryModel.dart';
import 'package:adscoin/model/product/productNewModel.dart';
import 'package:adscoin/service/httpService.dart';
import 'package:flutter/cupertino.dart';

class ProductProvider with ChangeNotifier{
  bool isAdd = true,isLoadingNew=true,isLoadingBestSeller=true,isLoadingLibrary=true,isLoadMoreLibrary=false;
  ProductNewModel productNewModel;
  ProductBestSellerModel productBestSellerModel;
  ProductLibraryModel productLibraryModel;
  int perPageLibrary=10;
  ScrollController controllerLibrary;


  setIsAdd(input){
    isAdd=input;
    notifyListeners();
  }
  Future getBestSeller({BuildContext context})async{
    if(productBestSellerModel==null) isLoadingBestSeller=true;
    final res = await HttpService().get(url: "product/list/best_seller?page=1",context: context);
    ProductBestSellerModel result = ProductBestSellerModel.fromJson(res);
    productBestSellerModel = result;
    isLoadingBestSeller=false;
    notifyListeners();
  }
  Future getNew({BuildContext context})async{
    if(productNewModel==null) isLoadingNew=true;
    final res = await HttpService().get(url: "product?page=1",context: context);
    ProductNewModel result = ProductNewModel.fromJson(res);
    productNewModel = result;
    isLoadingNew=false;
    notifyListeners();
  }
  Future getLibrary({BuildContext context,String type="home"})async{
    if(productLibraryModel==null) isLoadingLibrary=true;
    final res = await HttpService().get(url: "product/library?page=1",context: context);
    ProductLibraryModel result = ProductLibraryModel.fromJson(res);
    productLibraryModel = result;
    isLoadingLibrary=false;
    notifyListeners();
  }


  Future loadMoreLibrary(BuildContext context)async{
    if(perPageLibrary<productLibraryModel.meta.total){
      addListener(()=>isLoadMoreLibrary=true);
      perPageLibrary+=10;
      await getLibrary(context: context);
      isLoadMoreLibrary=false;
      notifyListeners();
    }else{
      addListener(()=>isLoadMoreLibrary=false);
      notifyListeners();
    }
  }
  void scrollListener({BuildContext context}) {
    if (!isLoadingLibrary) {
      if (controllerLibrary.position.pixels == controllerLibrary.position.maxScrollExtent) {
        loadMoreLibrary(context);
      }
    }
  }


}