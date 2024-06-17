import 'package:intl/intl.dart';
import 'package:tuple/tuple.dart';

import '../../define.dart';

class HistoryValueStatisticsRequest {
  String startTime;
  String endTime;
  String fields;
  int interval;
  String titles;

  HistoryValueStatisticsRequest({
    required this.startTime,
    required this.endTime,
    required this.fields,
    required this.interval,
    required this.titles,
  });


  factory HistoryValueStatisticsRequest.requestFromParams(
      String devicePoint, String startTime, String endTime, List<String> fields,
      int interval) {
    try {
      String field = "\$time,$devicePoint:${fields.join(',$devicePoint:')}";
      String titles = "time,${fields.map((field) => '${devicePoint}_$field').join(',')}";

      return HistoryValueStatisticsRequest(startTime: startTime,
          endTime: endTime,
          fields: field,
          interval: interval,
          titles: titles);
    } catch (e) {
      throw FormatException('Failed to decode CardType: $e');
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'startTime': startTime,
      'endTime': endTime,
      'fields': fields,
      'interval': interval,
      'titles': titles,
    };
  }
}

Tuple2<String, String> dayConvertRequest(DateTime date, int timezone){
  String startTime = DateFormat("yyyy-MM-dd'T'HH:mm:ss").format(date.subtract(Duration(seconds: timezone)));
  String endTime = DateFormat("yyyy-MM-dd'T'HH:mm:ss").format(date.subtract(Duration(seconds: timezone)).add(Duration(hours: 24)));

  print("------------chooseDay------------");
  print("startTime：$startTime");
  print("endTime：$endTime");

  return Tuple2(startTime, endTime);
}

Tuple2<String, String> monthConvertRequest(String dateString, int timezone){
  // 解析字串為 DateTime
  DateTime dateTime = DateTime.parse(dateString + '-01');
  DateTime startDateTime = dateTime.subtract(Duration(seconds: timezone));
  DateTime endDateTime = DateTime(dateTime.year, dateTime.month + 1, 1).subtract(Duration(seconds: timezone));

  String startTime = DateFormat("yyyy-MM-dd'T'HH:mm:ss").format(startDateTime);
  String endTime = DateFormat("yyyy-MM-dd'T'HH:mm:ss").format(endDateTime);

  print("------------chooseMonth------------");
  print("startTime：$startTime");
  print("endTime：$endTime");

  return Tuple2(startTime, endTime);
}

Tuple2<String, String> yearConvertRequest(String dateString, int timezone){
  // 將字元串解析為整數，並確保它是有效的年份。
  DateTime dateTime = DateTime(int.parse(dateString), 1, 1);
  DateTime startDateTime = dateTime.subtract(Duration(seconds: timezone));
  DateTime endDateTime = DateTime(int.parse(dateString) + 1, 1, 1).subtract(Duration(seconds: timezone));

  String startTime = DateFormat("yyyy-MM-dd'T'HH:mm:ss").format(startDateTime);
  String endTime = DateFormat("yyyy-MM-dd'T'HH:mm:ss").format(endDateTime);

  print("------------chooseYear------------");
  print("startTime：$startTime");
  print("endTime：$endTime");

  return Tuple2<String, String>(startTime, endTime);
}