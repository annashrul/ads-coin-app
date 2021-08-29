// To parse this JSON data, do
//
//     final signInModel = signInModelFromJson(jsonString);

import 'dart:convert';

SignInModel signInModelFromJson(String str) => SignInModel.fromJson(json.decode(str));

String signInModelToJson(SignInModel data) => json.encode(data.toJson());

class SignInModel {
  SignInModel({
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

  factory SignInModel.fromJson(Map<String, dynamic> json) => SignInModel(
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
    this.token,
    this.havePin,
    this.foto,
    this.fullname,
    this.mobileNo,
    this.referral,
    this.status,
    this.createdAt,
  });

  String id;
  String token;
  bool havePin;
  String foto;
  String fullname;
  String mobileNo;
  String referral;
  int status;
  DateTime createdAt;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    token: json["token"],
    havePin: json["havePin"],
    foto: json["foto"],
    fullname: json["fullname"],
    mobileNo: json["mobile_no"],
    referral: json["referral"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "token": token,
    "havePin": havePin,
    "foto": foto,
    "fullname": fullname,
    "mobile_no": mobileNo,
    "referral": referral,
    "status": status,
    "created_at": createdAt.toIso8601String(),
  };
}
