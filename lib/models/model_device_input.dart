// To parse this JSON data, do
//
//     final modelDeviceInput = modelDeviceInputFromJson(jsonString);

import 'dart:convert';

List<ModelDeviceInput> modelDeviceInputFromJson(String str) => List<ModelDeviceInput>.from(json.decode(str).map((x) => ModelDeviceInput.fromJson(x)));

String modelDeviceInputToJson(List<ModelDeviceInput> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelDeviceInput {
  ModelDeviceInput({
    required this.guid,
    required this.mac,
    required this.type,
    required this.quantity,
    required this.name,
    required this.version,
    required this.minor,
    required this.status,
  });

  String guid;
  String mac;
  String type;
  String quantity;
  String name;
  String version;
  String minor;
  String status;

  factory ModelDeviceInput.fromJson(Map<String, dynamic> json) => ModelDeviceInput(
    guid: json["guid"],
    mac: json["mac"],
    type: json["type"],
    quantity: json["quantity"],
    name: json["name"],
    version: json["version"],
    minor: json["minor"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "guid": guid,
    "mac": mac,
    "type": type,
    "quantity": quantity,
    "name": name,
    "version": version,
    "minor": minor,
    "status": status,
  };
}
