import 'package:adscoin/model/member/profilePerMemberModel.dart';
import 'package:adscoin/model/product/productSellerModel.dart';
import 'package:adscoin/service/httpService.dart';
import 'package:flutter/cupertino.dart';

class ProfileSellerProvider with ChangeNotifier{
  ProfilePerMemberModel profilePerMemberModel;
  ProductSellerModel productSellerModel;
  bool isLoadingProduct=true,isLoadingProfile=true;
  bool isLoadMoreProduct=false;
  int perPageProduct=10;
  Future getProfile({BuildContext context,String id})async{
    isLoadingProfile=true;
    // if(profilePerMemberModel==null) isLoadingProfile=true;
    final res = await HttpService().get(url: "member/get/$id",context: context);
    isLoadingProfile=false;
    ProfilePerMemberModel result=ProfilePerMemberModel.fromJson(res);
    profilePerMemberModel=result;
    notifyListeners();
  }
  Future getProduct({BuildContext context,String id})async{
    // if(profilePerMemberModel==null) isLoadingProduct=true;
    if(!isLoadMoreProduct){
      isLoadingProduct=true;
    }
    final res = await HttpService().get(url: "product?page=1&id_seller=$id&perpage=$perPageProduct",context: context);
    if(res["result"].length>0){
      ProductSellerModel result=ProductSellerModel.fromJson(res);
      productSellerModel=result;
    }else{
      productSellerModel=null;
    }
    isLoadMoreProduct=false;
    isLoadingProduct=false;
    notifyListeners();
  }
  loadMoreContributor(BuildContext context,String id){
    if(perPageProduct<productSellerModel.meta.total){
      isLoadMoreProduct=true;
      perPageProduct+=10;
      getProduct(context: context,id: id);
    }
    else{
      isLoadMoreProduct=false;
    }
    notifyListeners();
  }
}