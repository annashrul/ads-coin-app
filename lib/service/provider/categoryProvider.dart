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
    final res = await HttpService().get(url: "category/product",context: context);
    CategoryProductModel result = CategoryProductModel.fromJson(res);
    categoryProductModel = result;
    isLoading=false;
    if(isFilter)categoryProductModel.result.insert(0,Result(totalrecords: "0",id: "",title: "semua",idType: 0,icon: GeneralString.dummyImgUser,createdAt: null,updatedAt: null));

    notifyListeners();
  }
  setIndexSelectedCategoryForm(input){
    indexSelectedCategoryForm=input;
    notifyListeners();
  }

}