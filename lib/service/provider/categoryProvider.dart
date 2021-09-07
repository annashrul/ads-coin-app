import 'package:adscoin/model/category/categoryProductModel.dart';
import 'package:adscoin/service/httpService.dart';
import 'package:flutter/cupertino.dart';

class CategoryProvider with ChangeNotifier{
  CategoryProductModel categoryProductModel;
  bool isLoading=true;
  int indexSelectedCategoryForm=0;

  Future getCategoryProduct({BuildContext context})async{
    if(categoryProductModel==null) isLoading=true;
    final res = await HttpService().get(url: "category/product",context: context);
    CategoryProductModel result = CategoryProductModel.fromJson(res);
    categoryProductModel = result;
    isLoading=false;
    notifyListeners();
  }

  setIndexSelectedCategoryForm(input){
    indexSelectedCategoryForm=input;
    notifyListeners();
  }


}