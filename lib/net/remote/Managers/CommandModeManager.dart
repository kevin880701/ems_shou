import 'dart:convert';
import "package:ems_app/data/apiResponse/TreeDataResponse.dart";
import "package:ems_app/data/apiResponse/WidgetDataResponse.dart";
import "package:ems_app/net/remote/ApiEndPoint.dart";
import "package:ems_app/net/remote/NetworkInterface.dart";

import "../../../data/apiRequest/SendBatteryPriorityModeCmdRequest.dart";
import "../../../data/apiRequest/SendPeakShavingModeCmdRequest.dart";
import "../../../data/apiRequest/SendSelfUseModeCmdRequest.dart";
import "../../../data/apiRequest/DeviceGetByIdRequest.dart";
import "../../../data/apiRequest/HistoryValueStatisticsRequest.dart";
import "../../../data/apiRequest/SetPeakShavingModeTimeRequest.dart";
import "../../../data/apiRequest/SetSelfUseModeTimeRequest.dart";
import "../../../data/apiResponse/DeviceGetByIdResponse.dart";
import "../../../data/apiResponse/EnergyData.dart";
import "../../../data/apiResponse/SimpleApiResult.dart";
import "../../../repository/AccountRepository.dart";
import "../../../viewModel/EnergyStorageViewModel.dart";

class CommandModeManager {
  CommandModeManager._();

  static final CommandModeManager instance = CommandModeManager._();

  NetworkInterface network = NetworkInterface();

  final AccountRepository accountRepository = AccountRepository.instance;

  late EnergyStorageViewModel energyStorageViewModel =
      EnergyStorageViewModel.instance;

  Future<bool> sendSelfUseModeCmd(SendSelfUseModeCmdRequest cmdSelfUseModeRequest) async {
    try {
      var response = await network.wrapperHttpError(() {
        var url = '${ApiEndPoint.setValue}${energyStorageViewModel.energyStorageId}';
        // var url = '${ApiEndPoint.setValue}${accouuntRepository.getGroupId()}';
        return network.post(url: url, body: cmdSelfUseModeRequest.toJson().toString(), userToken: accountRepository.token);
      });

      if (response.statusCode == 200) {
        SimpleApiResult simpleApiResult =
        SimpleApiResult.fromString(response.data);
        print('simpleApiResult:${simpleApiResult.result}');
        return simpleApiResult.isSuccess();
      } else {
        return false;
      }
    } catch (e) {
      print('Error setting value: $e');
      return false;
    }
  }


  Future<bool> sendBatteryPriorityModeCmd(SendBatteryPriorityModeCmdRequest cmdBatteryPriorityModeRequest) async {
    try {
      var response = await network.wrapperHttpError(() {
        var url = '${ApiEndPoint.setValue}${energyStorageViewModel.energyStorageId}';
        // var url = '${ApiEndPoint.setValue}${accouuntRepository.getGroupId()}';
        return network.post(url: url, body: cmdBatteryPriorityModeRequest.toJson().toString(), userToken: accountRepository.token);
      });

      if (response.statusCode == 200) {
        SimpleApiResult simpleApiResult =
        SimpleApiResult.fromString(response.data);
        print('simpleApiResult:${simpleApiResult.result}');
        return simpleApiResult.isSuccess();
      } else {
        return false;
      }
    } catch (e) {
      print('Error setting value: $e');
      return false;
    }
  }

  Future<bool> sendPeakShavingModeCmd(SendPeakShavingModeCmdRequest cmdSaveModeRequest) async {
    try {
      var response = await network.wrapperHttpError(() {
        var url = '${ApiEndPoint.setValue}${energyStorageViewModel.energyStorageId}';
        // var url = '${ApiEndPoint.setValue}${accouuntRepository.getGroupId()}';
        return network.post(url: url, body: cmdSaveModeRequest.toJson().toString(), userToken: accountRepository.token);
      });

      if (response.statusCode == 200) {
        SimpleApiResult simpleApiResult =
        SimpleApiResult.fromString(response.data);
        print('simpleApiResult:${simpleApiResult.result}');
        return simpleApiResult.isSuccess();
      } else {
        return false;
      }
    } catch (e) {
      print('Error setting value: $e');
      return false;
    }
  }

  Future<bool> setSelfUseModeTime(SetSelfUseModeTimeRequest setSelfUseModeTimeRequest) async {
    try {
      var response = await network.wrapperHttpError(() {
        var url = '${ApiEndPoint.setValue}${energyStorageViewModel.energyStorageId}';
        // var url = '${ApiEndPoint.setValue}${accouuntRepository.getGroupId()}';
        return network.post(url: url, body: setSelfUseModeTimeRequest.toJson().toString(), userToken: accountRepository.token);
      });

      if (response.statusCode == 200) {
        SimpleApiResult simpleApiResult =
        SimpleApiResult.fromString(response.data);
        print('simpleApiResult:${simpleApiResult.result}');
        return simpleApiResult.isSuccess();
      } else {
        return false;
      }
    } catch (e) {
      print('Error setting value: $e');
      return false;
    }
  }

  Future<bool> setPeakShavingModeTime(SetPeakShavingModeTimeRequest setPeakShavingModeTimeRequest) async {
    try {
      var response = await network.wrapperHttpError(() {
        var url = '${ApiEndPoint.setValue}${energyStorageViewModel.energyStorageId}';
        // var url = '${ApiEndPoint.setValue}${accouuntRepository.getGroupId()}';
        return network.post(url: url, body: setPeakShavingModeTimeRequest.toJson().toString(), userToken: accountRepository.token);
      });

      if (response.statusCode == 200) {
        SimpleApiResult simpleApiResult =
        SimpleApiResult.fromString(response.data);
        print('simpleApiResult:${simpleApiResult.result}');
        return simpleApiResult.isSuccess();
      } else {
        return false;
      }
    } catch (e) {
      print('Error setting value: $e');
      return false;
    }
  }
}
