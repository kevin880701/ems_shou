import 'package:tuple/tuple.dart';

class CardType {
  int? lastVal = null;
  final String sTitle;
  final int sizeX;
  String? unit = null;
  String? showIcon = null;
  final String dataNode;
  String? widgetId = null;
  final String widgetType;
  dynamic? dataMax = null; // 可能為String或int
  final String? noteInfo;
  final String title;
  final int sizeY;
  String? baselineVal = null;
  String? alertNote = null;
  String? alertOrNot = null;
  final dynamic triggers; // 可能為String或List<String>
  String? alertType = null;
  String? baselineType = null;
  String? reportConfig = null;
  String? chartOpType = null;
  List<String>? chartDataNodes = null;
  String? dataSearchType = null;

  CardType({
    this.lastVal,
    required this.sTitle,
    required this.sizeX,
    required this.unit,
    required this.showIcon,
    required this.dataNode,
    required this.widgetId,
    required this.widgetType,
    required this.dataMax,
    required this.noteInfo,
    required this.title,
    required this.sizeY,
    this.baselineVal,
    this.alertNote,
    this.alertOrNot,
    this.triggers,
    this.alertType,
    this.baselineType,
    this.reportConfig,
    this.chartOpType,
    this.chartDataNodes,
    this.dataSearchType,
  });

  factory CardType.fromJson(Map<String, dynamic> json) {
    try {
      return CardType(
        lastVal: json['last_val'] ?? null,
        sTitle: json['s_title'] ?? "",
        sizeX: json['sizeX'] ?? 0,
        unit: json['unit'] ?? null,
        showIcon: json['show_icon'] ?? null,
        dataNode: json['data_node'] ?? "",
        widgetId: json['widget_id'] ?? null,
        widgetType: json['widget_Type'] ?? "",
        dataMax: json['data_max'] ?? null,
        noteInfo: json['note_info'] ?? null,
        title: json['title'] ?? "",
        sizeY: json['sizeY'] ?? 0,
        baselineVal: json['baseline_val'] ?? null,
        alertNote: json['alert_note'] ?? null,
        alertOrNot: json['alert_or_Not'] ?? null,
        triggers: json['triggers'] ?? null,
        alertType: json['alert_type'] ?? null,
        baselineType: json['baseline_type'] ?? null,
        reportConfig: json['report_config'] ?? null,
        chartOpType: json['chart_op_Type'] ?? null,
        chartDataNodes: json['chartDataNodes'] ?? null,
        dataSearchType: json['data_search_type'] ?? null,
      );
    } catch (e) {
      throw FormatException('Failed to decode CardType: $e');
    }
  }

  ///
  /// 根據傳入的 widgetType ，判斷傳入的字串是否包含指定類型字串，不區分大小寫
  ///
  /// 返回值：
  ///   如果不包含'_date'和'_text'，且包含上述指定類型的小部件類型之一，則返回 true；否則返回 false。
  ///
  bool isShowWidget() {
    // 判斷傳入的字串是否包含指定類型字串，不區分大小寫
    return !widgetType.toLowerCase().contains('_date') &&
        !widgetType.toLowerCase().contains('_text') &&
        (widgetType.toLowerCase().contains('bar_line') ||
            widgetType.toLowerCase().contains('_bar') ||
            widgetType.toLowerCase().contains('dashboard_') ||
            widgetType.toLowerCase().contains('_area'));
  }

  ///
  /// 用於切割欄位data_node，
  ///
  /// 返回值：
  ///   Tuple2<設備, 點位>
  ///
  Tuple2<String, String> getDeviceAndPoint() {
    if (dataNode.isNotEmpty) {
      List<String> node = dataNode.split('NODE');
      Tuple2<String, String> deviceAndNode = Tuple2(node[0], node[1]);
      return deviceAndNode;
    } else {
      print('SCardType is Empty');
      return Tuple2<String, String>("", "");
    }
  }
}
