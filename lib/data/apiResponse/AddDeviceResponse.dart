
import 'BaseResponse.dart';

class AddDeviceResponse extends BaseResponse<AddDeviceData> {
  AddDeviceResponse({required int result, required AddDeviceData data})
      : super(result: result, data: data);

  factory AddDeviceResponse.fromJson(Map<String, dynamic> json) {
    return AddDeviceResponse(
      result: json['result'] ?? 0,
      data: AddDeviceData.fromJson(json['data'] ?? {}),
    );
  }
}

class AddDeviceData {
  final String id;
  final String deviceid;

  AddDeviceData({
    required this.id,
    required this.deviceid,
  });

  factory AddDeviceData.fromJson(Map<String, dynamic> json) {
    return AddDeviceData(
      id: json['id'] ?? '',
      deviceid: json['deviceid'] ?? '',
    );
  }
}