import 'dart:convert';

class SimpleApiResult {
  SimpleApiResult(this.result);

  int result;

  bool isSuccess() => result == 0;

  factory SimpleApiResult.fromString(String source) {
    var json = jsonDecode(source);
    return SimpleApiResult(json['result'] as int);
  }

  factory SimpleApiResult.fromJson(Map<String, dynamic> json) {
    return SimpleApiResult(json['result'] as int);
  }


}