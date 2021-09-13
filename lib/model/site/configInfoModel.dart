// To parse this JSON data, do
//
//     final configInfoModel = configInfoModelFromJson(jsonString);

import 'dart:convert';

ConfigInfoModel configInfoModelFromJson(String str) => ConfigInfoModel.fromJson(json.decode(str));

String configInfoModelToJson(ConfigInfoModel data) => json.encode(data.toJson());

class ConfigInfoModel {
  ConfigInfoModel({
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

  factory ConfigInfoModel.fromJson(Map<String, dynamic> json) => ConfigInfoModel(
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
    this.terms,
    this.privacy,
    this.disclaimer,
  });

  String terms;
  String privacy;
  String disclaimer;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    terms: json["terms"],
    privacy: json["privacy"],
    disclaimer: json["disclaimer"],
  );

  Map<String, dynamic> toJson() => {
    "terms": terms,
    "privacy": privacy,
    "disclaimer": disclaimer,
  };
}
