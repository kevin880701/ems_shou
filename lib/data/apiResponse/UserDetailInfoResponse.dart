import 'dart:convert';
import 'ResponseBase.dart';

class UserDetailInfoResponse extends ResponseBase {
  UserDetailInfoResponse({required int result, required dynamic data})
      : super(result: result, data: data);

  factory UserDetailInfoResponse.fromJson(Map<String, dynamic> json) {
    return UserDetailInfoResponse(
      result: json['result'] ?? 0,
      data: json['data'] ?? {}, // 直接傳遞 data
    );
  }

  factory UserDetailInfoResponse.fromString(String source) => UserDetailInfoResponse.fromJson(jsonDecode(source));
}

class UserDetailInfo {
  final String uid;
  final String account;
  final String name;
  final String org;
  final int accountType;
  final Map<String, dynamic> attrs;
  final List<Group> groups;
  final Map<String, dynamic> pushInfo;

  UserDetailInfo({
    required this.uid,
    required this.account,
    required this.name,
    required this.org,
    required this.accountType,
    required this.attrs,
    required this.groups,
    required this.pushInfo,
  });

  factory UserDetailInfo.fromJson(Map<String, dynamic> json) {
    return UserDetailInfo(
      uid: json['uid'],
      account: json['account'],
      name: json['name'],
      org: json['org'],
      accountType: json['accountType'],
      attrs: json['attrs'] != null ? Map<String, dynamic>.from(json['attrs']) : {},
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

