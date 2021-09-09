// To parse this JSON data, do
//
//     final detailTopUpModel = detailTopUpModelFromJson(jsonString);

import 'dart:convert';

DetailTopUpModel detailTopUpModelFromJson(String str) => DetailTopUpModel.fromJson(json.decode(str));

String detailTopUpModelToJson(DetailTopUpModel data) => json.encode(data.toJson());

class DetailTopUpModel {
  DetailTopUpModel({
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

  factory DetailTopUpModel.fromJson(Map<String, dynamic> json) => DetailTopUpModel(
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
    this.invoiceNo,
    this.paymentMethod,
    this.paymentName,
    this.promo,
    this.amount,
    this.amountRupiah,
    this.admin,
    this.totalPay,
    this.kodeUnik,
    this.payCode,
    this.accName,
    this.expiredDate,
    this.paymentType,
    this.expiredTime,
    this.instruction,
  });

  var invoiceNo;
  var paymentMethod;
  var paymentName;
  var promo;
  var amount;
  var amountRupiah;
  var admin;
  var totalPay;
  var kodeUnik;
  var payCode;
  var accName;
  DateTime expiredDate;
  var paymentType;
  var expiredTime;
  Instruction instruction;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    invoiceNo: json["invoice_no"],
    paymentMethod: json["payment_method"],
    paymentName: json["payment_name"],
    promo: json["promo"],
    amount: json["amount"],
    amountRupiah: json["amount_rupiah"],
    admin: json["admin"],
    totalPay: json["total_pay"],
    kodeUnik: json["kode_unik"],
    payCode: json["pay_code"],
    accName: json["acc_name"],
    expiredDate: DateTime.parse(json["expired_date"]),
    paymentType: json["payment_type"],
    expiredTime: json["expired_time"],
    instruction: Instruction.fromJson(json["instruction"]),
  );

  Map<String, dynamic> toJson() => {
    "invoice_no": invoiceNo,
    "payment_method": paymentMethod,
    "payment_name": paymentName,
    "promo": promo,
    "amount": amount,
    "amount_rupiah": amountRupiah,
    "admin": admin,
    "total_pay": totalPay,
    "kode_unik": kodeUnik,
    "pay_code": payCode,
    "acc_name": accName,
    "expired_date": expiredDate.toIso8601String(),
    "payment_type": paymentType,
    "expired_time": expiredTime,
    "instruction": instruction.toJson(),
  };
}

class Instruction {
  Instruction({
    this.title,
    this.steps,
  });

  String title;
  List steps;

  factory Instruction.fromJson(Map<String, dynamic> json) => Instruction(
    title: json["title"],
    steps: List.from(json["steps"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "steps": List.from(steps.map((x) => x)),
  };
}
