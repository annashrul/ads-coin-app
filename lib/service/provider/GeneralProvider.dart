import 'package:flutter/cupertino.dart';

class GeneralProvider with ChangeNotifier{
  bool conditionCheckoutAndDetail = true;
  bool conditionFilterProductContributor = true;
  bool conditionStatusProductContributor = true; //draft or done
  setConditionCheckoutAndDetail(input){
    conditionCheckoutAndDetail=input;
    notifyListeners();
  }
  setConditionFilterProductContributor(input){
    conditionFilterProductContributor=input;
    notifyListeners();
  }
  setConditionStatusProductContributor(input){
    conditionStatusProductContributor=input;
    notifyListeners();
  }




}