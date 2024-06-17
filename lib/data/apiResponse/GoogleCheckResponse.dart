import 'dart:convert';

import 'BaseResponse.dart';

class GoogleCheckResponse extends BaseResponse<bool> {
  GoogleCheckResponse({required int result, required bool data}) : super(result: result, data: data);

  factory GoogleCheckResponse.fromJson(Map<String, dynamic> json) {

    return GoogleCheckResponse(
      result: json['result'] ?? 0,
      data: json['data'] ?? false,
    );
  }
}
