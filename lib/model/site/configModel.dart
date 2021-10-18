// To parse this JSON data, do
//
//     final configModel = configModelFromJson(jsonString);

import 'dart:convert';

ConfigModel configModelFromJson(String str) => ConfigModel.fromJson(json.decode(str));

String configModelToJson(ConfigModel data) => json.encode(data.toJson());

class ConfigModel {
  ConfigModel({
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

  factory ConfigModel.fromJson(Map<String, dynamic> json) => ConfigModel(
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
    this.providerOtp,
    this.otpMessage,
    this.aktivasiMessage,
    this.dpMin,
    this.wdMin,
    this.tfMin,
    this.chargeWd,
    this.chargeTf,
    this.trxDp,
    this.trxWd,
    this.konversiCoin,
    this.hargaCopy,
    this.komisiKontributor,
    this.komisiReferral,
    this.terms,
    this.privacy,
    this.disclaimer,
  });

  String providerOtp;
  String otpMessage;
  String aktivasiMessage;
  String dpMin;
  String wdMin;
  String tfMin;
  String chargeWd;
  String chargeTf;
  String trxDp;
  String trxWd;
  String konversiCoin;
  String hargaCopy;
  String komisiKontributor;
  String komisiReferral;
  String terms;
  String privacy;
  String disclaimer;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    providerOtp: json["provider_otp"],
    otpMessage: json["otp_message"],
    aktivasiMessage: json["aktivasi_message"],
    dpMin: json["dp_min"],
    wdMin: json["wd_min"],
    tfMin: json["tf_min"],
    chargeWd: json["charge_wd"],
    chargeTf: json["charge_tf"],
    trxDp: json["trx_dp"],
    trxWd: json["trx_wd"],
    konversiCoin: json["konversi_coin"],
    hargaCopy: json["harga_copy"],
    komisiKontributor: json["komisi_kontributor"],
    komisiReferral: json["komisi_referral"],
    terms: json["terms"],
    privacy: json["privacy"],
    disclaimer: json["disclaimer"],
  );

  Map<String, dynamic> toJson() => {
    "provider_otp": providerOtp,
    "otp_message": otpMessage,
    "aktivasi_message": aktivasiMessage,
    "dp_min": dpMin,
    "wd_min": wdMin,
    "tf_min": tfMin,
    "charge_wd": chargeWd,
    "charge_tf": chargeTf,
    "trx_dp": trxDp,
    "trx_wd": trxWd,
    "konversi_coin": konversiCoin,
    "harga_copy": hargaCopy,
    "komisi_kontributor": komisiKontributor,
    "komisi_referral": komisiReferral,
    "terms": terms,
    "privacy": privacy,
    "disclaimer": disclaimer,
  };
}
