import 'dart:convert';

class TriggerAddBody {
  final String triggerId;
  final String owner;
  final int ownerType;
  final int appId;
  String name;
  final String descript;
  final String triggerType;
  final List<String> triggerDevs;
  final Map<dynamic, dynamic> triggerArgs;
  final Map<dynamic, dynamic> attrs;
  final int actionType;
  final String actionScript;
  final BuilderInfo builderInfo;
  final Map<dynamic, dynamic> actionArgs;
  final String enabled;

  TriggerAddBody({
    required this.triggerId,
    required this.owner,
    this.ownerType = 0,
    this.appId = 0,
    required this.name,
    this.descript = "EnergyStorageCabinetTrigger",
    this.triggerType = "EnergyStorageCabinetTrigger",
    required this.triggerDevs,
    this.triggerArgs = const {},
    this.attrs = const {},
    this.actionType = 3,
    this.actionScript = "",
    required this.builderInfo,
    this.actionArgs = const {},
    this.enabled = "1",
  });

  String toJson() {
    Map<String, dynamic> jsonMap = {
      'triggerid': triggerId ?? "",
      'owner': owner ?? "",
      'ownertype': ownerType ?? 0,
      'appid': appId ?? 0,
      'name': name ?? "",
      'descript': descript,
      'triggertype': triggerType,
      'triggerdevs': triggerDevs ?? [],
      'triggerargs': triggerArgs ?? {},
      'attrs': attrs ?? {},
      'actionType': actionType ?? 3,
      'actionScript': actionScript ?? "",
      'builderInfo': builderInfo.toJson(),
      'actionargs': actionArgs ?? {},
      'enabled': enabled ?? "1",
    };
    return jsonEncode(jsonMap);
  }

  factory TriggerAddBody.createRequest({
    required String triggerId,
    required String owner,
    required String name,
    required List<String> triggerDevs,
    required List<String> uids,
    required String type,
    required String devid,
    required String type2,
    required String type3,
  }) {
    final builderInfo = BuilderInfo(
      args: BuilderInfoArgs(
        actions: [
          // BuilderInfoAction(
          //   args: ActionsArgs1(
          //     uids: uids,
          //   ),
          //   type: type,
          // ),
          BuilderInfoAction(
            args: ActionsArgs2(
              devid: devid,
            ),
            type: type2,
          ),
          BuilderInfoAction(
            args: ActionsArgs3(
              devid: devid,
            ),
            type: type3,
          ),
        ],
      ),
    );

    return TriggerAddBody(
      triggerId: triggerId,
      owner: owner,
      name: name,
      triggerDevs: triggerDevs,
      builderInfo: builderInfo,
    );
  }
}

class BuilderInfo {
  final BuilderInfoArgs args;
  final String type;

  BuilderInfo({
    required this.args,
    this.type = "SequentialAction",
  });

  Map<String, dynamic> toJson() {
    return {
      "args": args != null ? args.toJson() : null,
      "type": type,
    };
  }
}


class BuilderInfoArgs {
  final List<BuilderInfoAction> actions;

  BuilderInfoArgs({
    required this.actions,
  });

  Map<String, dynamic> toJson() {
    return {
      "actions": actions != null ? actions.map((action) => action.toJson()).toList() : [],
    };
  }
}

class BuilderInfoAction {
  final ActionsArgs  args;
  final String type;

  BuilderInfoAction({
    required this.args,
    required this.type,
  });


  Map<String, dynamic> toJson() {
    return {
      "args": args.toJson(),
      "type": type ?? "",
    };
  }
}

abstract class ActionsArgs {
  Map<String, dynamic> toJson();
}


class ActionsArgs1 extends ActionsArgs {
  final String msg;
  final Map<String, dynamic> msgArgs;
  final Map<String, dynamic> data;
  final List<String> uids;
  final List<String> pushTypes;
  final String title;

  ActionsArgs1({
    this.msg = "{\$errorMessageBody}",
    this.msgArgs = const {},
    this.data = const {},
    required this.uids,
    this.pushTypes = const ["fcm2"],
    this.title = "FCM2 Title",
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      "msg": msg,
      "msgArgs": msgArgs,
      "data": data,
      "uids": uids,
      "pushTypes": pushTypes,
      "title": title,
    };
  }
}

class ActionsArgs2 extends ActionsArgs {
  final String devid;
  final String msg;
  final String odata1;
  final String odata2;
  final String mainlogtype;
  final String sublogtype;
  final String detaillogtype;
  final String oid1;
  final int oid1type;
  final String oid2;
  final int oid2type;
  final String oid3;
  final int oid3type;
  final int level;

  ActionsArgs2({
    required this.devid,
    this.msg = "{\$errorMessageBody}",
    this.odata1 = "",
    this.odata2 = "",
    this.mainlogtype = "System",
    this.sublogtype = "debug",
    this.detaillogtype = "LogDetail",
    this.oid1 = "",
    this.oid1type = 0,
    this.oid2 = "",
    this.oid2type = 0,
    this.oid3 = "",
    this.oid3type = 0,
    this.level = 0,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      "devid": devid,
      "msg": msg,
      "odata1": odata1,
      "odata2": odata2,
      "mainlogtype": mainlogtype,
      "sublogtype": sublogtype,
      "detaillogtype": detaillogtype,
      "oid1": oid1,
      "oid1type": oid1type,
      "oid2": oid2,
      "oid2type": oid2type,
      "oid3": oid3,
      "oid3type": oid3type,
      "level": level,
    };
  }
}

class ActionsArgs3 extends ActionsArgs {
  final String devid;
  final String msg;
  final Map<String, dynamic> attrs;
  final int level;

  ActionsArgs3({
    required this.devid,
    this.msg = "{\$errorMessageBody}",
    this.attrs = const {},
    this.level = 0,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      "devid": devid,
      "msg": msg,
      "attrs": attrs,
      "level": level,
    };
  }
}