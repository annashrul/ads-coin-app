// To parse this JSON data, do
//
//     final generalModel = generalModelFromJson(jsonString);

import 'dart:convert';

GeneralModel generalModelFromJson(String str) => GeneralModel.fromJson(json.decode(str));

String generalModelToJson(GeneralModel data) => json.encode(data.toJson());

class GeneralModel {
  GeneralModel({
    this.result,
    this.meta,
    this.total,
    this.msg,
    this.status,
  });

  List<dynamic> result;
  List<dynamic> meta;
  List<dynamic> total;
  String msg;
  String status;

  factory GeneralModel.fromJson(Map<String, dynamic> json) => GeneralModel(
    result: List<dynamic>.from(json["result"].map((x) => x)),
    meta: List<dynamic>.from(json["meta"].map((x) => x)),
    total: List<dynamic>.from(json["total"].map((x) => x)),
    msg: json["msg"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "result": List<dynamic>.from(result.map((x) => x)),
    "meta": List<dynamic>.from(meta.map((x) => x)),
    "total": List<dynamic>.from(total.map((x) => x)),
    "msg": msg,
    "status": status,
  };
}
