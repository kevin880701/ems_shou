
import 'dart:convert';

class PushInfoSetRequest {
  final String token;
  final String pushType;
  final String account;
  final int appid;

  PushInfoSetRequest({
    required this.token,
    required this.pushType,
    required this.account,
    required this.appid,
  });

  String toJson() {
    Map<String, dynamic> jsonMap = {
      'token': token,
      'pushType': pushType,
      'account': account,
      'appid': appid
    };
    return jsonEncode(jsonMap);
  }
}
