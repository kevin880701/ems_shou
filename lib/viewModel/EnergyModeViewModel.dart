
import 'package:ems_app/repository/CommandRepository.dart';
import 'package:ems_app/resources/app_resources.dart';
import 'package:flutter/cupertino.dart';
import '../data/Params.dart';
import '../data/apiRequest/SendBatteryPriorityModeCmdRequest.dart';
import '../data/apiRequest/SendPeakShavingModeCmdRequest.dart';
import '../data/apiRequest/SendSelfUseModeCmdRequest.dart';
import '../data/apiRequest/SetPeakShavingModeTimeRequest.dart';
import '../data/apiRequest/SetSelfUseModeTimeRequest.dart';
import '../data/apiResponse/DeviceGetByIdResponse.dart';
import '../data/apiResponse/DeviceListResponse.dart';
import '../data/mode/ModeData.dart';

class EnergyModeViewModel extends ChangeNotifier {
  EnergyModeViewModel._();

  static final EnergyModeViewModel instance = EnergyModeViewModel._();

  CommandRepository commandRepository = CommandRepository.instance;

  ModeData modeData = ModeData(
    modeName: AppTexts.batteryPriorityMode,
    modeDescription: AppTexts.batteryPriorityModeSubTitle,
    image: 'assets/images/model3.png',
    selfModeStartIndex: -1,
    selfModeEndIndex: -1,
    peakShavingChargeStart1Index: -1,
    peakShavingChargeEnd1Index: -1,
    peakShavingDischargeStart1Index: -1,
    peakShavingDischargeEnd1Index: -1,
    peakShavingChargeStart2Index: -1,
    peakShavingChargeEnd2Index: -1,
  );

  ///
  /// 根據傳入的modeValue設置能源模式和相關時間。
  ///   要設置的能源模式的key為reqAndInfo3044，0表示自發自用模式，1表示削峰填谷模式，2表示電池優先優先模式
  ///
  /// 參數：
  ///   response: 打API取回的資料，
  ///
  /// 返回值：
  ///   無。
  ///
  void setEnergyMode(DeviceListData response) {
    // 當前模式點位
    int currentMode = response.vals.reqAndInfo3044;
    // 自發自用點位
    String reqAndInfo3317 = response.vals.reqAndInfo3317;
    String reqAndInfo3318 = response.vals.reqAndInfo3318;
    String selfModeStarTime = "${reqAndInfo3317.substring(0, 2)}:${reqAndInfo3317.substring(2)}";
    String selfModeEndTime = "${reqAndInfo3318.substring(0, 2)}:${reqAndInfo3318.substring(2)}";
    // 削峰填谷點位，時間格式為充電開始結束+放電開始結束時間：HHMMHHMMHHMMHHMM
    String reqAndInfo3160 = response.vals.reqAndInfo3160; // 第一組時間
    String peakShavingChargeStart1Index = '${reqAndInfo3160.substring(0, 2)}:${reqAndInfo3160.substring(2, 4)}';
    String peakShavingChargeEnd1Index = '${reqAndInfo3160.substring(4, 6)}:${reqAndInfo3160.substring(6, 8)}';
    String peakShavingDischargeStart1Index =
        '${reqAndInfo3160.substring(8, 10)}:${reqAndInfo3160.substring(10, 12)}';
    String peakShavingDischargeEnd1Index = '${reqAndInfo3160.substring(12, 14)}:${reqAndInfo3160.substring(14)}';


    String reqAndInfo3168 = response.vals.reqAndInfo3168; // 第二組時間

    String peakShavingChargeStart2Index = "";
    String peakShavingChargeEnd2Index = "";
    String peakShavingDischargeStart2Index = "";
    String peakShavingDischargeEnd2Index = "";
    if(response.vals.reqAndInfo3168 != "0000000000000000"){
      peakShavingChargeStart2Index = '${reqAndInfo3168.substring(0, 2)}:${reqAndInfo3168.substring(2, 4)}';
      peakShavingChargeEnd2Index = '${reqAndInfo3168.substring(4, 6)}:${reqAndInfo3168.substring(6, 8)}';
      peakShavingDischargeStart2Index = '${reqAndInfo3168.substring(8, 10)}:${reqAndInfo3168.substring(10, 12)}';
      peakShavingDischargeEnd2Index = '${reqAndInfo3168.substring(12, 14)}:${reqAndInfo3168.substring(14)}';
    }

    modeData..selfModeStartIndex = timeList.indexOf(selfModeStarTime)
      ..selfModeEndIndex = timeList.indexOf(selfModeEndTime)
      ..selfModeEndIndex = timeList.indexOf(selfModeEndTime)
      ..peakShavingChargeStart1Index = timeList.indexOf(peakShavingChargeStart1Index)
      ..peakShavingChargeEnd1Index = timeList.indexOf(peakShavingChargeEnd1Index)
      ..peakShavingDischargeStart1Index = timeList.indexOf(peakShavingDischargeStart1Index)
      ..peakShavingDischargeEnd1Index = timeList.indexOf(peakShavingDischargeEnd1Index)
      ..peakShavingChargeStart2Index = timeList.indexOf(peakShavingChargeStart2Index)
      ..peakShavingChargeEnd2Index = timeList.indexOf(peakShavingChargeEnd2Index)
      ..peakShavingDischargeStart2Index = timeList.indexOf(peakShavingDischargeStart2Index)
      ..peakShavingDischargeEnd2Index = timeList.indexOf(peakShavingDischargeEnd2Index);

    switch (currentMode) {
      case 0:
        modeData..modeName = AppTexts.selfMode
            ..modeDescription = AppTexts.selfModeSubTitle
            ..image = 'assets/images/model1.png';
        break;
      case 1:
        modeData
          ..modeName = AppTexts.peakShavingMode
          ..modeDescription = AppTexts.peakShavingModeSubTitle
          ..image = 'assets/images/model2.png';
        break;
      case 2:
        modeData
          ..modeName = AppTexts.batteryPriorityMode
          ..modeDescription = AppTexts.batteryPriorityModeSubTitle
          ..image = 'assets/images/model3.png';
        break;
    }
    notifyListeners(); // 通知監聽者數據發生了變化
  }

