
import 'dart:convert';

class ChangeUserNameRequest {
  final String name;

  ChangeUserNameRequest({
    required this.name,
  });

  String toJson() {
    Map<String, dynamic> jsonMap = {
      'name': name,
    };
    return jsonEncode(jsonMap);
  }
}
