
class SendBatteryPriorityModeCmdRequest {
  final String s8;

  SendBatteryPriorityModeCmdRequest({
    required this.s8,
  });

  Map<String, dynamic> toJson() {
    return {
      'S8': s8,
    };
  }
}
