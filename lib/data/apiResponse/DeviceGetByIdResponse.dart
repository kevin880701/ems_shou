import 'package:ems_app/resources/app_resources.dart';

class DeviceGetByIdResponse {
  final String id;
  String? parent;
  final String devId;
  final String name;
  final int modelId;
  final String modelName;
  String? owner;
  final int activeappid;
  final int status;
  List<dynamic> profiles;
  final Attrs? attrs;
  final DeviceVals vals;
  final List<Node> nodes;

  DeviceGetByIdResponse({
    required this.id,
    this.parent,
    required this.devId,
    required this.name,
    required this.modelId,
    required this.modelName,
    this.owner,
    required this.activeappid,
    required this.status,
    required this.profiles,
    this.attrs,
    required this.vals,
    required this.nodes,
  });

  factory DeviceGetByIdResponse.fromJson(Map<String, dynamic> json) {
    try {
      return DeviceGetByIdResponse(
          id: json['id'] ?? '',
          parent: json['parent'] ?? '',
          devId: json['devId'] ?? '',
          name: json['name'] ?? '',
          modelId: json['modelId'] ?? 0,
          modelName: json['modelName'] ?? '',
          owner: json['owner'] ?? '',
          activeappid: json['activeappid'] ?? 0,
          status: json['status'] ?? 0,
          profiles: json['profiles'] ?? [],
          attrs: Attrs.fromJson(json['attrs'] ?? {}),
          vals: DeviceVals.fromJson(json['vals'] ?? {}),
          nodes: List<Node>.from(json['nodes']?.map((node) => Node.fromJson(node)) ?? []));
    } catch (e) {
      throw FormatException('Failed to decode DeviceGetByIdResponse: $e');
    }
  }
}

class Attrs {
  final String timezone;
  final String timezoneVal;

  Attrs({
    required this.timezone,
    required this.timezoneVal,
  });

  factory Attrs.fromJson(Map<String, dynamic> json) {
    return Attrs(
      timezone: json['Timezone'] ?? "",
      timezoneVal: json['Timezone_val'] ?? "",
    );
  }
}

class Node {
  final String devid;
  final String id;
  final String name;
  final int type;
  final String val;
  final Map<String, dynamic> data;
  final Map<String, dynamic> attrs;
  final String ruleType;
  final String rule;

  Node({
    required this.devid,
    required this.id,
    required this.name,
    required this.type,
    required this.val,
    required this.data,
    required this.attrs,
    required this.ruleType,
    required this.rule,
  });

  factory Node.fromJson(Map<String, dynamic> json) {
    return Node(
      devid: json['devid'],
      id: json['id'],
      name: json['name'],
      type: json['type'],
      val: json['val'],
      data: json['data'],
      attrs: json['attrs'],
      ruleType: json['ruleType'],
      rule: json['rule'],
    );
  }
}

class DeviceVals {
  int reqAndInfo3444B8;
  int reqAndInfo3444B9;
  String l2_3457;
  int hb3450;
  String info3441;
  double l2_3460;
  int l2_3449;
  int reqAndInfo3488B8;
  int reqAndInfo3488B9;
  int hb3494;
  String l2_3501;
  double l2_3504;
  int l2_3493;
  String info3485;
  String info3529;
  int reqAndInfo3532B8;
  int reqAndInfo3532B9;
  int hb3538;
  String l2_3545;
  double l2_3548;
  int l2_3537;
  String l2_3540;
  String info3573;
  int reqAndInfo3576B8;
  int reqAndInfo3576B9;
  int hb3582;
  String l2_3589;
  double l2_3592;
  int l2_3581;
  String l2_3584;
  int reqAndInfo3044;
  String reqAndInfo3160;
  String reqAndInfo3168;
  String reqAndInfo3317;
  String reqAndInfo3318;
  double hb3445;
  double hb3455;
  double hb3489;
  double hb3499;
  double hb3533;
  double hb3543;
  double hb3577;
  double hb3587;
  int hb3066;

  DeviceVals({
    required this.reqAndInfo3444B8,
    required this.reqAndInfo3444B9,
    required this.info3441,
    required this.hb3450,
    required this.l2_3457,
    required this.l2_3460,
    required this.l2_3449,
    required this.reqAndInfo3488B8,
    required this.reqAndInfo3488B9,
    required this.hb3494,
    required this.l2_3501,
    required this.l2_3504,
    required this.l2_3493,
    required this.info3529,
    required this.info3485,
    required this.reqAndInfo3532B8,
    required this.reqAndInfo3532B9,
    required this.hb3538,
    required this.l2_3545,
    required this.l2_3548,
    required this.l2_3537,
    required this.l2_3540,
    required this.info3573,
    required this.reqAndInfo3576B8,
    required this.reqAndInfo3576B9,
    required this.hb3582,
    required this.l2_3589,
    required this.l2_3592,
    required this.l2_3581,
    required this.l2_3584,
    required this.reqAndInfo3044,
    required this.reqAndInfo3160,
    required this.reqAndInfo3168,
    required this.reqAndInfo3317,
    required this.reqAndInfo3318,
    required this.hb3445,
    required this.hb3455,
    required this.hb3489,
    required this.hb3499,
    required this.hb3533,
    required this.hb3543,
    required this.hb3577,
    required this.hb3587,
    required this.hb3066
  });

