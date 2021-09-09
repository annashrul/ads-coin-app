// To parse this JSON data, do
//
//     final channelPaymentModel = channelPaymentModelFromJson(jsonString);

import 'dart:convert';

ChannelPaymentModel channelPaymentModelFromJson(String str) => ChannelPaymentModel.fromJson(json.decode(str));

String channelPaymentModelToJson(ChannelPaymentModel data) => json.encode(data.toJson());

class ChannelPaymentModel {
  ChannelPaymentModel({
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

  factory ChannelPaymentModel.fromJson(Map<String, dynamic> json) => ChannelPaymentModel(
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
    this.group,
    this.code,
    this.name,
    this.type,
    this.logo,
    this.feeCustomer,
    this.active,
  });

  String group;
  String code;
  String name;
  String type;
  String logo;
  FeeCustomer feeCustomer;
  bool active;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    group: json["group"],
    code: json["code"],
    name: json["name"],
    type: json["type"],
    logo: json["logo"],
    feeCustomer: FeeCustomer.fromJson(json["fee_customer"]),
    active: json["active"],
  );

  Map<String, dynamic> toJson() => {
    "group": group,
    "code": code,
    "name": name,
    "type": type,
    "logo": logo,
    "fee_customer": feeCustomer.toJson(),
    "active": active,
  };
}

class FeeCustomer {
  FeeCustomer({
    this.flat,
    this.percent,
  });

  int flat;
  int percent;

  factory FeeCustomer.fromJson(Map<String, dynamic> json) => FeeCustomer(
    flat: json["flat"],
    percent: json["percent"],
  );

  Map<String, dynamic> toJson() => {
    "flat": flat,
    "percent": percent,
  };
}
