
import 'dart:convert';

class AppleLoginRequest {

  final String account;
  final String name;
  final String aUid;

  AppleLoginRequest({
    required this.account,
    required this.name,
    required this.aUid,
  });

  String toJson() {
    Map<String, dynamic> jsonMap = {
      'account': account,
      'name': name,
      'aUid': aUid,
    };
    return jsonEncode(jsonMap);
  }

  @override
  String toString() {
    return jsonEncode(this);
  }
}