// To parse this JSON data, do
//
//     final detailMemberModel = detailMemberModelFromJson(jsonString);

import 'dart:convert';

DetailMemberModel detailMemberModelFromJson(String str) => DetailMemberModel.fromJson(json.decode(str));

String detailMemberModelToJson(DetailMemberModel data) => json.encode(data.toJson());

class DetailMemberModel {
  DetailMemberModel({
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

  factory DetailMemberModel.fromJson(Map<String, dynamic> json) => DetailMemberModel(
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
    this.fullname,
    this.mobileNo,
    this.saldo,
    this.totalPayment,
    this.referral,
    this.deviceId,
    this.signupSource,
    this.status,
    this.createdAt,
    this.bio,
    this.website,
    this.type,
    this.foto,
  });

  String id;
  String fullname;
  String mobileNo;
  String saldo;
  String totalPayment;
  String referral;
  String deviceId;
  String signupSource;
  int status;
  DateTime createdAt;
  String bio;
  String website;
  String type;
  String foto;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    fullname: json["fullname"],
    mobileNo: json["mobile_no"],
    saldo: json["saldo"],
    totalPayment: json["total_payment"],
    referral: json["referral"],
    deviceId: json["device_id"],
    signupSource: json["signup_source"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    bio: json["bio"],
    website: json["website"],
    type: json["type"],
    foto: json["foto"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "fullname": fullname,
    "mobile_no": mobileNo,
    "saldo": saldo,
    "total_payment": totalPayment,
    "referral": referral,
    "device_id": deviceId,
    "signup_source": signupSource,
    "status": status,
    "created_at": createdAt.toIso8601String(),
    "bio": bio,
    "website": website,
    "type": type,
    "foto": foto,
  };
}
