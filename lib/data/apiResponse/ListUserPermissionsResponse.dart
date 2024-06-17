
import 'BaseResponse.dart';

class ListUserPermissionsResponse extends BaseResponse<Map<String, Map<String, PermissionInfo>>> {
  ListUserPermissionsResponse({required int result, required Map<String, Map<String, PermissionInfo>> data})
      : super(result: result, data: data);

  factory ListUserPermissionsResponse.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> jsonData = json['data'] ?? {};
    Map<String, Map<String, PermissionInfo>> parsedData = {};

    jsonData.forEach((userId, permissions) {
      Map<String, PermissionInfo> parsedPermissions = {};
      permissions.forEach((devId, permissionInfo) {
        parsedPermissions[devId] = PermissionInfo.fromJson(permissionInfo);
      });
      parsedData[userId] = parsedPermissions;
    });

    return ListUserPermissionsResponse(
      result: json['result'] ?? 0,
      data: parsedData,
    );
  }
}

class PermissionInfo {
  final int permission;
  final int ruleFlag;

  PermissionInfo({required this.permission, required this.ruleFlag});

  factory PermissionInfo.fromJson(Map<String, dynamic> json) {
    return PermissionInfo(
      permission: json['permission'] ?? 0,
      ruleFlag: json['ruleFlag'] ?? 0,
    );
  }
}