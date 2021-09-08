
import 'package:adscoin/config/string_config.dart';
import 'package:adscoin/database/databaseInit.dart';
import 'package:adscoin/database/table.dart';
import 'package:adscoin/helper/functionalWidgetHelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FavoriteProvider with ChangeNotifier{
  DatabaseInit db = new DatabaseInit();
  List data = [];
  List detail = [];
  Future get()async{
    final res = await db.getData(FavoriteTable.TABLE_NAME);
    data = res;
    notifyListeners();
  }

  Future getDetail(String id)async{
    final res = await db.getDetail(FavoriteTable.TABLE_NAME, TableString.idProduct, id);
    res.where((element) => element[TableString.idProduct] == id).toList();
    detail = res.length>0?res:[];
    notifyListeners();
  }

  Future store({BuildContext context,dynamic resData})async{
    final data = {
      "checked":"1",
      TableString.idProduct : resData["id"],
      TableString.titleProduct : resData["title"],
      TableString.sellerProduct : resData["seller"],
      TableString.sellerFotoProduct : resData["seller_foto"],
      TableString.sellerBioProduct : resData["seller_bio"],
      TableString.contentProduct : resData["content"],
      TableString.previewProduct : resData["preview"],
      TableString.idSellerProduct : resData["id_seller"],
      TableString.statusProduct : resData["status"].toString(),
      TableString.priceProduct : resData["price"].toString(),
      TableString.ratingProduct : resData["rating"].toString(),
      TableString.terjualProduct : resData["terjual"].toString(),
      TableString.statusBeliProduct : resData["0"].toString(),
      TableString.imageProduct : resData["image"],
    };
    final detail = await db.getDetail(FavoriteTable.TABLE_NAME, TableString.idProduct, resData["id"]);
    print(detail);
    if(detail.length>0){
      detail.where((element) => element[TableString.idProduct] == resData["id"]).toList();
      await db.deleteById(FavoriteTable.TABLE_NAME, detail[0]["id"]);
      FunctionalWidget.toast(context: context,msg: "produk berhasil dihapus dari favorite anda");
      getDetail(resData["id"]);
    }
    else{
      final res = await db.insert(FavoriteTable.TABLE_NAME, data);
      if(res){
        FunctionalWidget.toast(context: context,msg: "produk berhasil dimasukan kedalam favorite anda");
        getDetail(resData["id"]);
      }else{
        FunctionalWidget.toast(context: context,msg: "data gagal disimpan");
      }
    }
    notifyListeners();
  }
}