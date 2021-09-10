// To parse this JSON data, do
//
//     final historyMutationModel = historyMutationModelFromJson(jsonString);

import 'dart:convert';

HistoryMutationModel historyMutationModelFromJson(String str) => HistoryMutationModel.fromJson(json.decode(str));

String historyMutationModelToJson(HistoryMutationModel data) => json.encode(data.toJson());

class HistoryMutationModel {
  HistoryMutationModel({
    this.result,
    this.meta,
    this.total,
    this.msg,
    this.status,
  });

  List<Result> result;
  Meta meta;
  Total total;
  String msg;
  String status;

  factory HistoryMutationModel.fromJson(Map<String, dynamic> json) => HistoryMutationModel(
    result: List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
    meta: Meta.fromJson(json["meta"]),
    total: Total.fromJson(json["total"]),
    msg: json["msg"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "result": List<dynamic>.from(result.map((x) => x.toJson())),
    "meta": meta.toJson(),
    "total": total.toJson(),
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
    this.id,
    this.kdTrx,
    this.fullname,
    this.foto,
    this.type,
    this.trxIn,
    this.trxOut,
    this.note,
    this.createdAt,
    this.updatedAt,
  });

  String id;
  String kdTrx;
  String fullname;
  String foto;
  String type;
  String trxIn;
  String trxOut;
  String note;
  DateTime createdAt;
  DateTime updatedAt;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    kdTrx: json["kd_trx"],
    fullname: json["fullname"],
    foto: json["foto"],
    type: json["type"],
    trxIn: json["trx_in"],
    trxOut: json["trx_out"],
    note: json["note"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "kd_trx": kdTrx,
    "fullname": fullname,
    "foto": foto,
    "type": type,
    "trx_in": trxIn,
    "trx_out": trxOut,
    "note": note,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

class Total {
  Total({
    this.trxIn,
    this.trxOut,
    this.saldoAwal,
  });

  String trxIn;
  String trxOut;
  String saldoAwal;

  factory Total.fromJson(Map<String, dynamic> json) => Total(
    trxIn: json["trx_in"],
    trxOut: json["trx_out"],
    saldoAwal: json["saldo_awal"],
  );

  Map<String, dynamic> toJson() => {
    "trx_in": trxIn,
    "trx_out": trxOut,
    "saldo_awal": saldoAwal,
  };
}
