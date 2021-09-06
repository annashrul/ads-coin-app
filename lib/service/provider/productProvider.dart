import 'package:adscoin/config/string_config.dart';
import 'package:adscoin/helper/functionalWidgetHelper.dart';
import 'package:adscoin/model/product/detailProductModel.dart';
import 'package:adscoin/model/product/productBestSellerModel.dart';
import 'package:adscoin/model/product/productLibraryModel.dart';
import 'package:adscoin/model/product/productNewModel.dart';
import 'package:adscoin/service/httpService.dart';
import 'package:flutter/cupertino.dart';

class ProductProvider with ChangeNotifier{
  bool isAdd = true,isLoadingNew=true,isLoadingBestSeller=true,isLoadingLibrary=true,isLoadMoreLibrary=false,isLoadingDetailProduct=true;
  ProductNewModel productNewModel;
  ProductBestSellerModel productBestSellerModel;
  ProductLibraryModel productLibraryModel;
  DetailProductModel detailProductModel;
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
  Future getDetailProduct({BuildContext context,String id=""})async{
    if(detailProductModel==null) isLoadingDetailProduct=true;
    final res = await HttpService().get(url: "product/get/$id",context: context);
    DetailProductModel result = DetailProductModel.fromJson(res);
    detailProductModel = result;
    isLoadingDetailProduct=false;
    notifyListeners();
  }

  Future storeCheckoutProduct({BuildContext context,String pin})async{
    dynamic data={
      "member_pin":pin.toString(),
      "id_product":detailProductModel.result.id
    };
    final res = await HttpService().post(url: "transaction/checkout",data: data,context: context);
    print(res);
    if(res!=null){
      Navigator.of(context).pushNamed(RouteString.detailCheckout);
    }
    // if()
  }
  Future storeRateProduct({BuildContext context,int rate})async{
    dynamic data={
      "rate":"$rate",
      "id_product":detailProductModel.result.id
    };
    final res = await HttpService().post(url: "review",data: data,context: context);
    if(res!=null){
      FunctionalWidget.nofitDialog(context: context,msg:"data berhasil disimpan",callback2: ()=>FunctionalWidget.backToHome(context));

    }
    // if()
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