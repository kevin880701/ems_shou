
import 'BaseResponse.dart';

class SetGroupResponse extends BaseResponse<dynamic> {
  SetGroupResponse({required int result, required dynamic data})
      : super(result: result, data: data);

  factory SetGroupResponse.fromJson(Map<String, dynamic> json) {
    return SetGroupResponse(
      result: json['result'] ?? 0,
      data: json['data'] ?? {},
    );
  }
}