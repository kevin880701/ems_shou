import 'BaseResponse.dart';

class ChangeUserNameResponse extends BaseResponse<bool?> {
  ChangeUserNameResponse({required int result, required bool? data})
      : super(result: result, data: data);

  factory ChangeUserNameResponse.fromJson(Map<String, dynamic> json) {
    return ChangeUserNameResponse(
      result: json['result'] ?? 0,
      data: json['data'],
    );
  }
}
