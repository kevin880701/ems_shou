
import 'dart:convert';

class LoginRequest {

  final String acc;
  final String pwd;

  LoginRequest({
    required this.acc,
    required this.pwd,
  });

  String toJson() {
    Map<String, dynamic> jsonMap = {
      'acc': acc,
      'pwd': pwd,
    };
    return jsonEncode(jsonMap);
  }

  @override
  String toString() {
    return jsonEncode(this);
  }
}