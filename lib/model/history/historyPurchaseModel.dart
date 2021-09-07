// To parse this JSON data, do
//
//     final historyPurchaseModel = historyPurchaseModelFromJson(jsonString);

import 'dart:convert';

HistoryPurchaseModel historyPurchaseModelFromJson(String str) => HistoryPurchaseModel.fromJson(json.decode(str));

String historyPurchaseModelToJson(HistoryPurchaseModel data) => json.encode(data.toJson());

class HistoryPurchaseModel {
  HistoryPurchaseModel({
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

  factory HistoryPurchaseModel.fromJson(Map<String, dynamic> json) => HistoryPurchaseModel(
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
    this.totalrecords,
    this.kdTrx,
    this.idMember,
    this.fullname,
    this.paymentChannel,
    this.biayaAdmin,
    this.grandTotal,
    this.status,
    this.idProduct,
    this.title,
    this.preview,
    this.imageProduct,
    this.seller,
    this.sellerFoto,
    this.sellerBio,
    this.createdAt,
    this.idSeller,
  });

  String totalrecords;
  String kdTrx;
  String idMember;
  String fullname;
  String paymentChannel;
  String biayaAdmin;
  String grandTotal;
  int status;
  String idProduct;
  String title;
  String preview;
  String imageProduct;
  String seller;
  String sellerFoto;
  String sellerBio;
  DateTime createdAt;
  String idSeller;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    totalrecords: json["totalrecords"],
    kdTrx: json["kd_trx"],
    idMember: json["id_member"],
    fullname: json["fullname"],
    paymentChannel: json["payment_channel"],
    biayaAdmin: json["biaya_admin"],
    grandTotal: json["grand_total"],
    status: json["status"],
    idProduct: json["id_product"],
    title: json["title"],
    preview: json["preview"],
    imageProduct: json["image_product"],
    seller: json["seller"],
    sellerFoto: json["seller_foto"],
    sellerBio: json["seller_bio"],
    createdAt: DateTime.parse(json["created_at"]),
    idSeller: json["id_seller"],
  );

  Map<String, dynamic> toJson() => {
    "totalrecords": totalrecords,
    "kd_trx": kdTrx,
    "id_member": idMember,
    "fullname": fullname,
    "payment_channel": paymentChannel,
    "biaya_admin": biayaAdmin,
    "grand_total": grandTotal,
    "status": status,
    "id_product": idProduct,
    "title": title,
    "preview": preview,
    "image_product": imageProduct,
    "seller": seller,
    "seller_foto": sellerFoto,
    "seller_bio": sellerBio,
    "created_at": createdAt.toIso8601String(),
    "id_seller": idSeller,
  };
}
