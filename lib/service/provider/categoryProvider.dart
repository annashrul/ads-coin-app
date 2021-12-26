import 'package:adscoin/config/string_config.dart';
import 'package:adscoin/model/category/categoryProductModel.dart';
import 'package:adscoin/service/httpService.dart';
import 'package:flutter/cupertino.dart';

class CategoryProvider with ChangeNotifier{
  CategoryProductModel categoryProductModel;
  bool isLoading=true;
  int indexSelectedCategoryForm=0;

  Future getCategoryProduct({BuildContext context,bool isFilter=false})async{
    if(categoryProductModel==null) isLoading=true;
    final res = await HttpService().get(url: "category/product?page=1&perpage=10000",context: context);
    if(res["result"].length>0){
      CategoryProductModel result = CategoryProductModel.fromJson(res);
      categoryProductModel = result;
      if(isFilter)categoryProductModel.result.insert(0,Result(totalrecords: "0",id: "",title: "semua",idType: 0,icon: "https://admin.adscoin.id/static/media/logo.828d2c16.png",createdAt: null,updatedAt: null));

    }else{
      categoryProductModel=null;
    }

    isLoading=false;

    notifyListeners();
  }
  setIndexSelectedCategoryForm(input){
    indexSelectedCategoryForm=input;
    notifyListeners();
  }

}