import 'package:flutter/cupertino.dart';

class ProductProvider with ChangeNotifier{
  bool isAdd = true;

  setIsAdd(input){
    isAdd=input;
    notifyListeners();
  }
}