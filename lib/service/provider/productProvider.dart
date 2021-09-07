import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:adscoin/config/string_config.dart';
import 'package:adscoin/database/databaseInit.dart';
import 'package:adscoin/database/table.dart';
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
  DatabaseInit db = new DatabaseInit();


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

  Future storeAutoSaveProduct({BuildContext context})async{
    final get = await db.getData(ProductTable.TABLE_NAME);
    if(get.length>0){
      File image;
      String fileName;
      String base64Image="-";
      print(get[0][TableString.imageProduct]);
      if(get[0][TableString.imageProduct]!="-"){
        image=File(get[0][TableString.imageProduct]);
        fileName = image.path.split("/").last;
        var type = fileName.split('.');
        base64Image = 'data:image/' + type[1] + ';base64,' + base64Encode(image.readAsBytesSync());
      }
      final data= {
        "title":get[0][TableString.titleProduct]==null?"-":get[0][TableString.titleProduct],
        "content":get[0][TableString.contentProduct]==null?"-":get[0][TableString.contentProduct],
        "preview":get[0][TableString.previewProduct]==null?"-":get[0][TableString.previewProduct],
        "id_category":get[0][TableString.idProduct]==null?"-":get[0][TableString.idProduct],
        "status":"0",
        "image":get[0][TableString.imageProduct]==null?"-":base64Image,

      };
      final res = await HttpService().post(url: "product",data: data,context: context,isLoading: false);
      if(res!=null){
        await db.delete(ProductTable.TABLE_NAME);
        print("SAVE PRODUCT TO SERVER $data");
      }
    }
  }

  Future autoSaveProduct(Map<String, Object> data)async{
    print("###################### autoSaveProduct = $data");
    final get = await db.getData(ProductTable.TABLE_NAME);
    // File image = File(get[0][TableString.imageProduct]);
    // String fileName;
    // String base64Image;
    // fileName = image.path.split("/").last;
    // var type = fileName.split('.');
    // base64Image = 'data:image/' + type[1] + ';base64,' + base64Encode(image.readAsBytesSync());
    // print("TO BASE 64 = $base64Image");
    if(get.length>0){
      final res= await db.update(ProductTable.TABLE_NAME,get[0]["id"],data);
      print("###################### UPDATE = $res");
      final gets = await db.getData(ProductTable.TABLE_NAME);
      print("###################### GET DATA = $gets");
    }
    else{
      final res = await db.insert(ProductTable.TABLE_NAME, data);
      print("###################### INSERT = $res");
    }
    // print("###################### GET DATA = $get");
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