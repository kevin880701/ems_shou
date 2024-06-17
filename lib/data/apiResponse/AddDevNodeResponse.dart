
import 'BaseResponse.dart';

class AddDevNodeResponse extends BaseResponse<AddDevNodeData> {
  AddDevNodeResponse({required int result, required AddDevNodeData data})
      : super(result: result, data: data);

  factory AddDevNodeResponse.fromJson(Map<String, dynamic> json) {
    return AddDevNodeResponse(
      result: json['result'] ?? 0,
      data: AddDevNodeData.fromJson(json['data'] ?? {}),
    );
  }
}

class AddDevNodeData {
  final String devId;

  AddDevNodeData({
    required this.devId,
  });

  factory AddDevNodeData.fromJson(Map<String, dynamic> json) {
    return AddDevNodeData(
      devId: json['devid'] ?? '',
    );
  }
}