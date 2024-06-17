import 'package:ems_app/net/remote/NetworkInterface.dart';
import '../data/apiRequest/AddDevNodeRequest.dart';
import '../data/apiRequest/AddDeviceRequest.dart';
import '../data/apiRequest/DeviceGetByIdRequest.dart';
import '../data/apiRequest/SetTimeZoneRequest.dart';
import '../data/apiRequest/listUserPermissions/ListUserPermissionsParams.dart';
import '../data/apiRequest/triggerAdd/TriggerAddBody.dart';
import '../data/apiRequest/triggerAdd/TriggerAddParams.dart';
import '../data/apiResponse/AddDeviceResponse.dart';
import '../data/apiResponse/DeviceGetByIdResponse.dart';
import '../data/apiResponse/DeviceListResponse.dart';
import '../data/apiResponse/EnergyData.dart';
import '../data/apiResponse/ListUserPermissionsResponse.dart';
import '../data/apiResponse/TreeDataResponse.dart';
import '../data/apiResponse/WidgetDataResponse.dart';
import '../net/remote/Managers/WebManager.dart';
import 'AccountRepository.dart';

class EnergyStorageRepository {
  EnergyStorageRepository._();

  static final EnergyStorageRepository instance = EnergyStorageRepository._();

  WebManager webManager = WebManager.instance;

  final AccountRepository accountRepository = AccountRepository.instance;

  NetworkInterface network = NetworkInterface();

  List<DeviceListData> deviceList = [];

  Map<String, PermissionInfo> userPermissionsMap = {};

  Future<EnergyListData?> getChartData(
    String startTime,
    String endTime,
    List<String> fields,
    int interval,
  ) async {
    return webManager.getChartData(
      startTime,
      endTime,
      fields,
      interval,
    );
  }

  Future<List<DeviceListData>> getDeviceList() async {
    return await webManager.getDeviceList();
  }

  Future<AddDeviceData?> addDevice(
    String addDeviceRequest,
  ) async {
    return await webManager.addDevice(addDeviceRequest);
  }

  Future<bool> setNodeConfigs(String devId, int modelId) async {
    webManager.getNodeConfigs(modelId).then((value) {
      AddDevNodeRequest addDevNodeRequest = AddDevNodeRequest(
        devid: devId,
        nodes: value,
      );
      return webManager.addDevNode(addDevNodeRequest);
    });
    return false;
  }

  Future<bool> setTimeZone(String id, String name) async {
    ;
    return await webManager.setTimeZone(SetTimeZoneRequest(
      attrs: SetTimeZoneAttrs(
        timezone: "Asia/Taipei(GMT+08:00)",
        timezoneVal: "+28800",
      ),
      name: name,
    ), id);
  }

  Future<bool> triggerAdd(String deviceUid, String uid, String devid, String groupId) async {

    TriggerAddBody triggerBody = TriggerAddBody.createRequest(
      triggerId: deviceUid,
      owner: uid,
      name: "$devid錯誤碼告警",
      triggerDevs: [deviceUid],
      uids: [uid],
      type: "PushMsgAction",
      devid: deviceUid,
      type2: "EventLogDetailAction",
      type3: "WebSocketDeviceAlarmMsgAction",
    );

    TriggerAddParams triggerAddParams = TriggerAddParams(groupId: groupId);

    return await webManager.triggerAdd(triggerBody, triggerAddParams);
  }

  Future<void> listUserPermissions() async {
    userPermissionsMap = await webManager.listUserPermissions(ListUserPermissionsParams(accountids: accountRepository
            .userInfo.uid!));
  }

}
