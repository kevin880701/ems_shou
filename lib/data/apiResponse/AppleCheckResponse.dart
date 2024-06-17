import 'dart:convert';

import 'BaseResponse.dart';

class AppleCheckResponse extends BaseResponse<bool> {
  AppleCheckResponse({required int result, required bool data}) : super(result: result, data: data);

  factory AppleCheckResponse.fromJson(Map<String, dynamic> json) {

    return AppleCheckResponse(
      result: json['result'] ?? 0,
      data: json['data'] ?? false,
    );
  }
}
