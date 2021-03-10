import 'dart:convert';

import 'package:meyirim/models/project.dart';

Donation donationFromJson(String str) => Donation.fromJson(json.decode(str));

String donationToJson(Donation data) => json.encode(data.toJson());

class Donation {
  Donation({
    this.deviceCode,
    this.amount,
    this.dateCreated,
    this.id,
    this.amountNet,
    this.dateUpdated,
    this.referalDeviceCode,
    this.paymentId,
    this.paidAt,
    this.project,
  });

  String deviceCode;
  double amount;
  DateTime dateCreated;
  int id;
  double amountNet;
  DateTime dateUpdated;
  String referalDeviceCode;
  String paymentId;
  DateTime paidAt;
  Project project;

  factory Donation.fromJson(Map<String, dynamic> json) => Donation(
        deviceCode: json["device_code"],
        amount: double.parse(json["amount"]),
        dateCreated: DateTime.parse(json["date_created"]),
        id: json["id"],
        amountNet: double.parse(json["amount_net"]),
        dateUpdated: DateTime.parse(json["date_updated"]),
        referalDeviceCode: json["referal_device_code"],
        paymentId: json["payment_id"],
        paidAt: DateTime.parse(json["paid_at"]),
        project: Project.fromJson(json["project_id"]),
      );

  Map<String, dynamic> toJson() => {
        "device_code": deviceCode,
        "amount": amount,
        "date_created": dateCreated.toIso8601String(),
        "id": id,
        "amount_net": amountNet,
        "date_updated": dateUpdated.toIso8601String(),
        "referal_device_code": referalDeviceCode,
        "payment_id": paymentId,
        "paid_at": paidAt.toIso8601String(),
        "project_id": project.toJson(),
      };
}
