
import 'dart:convert';

class SetAvatarRequest {
  final String avatar;

  SetAvatarRequest({
    required this.avatar,
  });

  String toJson() {
    Map<String, dynamic> jsonMap = {
      'avatar': avatar
    };
    return jsonEncode(jsonMap);
  }
}
