// To parse this JSON data, do
//
//     final listReferralMember = listReferralMemberFromJson(jsonString);

import 'dart:convert';

ListReferralMember listReferralMemberFromJson(String str) => ListReferralMember.fromJson(json.decode(str));

String listReferralMemberToJson(ListReferralMember data) => json.encode(data.toJson());

class ListReferralMember {
  ListReferralMember({
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

  factory ListReferralMember.fromJson(Map<String, dynamic> json) => ListReferralMember(
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
    this.idKontributor,
    this.reffKontributor,
    this.kontributor,
    this.fotoKontributor,
    this.idMember,
    this.idNetwork,
    this.fullname,
    this.foto,
    this.referral,
    this.status,
    this.rewardCoin,
    this.idReward,
    this.produkReward,
    this.updatedAt,
  });

  String totalrecords;
  String id;
  String idKontributor;
  String reffKontributor;
  String kontributor;
  String fotoKontributor;
  String idMember;
  String idNetwork;
  String fullname;
  String foto;
  String referral;
  int status;
  String rewardCoin;
  dynamic idReward;
  String produkReward;
  DateTime updatedAt;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    totalrecords: json["totalrecords"],
    id: json["id"],
    idKontributor: json["id_kontributor"],
    reffKontributor: json["reff_kontributor"],
    kontributor: json["kontributor"],
    fotoKontributor: json["foto_kontributor"],
    idMember: json["id_member"],
    idNetwork: json["id_network"],
    fullname: json["fullname"],
    foto: json["foto"],
    referral: json["referral"],
    status: json["status"],
    rewardCoin: json["reward_coin"],
    idReward: json["id_reward"],
    produkReward: json["produk_reward"],
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "totalrecords": totalrecords,
    "id": id,
    "id_kontributor": idKontributor,
    "reff_kontributor": reffKontributor,
    "kontributor": kontributor,
    "foto_kontributor": fotoKontributor,
    "id_member": idMember,
    "id_network": idNetwork,
    "fullname": fullname,
    "foto": foto,
    "referral": referral,
    "status": status,
    "reward_coin": rewardCoin,
    "id_reward": idReward,
    "produk_reward": produkReward,
    "updated_at": updatedAt.toIso8601String(),
  };
}
