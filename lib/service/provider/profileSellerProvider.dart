import 'package:adscoin/model/member/profilePerMemberModel.dart';
import 'package:adscoin/model/product/productSellerModel.dart';
import 'package:adscoin/service/httpService.dart';
import 'package:flutter/cupertino.dart';

class ProfileSellerProvider with ChangeNotifier{
  ProfilePerMemberModel profilePerMemberModel;
  ProductSellerModel productSellerModel;
  bool isLoadingProduct=true,isLoadingProfile=true;
  Future getProfile({BuildContext context,String id})async{
    if(profilePerMemberModel==null) isLoadingProfile=true;
    final res = await HttpService().get(url: "member/get/$id",context: context);
    isLoadingProfile=false;
    ProfilePerMemberModel result=ProfilePerMemberModel.fromJson(res);
    profilePerMemberModel=result;
    notifyListeners();
  }
  Future getProduct({BuildContext context,String id})async{
    if(profilePerMemberModel==null) isLoadingProduct=true;
    final res = await HttpService().get(url: "product?page=1&id_seller=$id",context: context);
    if(res["result"].length>0){
      ProductSellerModel result=ProductSellerModel.fromJson(res);
      productSellerModel=result;
    }else{
      productSellerModel=null;
    }
    isLoadingProduct=false;

    notifyListeners();
  }

}