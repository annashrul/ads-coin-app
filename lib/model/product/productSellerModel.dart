// To parse this JSON data, do
//
//     final productSellerModel = productSellerModelFromJson(jsonString);

import 'dart:convert';

ProductSellerModel productSellerModelFromJson(String str) => ProductSellerModel.fromJson(json.decode(str));

String productSellerModelToJson(ProductSellerModel data) => json.encode(data.toJson());

class ProductSellerModel {
  ProductSellerModel({
    this.result,
    this.meta,
    this.total,
    this.msg,
    this.status,
  });

  List<Result> result;
  Meta meta;
  List<dynamic> total;
  String msg;
  String status;

  factory ProductSellerModel.fromJson(Map<String, dynamic> json) => ProductSellerModel(
    result: List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
    meta: Meta.fromJson(json["meta"]),
    total: List<dynamic>.from(json["total"].map((x) => x)),
    msg: json["msg"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "result": List<dynamic>.from(result.map((x) => x.toJson())),
    "meta": meta.toJson(),
    "total": List<dynamic>.from(total.map((x) => x)),
    "msg": msg,
    "status": status,
  };
}

class Meta {
  Meta({
    this.total,
    this.perPage,
    this.offset,
    this.to,
    this.lastPage,
    this.currentPage,
    this.from,
  });

  int total;
  int perPage;
  int offset;
  int to;
  int lastPage;
  int currentPage;
  int from;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    total: json["total"],
    perPage: json["per_page"],
    offset: json["offset"],
    to: json["to"],
    lastPage: json["last_page"],
    currentPage: json["current_page"],
    from: json["from"],
  );

  Map<String, dynamic> toJson() => {
    "total": total,
    "per_page": perPage,
    "offset": offset,
    "to": to,
    "last_page": lastPage,
    "current_page": currentPage,
    "from": from,
  };
}

class Result {
  Result({
    this.id,
    this.title,
    this.seller,
    this.sellerFoto,
    this.sellerBio,
    this.content,
    this.preview,
    this.idCategory,
    this.category,
    this.idSeller,
    this.status,
    this.price,
    this.rating,
    this.terjual,
    this.statusBeli,
    this.image,
    this.createdAt,
    this.isFavorite="0",
  });

  String id;
  String title;
  String seller;
  String sellerFoto;
  String sellerBio;
  String content;
  String preview;
  String idCategory;
  String category;
  String idSeller;
  int status;
  String price;
  dynamic rating;
  String terjual;
  int statusBeli;
  String image;
  DateTime createdAt;
  String isFavorite;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    title: json["title"],
    seller: json["seller"],
    sellerFoto: json["seller_foto"],
    sellerBio: json["seller_bio"],
    content: json["content"],
    preview: json["preview"],
    idCategory: json["id_category"],
    category: json["category"],
    idSeller: json["id_seller"],
    status: json["status"],
    price: json["price"],
    rating: json["rating"],
    terjual: json["terjual"],
    statusBeli: json["status_beli"],
    image: json["image"],
    isFavorite: "0",
    createdAt: DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "seller": seller,
    "seller_foto": sellerFoto,
    "seller_bio": sellerBio,
    "content": content,
    "preview": preview,
    "id_category": idCategory,
    "category": category,
    "id_seller": idSeller,
    "status": status,
    "price": price,
    "rating": rating,
    "terjual": terjual,
    "status_beli": statusBeli,
    "image": image,
    "isFavorite": isFavorite,
    "created_at": createdAt.toIso8601String(),
  };
}
