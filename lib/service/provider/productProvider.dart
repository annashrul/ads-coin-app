import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:adscoin/config/string_config.dart';
import 'package:adscoin/database/databaseInit.dart';
import 'package:adscoin/database/table.dart';
import 'package:adscoin/helper/functionalWidgetHelper.dart';
import 'package:adscoin/model/generalModel.dart';
import 'package:adscoin/model/product/detailProductModel.dart';
import 'package:adscoin/model/product/productBestSellerModel.dart';
import 'package:adscoin/model/product/productContributorModel.dart';
import 'package:adscoin/model/product/productLibraryModel.dart';
import 'package:adscoin/model/product/productNewModel.dart';
import 'package:adscoin/service/httpService.dart';
import 'package:adscoin/service/provider/categoryProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class ProductProvider with ChangeNotifier{
  bool isNoDataProductContributor=false;
  bool isAdd =true,isLoadingNew=true,isLoadingBestSeller=true,isLoadingLibrary=true,isLoadMoreLibrary=false,isLoadingDetailProduct=true;
  bool isLoadingProductContributor=true,isLoadMoreProductContributor=false;
  ProductNewModel productNewModel;
  ProductBestSellerModel productBestSellerModel;
  ProductLibraryModel productLibraryModel;
  ProductContributorModel productContributorModel;
  DetailProductModel detailProductModel;
  int perPageLibrary=10;
  int perPageProductContributor=10;
  ScrollController controllerLibrary;
  ScrollController controllerProductContributor;
  DatabaseInit db = new DatabaseInit();
  int statusProduct=0;
  int filterStatusProduct=0;
  String anyProductContributor="",anyProductLibrary="";

  setAnyProductContributor(BuildContext context,input){
    anyProductContributor=input;
    isLoadingProductContributor=true;
    getProductContributor(context: context);
    notifyListeners();
  }
  setAnyProductLibrary(BuildContext context,input){
    anyProductLibrary=input;
    isLoadingLibrary=true;
    getLibrary(context: context);
    notifyListeners();
  }

  dynamic dataEditProductContributor;
  setStatusProduct(input){
    statusProduct=input;
    notifyListeners();
  }
  setFilterStatusProductContributor({BuildContext context,input}){
    filterStatusProduct=input;
    getProductContributor(context: context);
    notifyListeners();
  }
  setIsAdd(input){
    isAdd=input;
    notifyListeners();
  }
  setDataEditProductContributor(input){
    dataEditProductContributor = input;
    notifyListeners();
  }
  Future getProductContributor({BuildContext context})async{
    if(productContributorModel==null) isLoadingProductContributor=true;
    String url = "product/list/crud?page=1&perpage=$perPageProductContributor&status=$filterStatusProduct";
    if(anyProductContributor!="") url+="&q=$anyProductContributor";
    final res = await HttpService().get(url: url,context: context);
    isLoadingProductContributor=false;
    isLoadMoreProductContributor=false;
    if(res["result"].length>0){
      ProductContributorModel result = ProductContributorModel.fromJson(res);
      productContributorModel = result;
      notifyListeners();
    }else{
      productContributorModel=null;
      notifyListeners();
    }
  }
  Future getBestSeller({BuildContext context})async{
    if(productBestSellerModel==null) isLoadingBestSeller=true;
    final res = await HttpService().get(url: "product/list/best_seller?page=1",context: context);
    ProductBestSellerModel result = ProductBestSellerModel.fromJson(res);
    productBestSellerModel = result;
    isLoadingBestSeller=false;
    notifyListeners();
  }
  Future getNew({BuildContext context,String where=""})async{
    if(productNewModel==null) isLoadingNew=true;
    String url  =  "product?page=1";
    if(where!="") url+="&$where";
    final res = await HttpService().get(url: url,context: context);
    ProductNewModel result = ProductNewModel.fromJson(res);
    productNewModel = result;
    isLoadingNew=false;
    notifyListeners();
  }
  Future getLibrary({BuildContext context,String type="home"})async{
    if(productLibraryModel==null) isLoadingLibrary=true;
    String url = "product/library?page=1";
    if(anyProductLibrary!="") url+="&q=$anyProductLibrary";
    final res = await HttpService().get(url:url,context: context);
    if(res["result"].length>0){
      ProductLibraryModel result = ProductLibraryModel.fromJson(res);
      productLibraryModel = result;
    }else{
      productLibraryModel=null;
    }

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
  Future storeAutoSaveProduct({BuildContext context,String status,loading=false})async{
    final get = await db.getData(ProductTable.TABLE_NAME);
    if(get.length>0){
      File image;
      String fileName;
      String base64Image="-";
      if(get[0][TableString.imageProduct]!="-"){
        image=File(get[0][TableString.imageProduct]);
        fileName = image.path.split("/").last;
        var type = fileName.split('.');
        base64Image = 'data:image/' + type[1] + ';base64,' + base64Encode(image.readAsBytesSync());
      }
      final category = Provider.of<CategoryProvider>(context, listen: false);
      final data= {
        "title":get[0][TableString.titleProduct]==null?"-":get[0][TableString.titleProduct],
        "content":get[0][TableString.contentProduct],
        "preview":get[0][TableString.previewProduct]==null?"-":get[0][TableString.previewProduct],
        "id_category":get[0][TableString.idProduct]==null?category.categoryProductModel.result[category.indexSelectedCategoryForm].id:get[0][TableString.idProduct],
        "status":status,
        "image":base64Image,
      };
      print("################### DATA = $data");
      dynamic res;
      if(isAdd){
        res = await HttpService().post(url: "product",data: data,context: context,isLoading: loading);
      }else{
        res = await HttpService().put(url: "product/${dataEditProductContributor["id"]}",data: data,context: context,isLoading: loading);
      }
      getProductContributor(context: context);
      await db.delete(ProductTable.TABLE_NAME);

      if(res!=null){
        if(loading){
          FunctionalWidget.nofitDialog(context: context,msg:"Data berhasil disimpan",callback2: ()=>Navigator.of(context).pushReplacementNamed(RouteString.productContributor));
        }
      }
    }
  }
  Future updateToDraft({BuildContext context})async{
    FunctionalWidget.nofitDialog(
        context: context,
        msg: "Anda yakin akan mengubah status produk ini ?",
        callback1: ()=>Navigator.of(context).pop(),
        callback2: ()async{
          Navigator.of(context).pop();
          await HttpService().put(url: "product/${dataEditProductContributor["id"]}",data: {"status":"0"},context: context);
          Navigator.of(context).pop();
          getProductContributor(context: context);
          FunctionalWidget.toast(context: context,msg: "produk berhasil disimpan ke draft");
          notifyListeners();
          // print("RESPONSE $res");
        }
    );

  }
  Future deleteProductContributor({BuildContext context, String id})async{
    FunctionalWidget.nofitDialog(
        context: context,
        msg: "Anda yakin akan menghapus data ini ?",
        callback1: ()=>Navigator.of(context).pop(),
        callback2: ()async{
          Navigator.of(context).pop();
          final res = await HttpService().delete(url: "product/$id",context: context);
          Navigator.of(context).pop();
          getProductContributor(context: context);
          FunctionalWidget.toast(context: context,msg: "data berhasil dihapus");
          notifyListeners();
          // print("RESPONSE $res");
        }
    );

  }
  loadMoreContributor(BuildContext context){
    if(perPageProductContributor<productContributorModel.meta.total){
      isLoadMoreProductContributor=true;
      perPageProductContributor+=10;
      getProductContributor(context: context);
    }
    else{
      isLoadingProductContributor=false;
    }
    notifyListeners();
  }

  int timeCounter = 0;
  bool timeUpFlag = false;
  Timer timer;
  timerUpdate() {
    timer = Timer(const Duration(seconds: 1), () async {
      timeCounter--;
      if (timeCounter != 0){
        timerUpdate();
        notifyListeners();
      }
      else{
        timeCounter=0;
        timeUpFlag = true;
        timer.cancel();
        notifyListeners();
      }
    });
  }
  void setTimer(input){
    timeCounter=input;
    // timerUpdate();
    timeUpFlag=!timeUpFlag;
    notifyListeners();
  }
}