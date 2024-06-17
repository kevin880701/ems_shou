
import 'BaseResponse.dart';

class SetUserResponse extends BaseResponse<dynamic> {
  SetUserResponse({required int result, required dynamic data})
      : super(result: result, data: data);

  factory SetUserResponse.fromJson(Map<String, dynamic> json) {
    return SetUserResponse(
      result: json['result'] ?? 0,
      data: json['data'] ?? {},
    );
  }
}