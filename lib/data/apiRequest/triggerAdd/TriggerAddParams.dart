class TriggerAddParams {
  final String groupId;

  TriggerAddParams({
    required this.groupId,
  });

  Map<String, dynamic> toJson() {
    return {
      'groupId': groupId,
    };
  }
}