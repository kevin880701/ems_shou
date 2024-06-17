import 'dart:convert';
import 'package:ems_app/data/apiResponse/ResponseBase.dart';

import 'CardType.dart';

class WidgetDataResponse extends ResponseBase {
  WidgetDataResponse({required int result, required String data})
      : super(result: result, data: data);

  factory WidgetDataResponse.fromJson(Map<String, dynamic> json) {
    return WidgetDataResponse(
      result: json['result'] ?? 0,
      data: json['data'] ?? "",
    );
  }

  factory WidgetDataResponse.fromString(String source) =>
      WidgetDataResponse.fromJson(jsonDecode(source));
}

class WidgetData {
  final int posX;
  final int posY;
  final int sizeX;
  final int sizeY;
  final CardType? sCardType;
  final CardType? mCardType;
  final String widgetId;
  final CardType? lCardType;
  final int widgetIndex;
  final String defType;

  WidgetData({
    required this.posX,
    required this.posY,
    required this.sizeX,
    required this.sizeY,
    required this.sCardType,
    required this.mCardType,
    required this.widgetId,
    required this.lCardType,
    required this.widgetIndex,
    required this.defType,
  });

  factory WidgetData.fromJson(Map<String, dynamic> json) {
    CardType? sCardType = json['S_cardType'] is! String
        ? CardType.fromJson(json['S_cardType'])
        : null;

    CardType? mCardType = json['M_cardType'] is! String
        ? CardType.fromJson(json['M_cardType'])
        : null;

    CardType? lCardType = json['L_cardType'] is! String
        ? CardType.fromJson(json['L_cardType'])
        : null;

    return WidgetData(
      posX: json['posX'] ?? 0,
      posY: json['posY'] ?? 0,
      sizeX: json['sizeX'] ?? 0,
      sizeY: json['sizeY'] ?? 0,
      sCardType: sCardType,
      mCardType: mCardType,
      widgetId: json['widget_id'] ?? "",
      lCardType: lCardType,
      widgetIndex: json['widget_index'] ?? 0,
      defType: json['def_Type'] ?? "",
    );
  }
}

class WidgetSet {
  final String widgetSetType;
  final List<WidgetData> widgets;

  WidgetSet({
    required this.widgetSetType,
    required this.widgets,
  });

  factory WidgetSet.fromJson(Map<String, dynamic> json) {
    List<WidgetData> widgets = [];
    if (json['widgets'] != null) {
      json['widgets'].forEach((widget) {
        widgets.add(WidgetData.fromJson(widget));
      });
    }
    return WidgetSet(
      widgetSetType: json['widget_set_type'],
      widgets: widgets,
    );
  }
}
