
import 'dart:convert';

class UserNewRequest {
  final String name;
  final String acc;
  final String pwd;

  UserNewRequest({
    required this.name,
    required this.acc,
    required this.pwd,
  });

  String toJson() {
    Map<String, dynamic> jsonMap = {
      'name': name,
      'acc': acc,
      'pwd': pwd,
    };
    return jsonEncode(jsonMap);
  }
}
