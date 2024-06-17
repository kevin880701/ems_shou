import 'package:intl/intl.dart';
import 'package:tuple/tuple.dart';

import '../../define.dart';
import '../Params.dart';

class SetSelfUseModeTimeRequest {
  final String m33;
  final String m34;

  SetSelfUseModeTimeRequest({
    required this.m33,
    required this.m34,
  });

  Map<String, dynamic> toJson() {
    return {
      'M33': m33,
      'M34': m34,
    };
  }

  factory SetSelfUseModeTimeRequest.create(
    int chargeStartIndex,
    int chargeEndIndex,
  ) {
    return SetSelfUseModeTimeRequest(
      m33: removeTimeColon(timeList[chargeStartIndex]),
      m34: removeTimeColon(timeList[chargeEndIndex]),
    );
  }
}
