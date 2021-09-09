// To parse this JSON data, do
//
//     final allBankModel = allBankModelFromJson(jsonString);

import 'dart:convert';

AllBankModel allBankModelFromJson(String str) => AllBankModel.fromJson(json.decode(str));

String allBankModelToJson(AllBankModel data) => json.encode(data.toJson());

class AllBankModel {
  AllBankModel({
    this.result,
    this.meta,
    this.total,
    this.msg,
    this.status,
  });

  List<Result> result;
  List<dynamic> meta;
  List<dynamic> total;
  String msg;
  String status;

  factory AllBankModel.fromJson(Map<String, dynamic> json) => AllBankModel(
    result: List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
    meta: List<dynamic>.from(json["meta"].map((x) => x)),
    total: List<dynamic>.from(json["total"].map((x) => x)),
    msg: json["msg"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "result": List<dynamic>.from(result.map((x) => x.toJson())),
    "meta": List<dynamic>.from(meta.map((x) => x)),
    "total": List<dynamic>.from(total.map((x) => x)),
    "msg": msg,
    "status": status,
  };
}

class Result {
  Result({
    this.id,
    this.name,
    this.code,
    this.logo,
  });

  String id;
  String name;
  String code;
  String logo;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    name: json["name"],
    code: json["code"],
    logo: json["logo"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "code": code,
    "logo": logo,
  };
}
