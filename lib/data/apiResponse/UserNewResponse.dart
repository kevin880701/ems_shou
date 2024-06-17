
import 'BaseResponse.dart';

class UserNewResponse extends BaseResponse<dynamic> {
  UserNewResponse({required int result, required dynamic data})
      : super(result: result, data: data);

  factory UserNewResponse.fromJson(Map<String, dynamic> json) {
    return UserNewResponse(
      result: json['result'] ?? 0,
      data: json['data'] ?? {},
    );
  }
}