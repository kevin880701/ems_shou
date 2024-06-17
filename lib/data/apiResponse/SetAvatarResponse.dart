
import 'BaseResponse.dart';

class SetAvatarResponse extends BaseResponse<dynamic> {
  SetAvatarResponse({required int result, required dynamic data})
      : super(result: result, data: data);

  factory SetAvatarResponse.fromJson(Map<String, dynamic> json) {
    return SetAvatarResponse(
      result: json['result'] ?? 0,
      data: json['data'] ?? {},
    );
  }
}