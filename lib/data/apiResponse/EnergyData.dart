import 'dart:convert';

class EnergyListData {
  final List<EnergyData> energyList;

  EnergyListData({required this.energyList});

  factory EnergyListData.fromJson(
      Map<String, dynamic> json, List<String> titleList) {
    var dataList = json['data'] as List<dynamic>;
    List<EnergyData> energies =
        dataList.map((data) => EnergyData.fromJson(data, titleList)).toList();
    return EnergyListData(energyList: energies);
  }
}

class EnergyData {
  final String time;
  final List<String> titleList;
  final List<double?> valueList;

  EnergyData({
    required this.time,
    required this.titleList,
    required this.valueList,
  });

  factory EnergyData.fromJson(
      Map<String, dynamic> json, List<String> titleList) {
    // List<double?> valueList =
    //     titleList.map((title) =>  double.tryParse(json[title].toString())).toList();
    // 目前版本需過濾掉後4個字
    List<double?> valueList =
    titleList.map((title) =>  double.tryParse(json[title.substring(0, title.length - 4)].toString())).toList();
    return EnergyData(
      time: json['time'],
      titleList: titleList,
      valueList: valueList,
    );
  }
}
