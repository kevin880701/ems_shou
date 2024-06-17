import 'package:intl/intl.dart';
import 'package:tuple/tuple.dart';

import '../../define.dart';
import '../Params.dart';
import 'SendSelfUseModeCmdRequest.dart';

class SetPeakShavingModeTimeRequest {
  final String m12;
  final String? m22;

  SetPeakShavingModeTimeRequest({
    required this.m12,
    this.m22,
  });

  Map<String, dynamic> toJson() {
    return {
      'M12': m12,
      'M22': m22,
    };
  }

  factory SetPeakShavingModeTimeRequest.create(
    int chargeStart1Index,
    int chargeEnd1Index,
    int dischargeStart1Index,
    int dischargeEnd1Index,
    int chargeStart2Index,
    int chargeEnd2Index,
    int dischargeStart2Index,
    int dischargeEnd2Index,
  ) {
    String chargeStart1Time = (chargeStart1Index != -1) ? removeTimeColon(timeList[chargeStart1Index]) : "0000";
    String chargeEnd1Time = (chargeEnd1Index != -1)
        ? (chargeEnd1Index == 0)
            ? "2359"
            : removeTimeColon(timeList[chargeEnd1Index])
        : "0000";
    String dischargeStart1Time = (dischargeStart1Index != -1) ? removeTimeColon(timeList[dischargeStart1Index]) : "0000";
    String dischargeEnd1Time = (dischargeEnd1Index != -1)
        ? (dischargeEnd1Index == 0)
            ? "2359"
            : removeTimeColon(timeList[dischargeEnd1Index])
        : "0000";
    String chargeStart2Time = (chargeStart2Index != -1) ? removeTimeColon(timeList[chargeStart2Index]) : "0000";
    String chargeEnd2Time = (chargeEnd2Index != -1)
        ? (chargeEnd2Index == 0)
            ? "2359"
            : removeTimeColon(timeList[chargeEnd2Index])
        : "0000";
    String dischargeStart2Time = (dischargeStart2Index != -1) ? removeTimeColon(timeList[dischargeStart2Index]) : "0000";
    String dischargeEnd2Time = (dischargeEnd2Index != -1)
        ? (dischargeEnd2Index == 0)
            ? "2359"
            : removeTimeColon(timeList[dischargeEnd2Index])
        : "0000";
    return SetPeakShavingModeTimeRequest(
      m12: chargeStart1Time + chargeEnd1Time + dischargeStart1Time + dischargeEnd1Time,
      m22: chargeStart2Time + chargeEnd2Time + dischargeStart2Time + dischargeEnd2Time,
    );
  }
}
