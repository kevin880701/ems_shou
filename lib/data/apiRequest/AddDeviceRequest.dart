
import 'dart:convert';

class AddDeviceRequest {

  final String devid;
  final String name;
  final int modelId;

  AddDeviceRequest({
    required this.devid,
    required this.name,
    required this.modelId,
  });


  String toJson() {
    Map<String, dynamic> jsonMap = {
      'devid': devid ?? "",
      'name': name ?? "",
      'modelId': modelId ?? "",
    };
    return jsonEncode(jsonMap);
  }
}