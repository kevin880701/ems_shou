class DeviceEnergyData {
  final String kwh;
  final String kwhDay;
  final String kwhHour;
  final String kwhMonth;
  final String kwhYear;
  final String freq;
  final String time;

  DeviceEnergyData({
    required this.kwh,
    required this.kwhDay,
    required this.kwhHour,
    required this.kwhMonth,
    required this.kwhYear,
    required this.freq,
    required this.time,
  });

  factory DeviceEnergyData.fromJson(Map<String, dynamic> json) {
    return DeviceEnergyData(
      kwh: json['KWH'] ?? "",
      kwhDay: json['KWHDay'] ?? "",
      kwhHour: json['KWHHour'] ?? "",
      kwhMonth: json['KWHMonth'] ?? "",
      kwhYear: json['KWHYear'] ?? "",
      freq: json['freq'] ?? "",
      time: json['time'] ?? "",
    );
  }
}