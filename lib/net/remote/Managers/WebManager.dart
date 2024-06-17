import 'dart:convert';
import "package:ems_app/data/apiResponse/DeviceListResponse.dart";
import "package:ems_app/data/apiResponse/TreeDataResponse.dart";
import "package:ems_app/data/apiResponse/WidgetDataResponse.dart";
import "package:ems_app/net/remote/ApiEndPoint.dart";
import "package:ems_app/net/remote/NetworkInterface.dart";
import "package:ems_app/viewModel/EnergyStorageViewModel.dart";
import "../../../data/apiRequest/AddDevNodeRequest.dart";
import "../../../data/apiRequest/SetTimeZoneRequest.dart";
import "../../../data/apiRequest/listUserPermissions/ListUserPermissionsParams.dart";
import "../../../data/apiRequest/triggerAdd/TriggerAddBody.dart";
import "../../../data/apiRequest/triggerAdd/TriggerAddParams.dart";
import "../../../data/apiResponse/AddDevNodeResponse.dart";
import "../../../data/apiResponse/ListUserPermissionsResponse.dart";
import '../../../data/apiResponse/NodeConfigsResponse.dart';
import "../../../data/apiRequest/HistoryValueStatisticsRequest.dart";
import "../../../data/apiResponse/AddDeviceResponse.dart";
import "../../../data/apiResponse/EnergyData.dart";
import "../../../repository/AccountRepository.dart";

class WebManager {
  WebManager._();

  static final WebManager instance = WebManager._();

  NetworkInterface network = NetworkInterface();

  final AccountRepository accountRepository = AccountRepository.instance;

  late String currentGroupId;

  late TreeData currentTreeData;

  late TreeData currentTreeDataByGroupId;

  late String groupIdParent;

  late String id;

  late String oid;

  late String defineType;

  late String deviceID;

  late List<WidgetData> currentWidgetList;

  // 04/01驗收先給指定的ID：inverter01
  Future<EnergyListData?> getChartData(String startTime, String endTime, List<String> fields, int interval) async {
    try {
      var response = await network.wrapperHttpError(() {
        String field = "\$time,${fields.join(',')}";
        String titles = "time,${fields.map((field) => '${field.substring(0, field.length - 4)}').join(',')}";
        var request = HistoryValueStatisticsRequest(
            startTime: startTime, endTime: endTime, fields: field, interval: interval, titles: titles);
        var url = '${ApiEndPoint.getChartData}${EnergyStorageViewModel.instance.deviceId}';
        return network.get(url: url, userToken: accountRepository.token, query: request.toMap());
      });
      Map<String, dynamic> energyDatas = response.data;
      List<String> titleList = fields.map((field) => "$field").toList();
      EnergyListData energyListData = EnergyListData.fromJson(energyDatas, titleList);
      return energyListData;
    } catch (e) {
      print('Failed to get getChartData: $e');
      return null;
    }
  }

  Future<List<DeviceListData>> getDeviceList() async {
    try {
      var response = await network.wrapperHttpError(() {
        var url = '${ApiEndPoint.listDevice}';
        return network.get(url: url, userToken: accountRepository.token);
      });
      Map<String, dynamic> responseData = jsonDecode(response.toString());
      DeviceListResponse deviceListResponse = DeviceListResponse.fromJson(responseData);
      return deviceListResponse.data;
    } catch (e) {
      print('Failed to getDeviceList: $e');
      return [];
    }
  }

  Future<AddDeviceData?> addDevice(String addDeviceRequest) async {
    try {
      var response = await network.wrapperHttpError(() {
        var url = '${ApiEndPoint.addDevice}';
        return network.post(url: url, userToken: accountRepository.token, body: addDeviceRequest);
      });
      Map<String, dynamic> responseData = jsonDecode(response.toString());
      AddDeviceResponse addDeviceResponse = AddDeviceResponse.fromJson(responseData);
      return addDeviceResponse.data;
    } catch (e) {
      print('Failed to addDevice: $e');
      return null;
    }
  }

  Future<List<NodeConfig>> getNodeConfigs(int modelId) async {
    try {
      var response = await network.wrapperHttpError(() {
        var url = '${ApiEndPoint.getNodeConfigs}$modelId';
        return network.get(url: url, userToken: accountRepository.token);
      });
      Map<String, dynamic> responseData = jsonDecode(response.toString());
      NodeConfigsResponse deviceListResponse = NodeConfigsResponse.fromJson(responseData);
      return deviceListResponse.data;
    } catch (e) {
      print('Failed to getNodeConfigs: $e');
      return [];
    }
  }

  Future<bool> addDevNode(AddDevNodeRequest addDevNodeRequest) async {
    try {
      var response = await network.wrapperHttpError(() {
        var url = ApiEndPoint.addDevNode;
        return network.post(
            url: url, userToken: accountRepository.token, body: jsonEncode(addDevNodeRequest));
      });
      Map<String, dynamic> responseData = jsonDecode(response.toString());
      AddDevNodeResponse addDevNodeResponse = AddDevNodeResponse.fromJson(responseData);
      return true;
    } catch (e) {
      print('Failed to addDevNode: $e');
      return false;
    }
  }

  Future<bool> setTimeZone(SetTimeZoneRequest setTimeZoneRequest, String id) async {
    try {
      var response = await network.wrapperHttpError(() {
        var url = "${ApiEndPoint.setTimeZone}$id";
        return network.post(
            url: url, userToken: accountRepository.token, body: setTimeZoneRequest.toJson());
      });
      return true;
    } catch (e) {
      print('Failed to setTimeZone: $e');
      return false;
    }
  }

  Future<bool> triggerAdd(TriggerAddBody request, TriggerAddParams params) async {
    try {
      var response = await network.wrapperHttpError(() {
        var url = "${ApiEndPoint.triggerAdd}";
        return network.post(
            url: url, userToken: accountRepository.token, body: request.toJson(), query: params.toJson());
      });
      return true;
    } catch (e) {
      print('Failed to triggerAdd: $e');
      return false;
    }
  }

  Future<Map<String, PermissionInfo>> listUserPermissions(ListUserPermissionsParams params) async {
    try {
      var response = await network.wrapperHttpError(() {
        var url = ApiEndPoint.listUserPermissions;
        return network.get(
            url: url, userToken: accountRepository.token, query: params.toJson());
      });
      ListUserPermissionsResponse listUserPermissionsResponse = ListUserPermissionsResponse.fromJson(jsonDecode(response.toString()));
      return listUserPermissionsResponse.data[params.accountids]!;
    } catch (e) {
      print('Failed to listUserPermissions: $e');
      return {};
    }
  }
}
