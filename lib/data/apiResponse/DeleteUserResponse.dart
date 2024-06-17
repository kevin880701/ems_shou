
import 'BaseResponse.dart';

class DeleteUserResponse extends BaseResponse<bool> {
  DeleteUserResponse({required int result, required bool data})
      : super(result: result, data: data);

  factory DeleteUserResponse.fromJson(Map<String, dynamic> json) {
    return DeleteUserResponse(
      result: json['result'] ?? 0,
      data: json['data'] ?? false,
    );
  }
}