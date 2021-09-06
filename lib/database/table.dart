
import 'package:adscoin/config/string_config.dart';

class ProductTable {
  static const String TABLE_NAME = "product";
  static const String CREATE_TABLE = " CREATE TABLE IF NOT EXISTS $TABLE_NAME ( id INTEGER PRIMARY KEY AUTOINCREMENT, ${TableString.idProduct} TEXT,${TableString.titleProduct} TEXT, ${TableString.sellerProduct} TEXT, ${TableString.sellerFotoProduct} TEXT,${TableString.sellerBioProduct} TEXT,${TableString.contentProduct} TEXT,${TableString.previewProduct} TEXT,${TableString.idSellerProduct} TEXT,${TableString.statusProduct} TEXT,${TableString.priceProduct} TEXT,${TableString.ratingProduct} TEXT,${TableString.terjualProduct} TEXT,${TableString.statusBeliProduct} TEXT,${TableString.imageProduct} TEXT) ";
  static const String SELECT = "select * from $TABLE_NAME";
}

