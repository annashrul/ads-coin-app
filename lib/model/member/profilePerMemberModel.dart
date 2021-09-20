// To parse this JSON data, do
//
//     final profilePerMemberModel = profilePerMemberModelFromJson(jsonString);

import 'dart:convert';

ProfilePerMemberModel profilePerMemberModelFromJson(String str) => ProfilePerMemberModel.fromJson(json.decode(str));

String profilePerMemberModelToJson(ProfilePerMemberModel data) => json.encode(data.toJson());

class ProfilePerMemberModel {
  ProfilePerMemberModel({
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

  factory ProfilePerMemberModel.fromJson(Map<String, dynamic> json) => ProfilePerMemberModel(
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
    this.email,
    this.saldo,
    this.totalPayment,
    this.referral,
    this.deviceId,
    this.signupSource,
    this.status,
    this.createdAt,
    this.bio,
    this.website,
    this.totalReferral,
    this.copyTerjual,
    this.rating,
    this.idType,
    this.type,
    this.foto,
  });

  String id;
  String fullname;
  String mobileNo;
  String email;
  String saldo;
  String totalPayment;
  String referral;
  String deviceId;
  String signupSource;
  int status;
  DateTime createdAt;
  String bio;
  String website;
  String totalReferral;
  String copyTerjual;
  double rating;
  int idType;
  String type;
  String foto;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    fullname: json["fullname"],
    mobileNo: json["mobile_no"],
    email: json["email"],
    saldo: json["saldo"],
    totalPayment: json["total_payment"],
    referral: json["referral"],
    deviceId: json["device_id"],
    signupSource: json["signup_source"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    bio: json["bio"],
    website: json["website"],
    totalReferral: json["total_referral"],
    copyTerjual: json["copy_terjual"],
    rating: json["rating"].toDouble(),
    idType: json["id_type"],
    type: json["type"],
    foto: json["foto"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "fullname": fullname,
    "mobile_no": mobileNo,
    "email": email,
    "saldo": saldo,
    "total_payment": totalPayment,
    "referral": referral,
    "device_id": deviceId,
    "signup_source": signupSource,
    "status": status,
    "created_at": createdAt.toIso8601String(),
    "bio": bio,
    "website": website,
    "total_referral": totalReferral,
    "copy_terjual": copyTerjual,
    "rating": rating,
    "id_type": idType,
    "type": type,
    "foto": foto,
  };
}
