// To parse this JSON data, do
//
//     final detailProductModel = detailProductModelFromJson(jsonString);

import 'dart:convert';

DetailProductModel detailProductModelFromJson(String str) => DetailProductModel.fromJson(json.decode(str));

String detailProductModelToJson(DetailProductModel data) => json.encode(data.toJson());

class DetailProductModel {
  DetailProductModel({
    this.result,
    this.meta,
    this.total,
    this.msg,
    this.status,
  });

  Result result;
  List<dynamic> meta;
  List<dynamic> total;
  String msg;
  String status;

  factory DetailProductModel.fromJson(Map<String, dynamic> json) => DetailProductModel(
    result: Result.fromJson(json["result"]),
    meta: List<dynamic>.from(json["meta"].map((x) => x)),
    total: List<dynamic>.from(json["total"].map((x) => x)),
    msg: json["msg"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "result": result.toJson(),
    "meta": List<dynamic>.from(meta.map((x) => x)),
    "total": List<dynamic>.from(total.map((x) => x)),
    "msg": msg,
    "status": status,
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
    this.idSeller,
    this.status,
    this.idCategory,
    this.category,
    this.price,
    this.rating,
    this.terjual,
    this.image,
    this.createdAt,
    this.statusBeli,
  });

  String id;
  String title;
  String seller;
  String sellerFoto;
  String sellerBio;
  String content;
  String preview;
  String idSeller;
  int status;
  String idCategory;
  String category;
  String price;
  dynamic rating;
  String terjual;
  String image;
  DateTime createdAt;
  int statusBeli;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    title: json["title"],
    seller: json["seller"],
    sellerFoto: json["seller_foto"],
    sellerBio: json["seller_bio"],
    content: json["content"],
    preview: json["preview"],
    idSeller: json["id_seller"],
    status: json["status"],
    idCategory: json["id_category"],
    category: json["category"],
    price: json["price"],
    rating: json["rating"].toDouble(),
    terjual: json["terjual"],
    image: json["image"],
    createdAt: DateTime.parse(json["created_at"]),
    statusBeli: json["status_beli"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "seller": seller,
    "seller_foto": sellerFoto,
    "seller_bio": sellerBio,
    "content": content,
    "preview": preview,
    "id_seller": idSeller,
    "status": status,
    "id_category": idCategory,
    "category": category,
    "price": price,
    "rating": rating,
    "terjual": terjual,
    "image": image,
    "created_at": createdAt.toIso8601String(),
    "status_beli": statusBeli,
  };
}
