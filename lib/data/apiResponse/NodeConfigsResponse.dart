import 'dart:convert';

import 'BaseResponse.dart';

class NodeConfigsResponse extends BaseResponse<List<NodeConfig>> {
  NodeConfigsResponse({required int result, required List<NodeConfig> data})
      : super(result: result, data: data);

  factory NodeConfigsResponse.fromJson(Map<String, dynamic> json) {
    var nodeConfigList = (jsonDecode(json['data']) as List<dynamic>).map((json) => NodeConfig.fromJson(json)).toList();

    return NodeConfigsResponse(
    result: json['result'] ?? 0,
    data: nodeConfigList,
    );
    }
}

class NodeConfig {
  final String ruleType;
  final String name;
  final String rule;
  final String id;
  final int type;

  NodeConfig({
    required this.ruleType,
    required this.name,
    required this.rule,
    required this.id,
    required this.type,
  });

  factory NodeConfig.fromJson(Map<String, dynamic> json) {
    return NodeConfig(
      ruleType: json['ruleType'] ?? '',
      name: json['name'] ?? '',
      rule: json['rule'] ?? '',
      id: json['id'] ?? '',
      type: json['type'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ruleType': ruleType,
      'name': name,
      'rule': rule,
      'id': id,
      'type': type,
    };
  }
}