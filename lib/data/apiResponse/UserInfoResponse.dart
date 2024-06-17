import 'dart:convert';
import 'BaseResponse.dart';

class UserInfoResponse extends BaseResponse<UserInfoData> {
  UserInfoResponse({required int result, required UserInfoData data})
      : super(result: result, data: data);

  factory UserInfoResponse.fromJson(Map<String, dynamic> json) {
    return UserInfoResponse(
      result: json['result'] ?? 0,
      data: UserInfoData.fromJson(json['data'] ?? {}),
    );
  }

  factory UserInfoResponse.fromString(String source) => UserInfoResponse.fromJson(jsonDecode(source));
}

class UserInfoData {
  final String? uid;
  final String? account;
  final String? name;
  final String? org;
  final int accountType;
  final Map<String, String> attrs;
  final List<Group> groups;
  final Map<String, dynamic> pushInfo;

  UserInfoData({
    this.uid,
    this.account,
    this.name,
    this.org,
    required this.accountType,
    required this.attrs,
    required this.groups,
    required this.pushInfo,
  });

  factory UserInfoData.fromJson(Map<String, dynamic> json) {
    return UserInfoData(
      uid: json['uid'],
      account: json['account'],
      name: json['name'],
      org: json['org'],
      accountType: json['accountType'] ?? 0,
      attrs: json['attrs'] != null ? Map<String, String>.from(json['attrs']) : {},
      groups: (json['groups'] as List<dynamic>)
          .map((groupJson) => Group.fromJson(groupJson))
          .toList(),
      pushInfo: json['pushInfo'] != null ? Map<String, dynamic>.from(json['pushInfo']) : {},
    );
  }
}


class Group {
  final String groupId;
  final String parent;
  final String name;
  final String owner;
  final Map<String, dynamic> attrs;
  final String? ownerAccount;

  Group({
    required this.groupId,
    required this.parent,
    required this.name,
    required this.owner,
    required this.attrs,
    this.ownerAccount,
  });

  factory Group.fromJson(Map<String, dynamic> json) {
    return Group(
      groupId: json['groupId'],
      parent: json['parent'],
      name: json['name'],
      owner: json['owner'],
      attrs: json['attrs'] != null ? Map<String, dynamic>.from(json['attrs']) : {},
      ownerAccount: json['ownerAccount'],
    );
  }
}