  factory DeviceVals.fromJson(Map<String, dynamic> json) {
    var hb3066;
    var hb3450;
    var hb3494;
    var hb3538;
    var hb3582;
    var hb3445;
    var hb3455;
    var hb3489;
    var hb3499;
    var hb3533;
    var hb3543;
    var hb3577;
    var hb3587;
    if (json['hb_3066'] != null) {
      double? doubleValue = double.tryParse(json['hb_3066']);
      if (doubleValue != null) {
        // 嘗試將浮點數轉換為整數
        hb3066 = doubleValue.toInt();
      }
    }
    if (json['hb_3450'] != null) {
      double? doubleValue = double.tryParse(json['hb_3450']);
      if (doubleValue != null) {
        hb3450 = doubleValue.toInt();
      }
    }
    if (json['hb_3494'] != null) {
      double? doubleValue = double.tryParse(json['hb_3494']);
      if (doubleValue != null) {
        hb3494 = doubleValue.toInt();
      }
    }
    if (json['hb_3538'] != null) {
      double? doubleValue = double.tryParse(json['hb_3538']);
      if (doubleValue != null) {
        hb3538 = doubleValue.toInt();
      }
    }
    if (json['hb_3582'] != null) {
      double? doubleValue = double.tryParse(json['hb_3582']);
      if (doubleValue != null) {
        hb3582 = doubleValue.toInt();
      }
    }
    if (json["hb_3445"] != null && json["hb_3445"] != "") {
      hb3445 = double.tryParse(json["hb_3445"]);
    }

    if (json["hb_3455"] != null && json["hb_3455"] != "") {
      hb3455 = double.tryParse(json["hb_3455"]);
    }

    if (json["hb_3489"] != null && json["hb_3489"] != "") {
      hb3489 = double.tryParse(json["hb_3489"]);
    }

    if (json["hb_3499"] != null && json["hb_3499"] != "") {
      hb3499 = double.tryParse(json["hb_3499"]);
    }

    if (json["hb_3533"] != null && json["hb_3533"] != "") {
      hb3533 = double.tryParse(json["hb_3533"]);
    }

    if (json["hb_3543"] != null && json["hb_3543"] != "") {
      hb3543 = double.tryParse(json["hb_3543"]);
    }

    if (json["hb_3577"] != null && json["hb_3577"] != "") {
      hb3577 = double.tryParse(json["hb_3577"]);
    }

    if (json["hb_3587"] != null && json["hb_3587"] != "") {
      hb3587 = double.tryParse(json["hb_3587"]);
    }

    return DeviceVals(
      reqAndInfo3444B8: int.parse(json['Req_And_Info_3444_B8']) ?? 0,
      reqAndInfo3444B9: int.parse(json['Req_And_Info_3444_B9']) ?? 0,
      info3441: json['info_3441'] ?? "",
      hb3450: hb3450,
      l2_3457: json['L2_3457'] ?? 0,
      l2_3460: double.tryParse(json['L2_3460']) ?? 0,
      l2_3449: int.parse(json['L2_3449']) ?? 0,
      reqAndInfo3488B8: int.parse(json['Req_And_Info_3488_B8']) ?? 0,
      reqAndInfo3488B9: int.parse(json['Req_And_Info_3488_B9']) ?? 0,
      hb3494: hb3494,
      l2_3501: json['L2_3501'] ?? 0,
      l2_3504: double.tryParse(json['L2_3504']) ?? 0,
      l2_3493: int.parse(json['L2_3493']) ?? 0,
      info3529: json['info_3529'] ?? "",
        info3485: json['info_3485'] ?? "",
      reqAndInfo3532B8: int.parse(json['Req_And_Info_3532_B8']) ?? 0,
      reqAndInfo3532B9: int.parse(json['Req_And_Info_3532_B9']) ?? 0,
      hb3538: hb3538,
      l2_3545: json['L2_3545'] ?? 0,
      l2_3548: double.tryParse(json['L2_3548']) ?? 0,
      l2_3537: int.parse(json['L2_3537']) ?? 0,
      l2_3540: json['L2_3540'] ?? "",
      info3573: json['info_3573'] ?? "0",
      reqAndInfo3576B8: int.parse(json['Req_And_Info_3576_B8']) ?? 0,
      reqAndInfo3576B9: int.parse(json['Req_And_Info_3576_B9']) ?? 0,
      hb3582: hb3582,
      l2_3589: json['L2_3589'] ?? 0,
      l2_3592: double.tryParse(json['L2_3592']) ?? 0,
      l2_3581: int.parse(json['L2_3581']) ?? 0,
      l2_3584: json['L2_3584'] ?? "",

      reqAndInfo3044: int.parse(json['Req_And_Info_3044']) ?? 2,
      reqAndInfo3160: json['Req_And_Info_3160'] ?? '0000000000000000',
      reqAndInfo3168: json['Req_And_Info_3168'] ?? '0000000000000000',
      reqAndInfo3317: json['Req_And_Info_3317'] ?? '0000',
      reqAndInfo3318: json['Req_And_Info_3318'] ?? '0000',
      hb3445: hb3445 ?? 0,
      hb3455: hb3455 ?? 0,
      hb3489: hb3489 ?? 0,
      hb3499: hb3499 ?? 0,
      hb3533: hb3533 ?? 0,
      hb3543: hb3543 ?? 0,
      hb3577: hb3577 ?? 0,
      hb3587: hb3587 ?? 0,
      hb3066: hb3066 ?? 0,
    );
  }
}
