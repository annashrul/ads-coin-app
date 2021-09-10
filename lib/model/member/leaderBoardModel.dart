// To parse this JSON data, do
//
//     final leaderBoardModel = leaderBoardModelFromJson(jsonString);

import 'dart:convert';

LeaderBoardModel leaderBoardModelFromJson(String str) => LeaderBoardModel.fromJson(json.decode(str));

String leaderBoardModelToJson(LeaderBoardModel data) => json.encode(data.toJson());

class LeaderBoardModel {
  LeaderBoardModel({
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

  factory LeaderBoardModel.fromJson(Map<String, dynamic> json) => LeaderBoardModel(
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
    this.totalReferral,
    this.copyTerjual,
    this.rating,
    this.typeId,
    this.type,
    this.foto,
  });

  String totalrecords;
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
  String totalReferral;
  String copyTerjual;
  int rating;
  int typeId;
  String type;
  String foto;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    totalrecords: json["totalrecords"],
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
    totalReferral: json["total_referral"],
    copyTerjual: json["copy_terjual"],
    rating: json["rating"],
    typeId: json["type_id"],
    type: json["type"],
    foto: json["foto"],
  );

  Map<String, dynamic> toJson() => {
    "totalrecords": totalrecords,
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
    "total_referral": totalReferral,
    "copy_terjual": copyTerjual,
    "rating": rating,
    "type_id": typeId,
    "type": type,
    "foto": foto,
  };
}
