import 'package:intl/intl.dart';
import 'package:tuple/tuple.dart';

import '../../define.dart';
import '../Params.dart';

class SendSelfUseModeCmdRequest {
  final String m31;
  final String m32;
  final String m35;

  SendSelfUseModeCmdRequest({
    required this.m31,
    required this.m32,
    required this.m35,
  });

  Map<String, dynamic> toJson() {
    return {
      'M31': m31,
      'M32': m32,
      'M35': m35,
    };
  }

  factory SendSelfUseModeCmdRequest.create(
  ) {
    return SendSelfUseModeCmdRequest(
      m31: '0',
      m32: '1',
      m35: '100',
    );
  }
}