  void setModeData(String type) {
    if (type == AppTexts.batteryPriorityMode) {
      modeData
        ..modeName = AppTexts.batteryPriorityMode
        ..modeDescription = AppTexts.batteryPriorityModeSubTitle
        ..image = 'assets/images/model3.png';
    } else if (type == AppTexts.selfMode) {
      modeData..modeName = AppTexts.selfMode
        ..modeDescription = AppTexts.selfModeSubTitle
        ..image = 'assets/images/model1.png';
    } else if (type == AppTexts.peakShavingMode) {
      modeData
        ..modeName = AppTexts.peakShavingMode
        ..modeDescription = AppTexts.peakShavingModeSubTitle
        ..image = 'assets/images/model2.png';
    }
    notifyListeners(); // 通知監聽者數據發生了變化
  }

  Future<bool> sendSelfUseModeCmd(SendSelfUseModeCmdRequest cmdSelfUseModeRequest) async {
    bool? tempData = await commandRepository.sendSelfUseModeCmd(cmdSelfUseModeRequest);
    if (tempData != null) {
      // 通知監聽者數據發生了變化
      notifyListeners();
      return tempData;
    } else {
      return false;
    }
  }

  Future<bool> sendBatteryPriorityModeCmd(SendBatteryPriorityModeCmdRequest cmdBatteryPriorityModeRequest) async {
    bool? tempData = await commandRepository.sendBatteryPriorityModeCmd(cmdBatteryPriorityModeRequest);
    if (tempData != null) {
      // 通知監聽者數據發生了變化
      notifyListeners();
      return tempData;
    } else {
      return false;
    }
  }

  Future<bool> sendPeakShavingModeCmd(SendPeakShavingModeCmdRequest cmdSaveModeRequest) async {
    bool? tempData = await commandRepository.sendPeakShavingModeCmd(cmdSaveModeRequest);
    if (tempData != null) {
      // 通知監聽者數據發生了變化
      notifyListeners();
      return tempData;
    } else {
      return false;
    }
  }

  Future<bool> setSelfUseModeTime(SetSelfUseModeTimeRequest setSelfUseModeTimeRequest) async {
    bool? tempData = await commandRepository.setSelfUseModeTime(setSelfUseModeTimeRequest);
    if (tempData != null) {
      // 通知監聽者數據發生了變化
      notifyListeners();
      return tempData;
    } else {
      return false;
    }
  }

  Future<bool> setPeakShavingModeTime(SetPeakShavingModeTimeRequest setPeakShavingModeTimeRequest) async {
    bool? tempData = await commandRepository.setPeakShavingModeTime(setPeakShavingModeTimeRequest);
    if (tempData != null) {
      // 通知監聽者數據發生了變化
      notifyListeners();
      return tempData;
    } else {
      return false;
    }
  }
}
