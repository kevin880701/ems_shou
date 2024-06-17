import 'package:ems_app/data/apiResponse/SimpleApiResult.dart';
import 'package:ems_app/net/remote/ApiEndPoint.dart';
import 'package:ems_app/net/remote/NetworkInterface.dart';
import 'package:ems_app/repository/AccountRepository.dart';

import '../data/apiRequest/SendBatteryPriorityModeCmdRequest.dart';
import '../data/apiRequest/SendPeakShavingModeCmdRequest.dart';
import '../data/apiRequest/SendSelfUseModeCmdRequest.dart';
import '../data/apiRequest/DeviceGetByIdRequest.dart';
import '../data/apiRequest/SetPeakShavingModeTimeRequest.dart';
import '../data/apiRequest/SetSelfUseModeTimeRequest.dart';
import '../net/remote/Managers/CommandModeManager.dart';

class CommandRepository {
  CommandRepository._();

  static final CommandRepository instance = CommandRepository._();
  NetworkInterface network = NetworkInterface();

  CommandModeManager commandModeManager = CommandModeManager.instance;

  Future<bool> sendSelfUseModeCmd(SendSelfUseModeCmdRequest cmdSelfUseModeRequest) async {
    return commandModeManager.sendSelfUseModeCmd(cmdSelfUseModeRequest);
  }

  Future<bool> sendBatteryPriorityModeCmd(SendBatteryPriorityModeCmdRequest cmdBatteryPriorityModeRequest) async {
    return commandModeManager.sendBatteryPriorityModeCmd(cmdBatteryPriorityModeRequest);
  }

  Future<bool> sendPeakShavingModeCmd(SendPeakShavingModeCmdRequest cmdPeakShavingModeRequest) async {
    return commandModeManager.sendPeakShavingModeCmd(cmdPeakShavingModeRequest);
  }

  Future<bool> setSelfUseModeTime(SetSelfUseModeTimeRequest setSelfUseModeTimeRequest) async {
    return commandModeManager.setSelfUseModeTime(setSelfUseModeTimeRequest);
  }

  Future<bool> setPeakShavingModeTime(SetPeakShavingModeTimeRequest setPeakShavingModeTimeRequest) async {
    return commandModeManager.setPeakShavingModeTime(setPeakShavingModeTimeRequest);
  }
}
