// To parse this JSON data, do
//
//     final promoModel = promoModelFromJson(jsonString);

import 'dart:convert';

PromoModel promoModelFromJson(String str) => PromoModel.fromJson(json.decode(str));

String promoModelToJson(PromoModel data) => json.encode(data.toJson());

class PromoModel {
  PromoModel({
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

  factory PromoModel.fromJson(Map<String, dynamic> json) => PromoModel(
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
    this.deskripsi,
    this.image,
    this.type,
    this.nominal,
    this.kelipatan,
    this.periodeStart,
    this.periodeEnd,
    this.maxUserUses,
    this.maxUses,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  String id;
  String title;
  String deskripsi;
  String image;
  int type;
  String nominal;
  String kelipatan;
  DateTime periodeStart;
  DateTime periodeEnd;
  int maxUserUses;
  int maxUses;
  int status;
  DateTime createdAt;
  DateTime updatedAt;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    title: json["title"],
    deskripsi: json["deskripsi"],
    image: json["image"],
    type: json["type"],
    nominal: json["nominal"],
    kelipatan: json["kelipatan"],
    periodeStart: DateTime.parse(json["periode_start"]),
    periodeEnd: DateTime.parse(json["periode_end"]),
    maxUserUses: json["max_user_uses"],
    maxUses: json["max_uses"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "deskripsi": deskripsi,
    "image": image,
    "type": type,
    "nominal": nominal,
    "kelipatan": kelipatan,
    "periode_start": periodeStart.toIso8601String(),
    "periode_end": periodeEnd.toIso8601String(),
    "max_user_uses": maxUserUses,
    "max_uses": maxUses,
    "status": status,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
