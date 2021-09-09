// To parse this JSON data, do
//
//     final bankCompanyModel = bankCompanyModelFromJson(jsonString);

import 'dart:convert';

BankCompanyModel bankCompanyModelFromJson(String str) => BankCompanyModel.fromJson(json.decode(str));

String bankCompanyModelToJson(BankCompanyModel data) => json.encode(data.toJson());

class BankCompanyModel {
  BankCompanyModel({
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

  factory BankCompanyModel.fromJson(Map<String, dynamic> json) => BankCompanyModel(
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
    this.kode,
    this.idBank,
    this.name,
    this.code,
    this.logo,
    this.accName,
    this.accNo,
    this.status,
  });

  String totalrecords;
  String id;
  String kode;
  String idBank;
  String name;
  String code;
  String logo;
  String accName;
  String accNo;
  int status;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    totalrecords: json["totalrecords"],
    id: json["id"],
    kode: json["kode"],
    idBank: json["id_bank"],
    name: json["name"],
    code: json["code"],
    logo: json["logo"],
    accName: json["acc_name"],
    accNo: json["acc_no"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "totalrecords": totalrecords,
    "id": id,
    "kode": kode,
    "id_bank": idBank,
    "name": name,
    "code": code,
    "logo": logo,
    "acc_name": accName,
    "acc_no": accNo,
    "status": status,
  };
}
