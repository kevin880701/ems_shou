import 'package:intl/intl.dart';
import 'package:tuple/tuple.dart';

import '../../define.dart';
import '../Params.dart';
import 'SendSelfUseModeCmdRequest.dart';

class SendPeakShavingModeCmdRequest {
  final String m11;
  final String? m21;

  SendPeakShavingModeCmdRequest({
    required this.m11,
    this.m21,
  });

  Map<String, dynamic> toJson() {
    return {
      'M11': m11,
      'M21': m21,
    };
  }

  factory SendPeakShavingModeCmdRequest.create(
  ) {
    return SendPeakShavingModeCmdRequest(
      m11: "1",
      m21: "1",
    );
  }
}
