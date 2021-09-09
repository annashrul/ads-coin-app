// To parse this JSON data, do
//
//     final bankMemberModel = bankMemberModelFromJson(jsonString);

import 'dart:convert';

BankMemberModel bankMemberModelFromJson(String str) => BankMemberModel.fromJson(json.decode(str));

String bankMemberModelToJson(BankMemberModel data) => json.encode(data.toJson());

class BankMemberModel {
  BankMemberModel({
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

  factory BankMemberModel.fromJson(Map<String, dynamic> json) => BankMemberModel(
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
    this.idMember,
    this.fullname,
    this.idBank,
    this.bankName,
    this.bankLogo,
    this.accName,
    this.accNo,
    this.createdAt,
    this.updatedAt,
  });

  String totalrecords;
  String id;
  String idMember;
  String fullname;
  String idBank;
  String bankName;
  String bankLogo;
  String accName;
  String accNo;
  DateTime createdAt;
  DateTime updatedAt;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    totalrecords: json["totalrecords"],
    id: json["id"],
    idMember: json["id_member"],
    fullname: json["fullname"],
    idBank: json["id_bank"],
    bankName: json["bank_name"],
    bankLogo: json["bank_logo"],
    accName: json["acc_name"],
    accNo: json["acc_no"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "totalrecords": totalrecords,
    "id": id,
    "id_member": idMember,
    "fullname": fullname,
    "id_bank": idBank,
    "bank_name": bankName,
    "bank_logo": bankLogo,
    "acc_name": accName,
    "acc_no": accNo,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
