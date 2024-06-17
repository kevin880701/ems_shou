
import 'dart:convert';

class GoogleLoginRequest {

  final String account;
  final String name;
  final String gUid;

  GoogleLoginRequest({
    required this.account,
    required this.name,
    required this.gUid,
  });

  String toJson() {
    Map<String, dynamic> jsonMap = {
      'account': account,
      'name': name,
      'gUid': gUid,
    };
    return jsonEncode(jsonMap);
  }

  @override
  String toString() {
    return jsonEncode(this);
  }
}