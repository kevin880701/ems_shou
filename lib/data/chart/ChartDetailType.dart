import 'package:flutter/cupertino.dart';
import '../../screen/BaseChartDetailState.dart';
import '../../utils/widgets/chart/info/BaselineBarChartInfo.dart';
import '../../utils/widgets/chart/info/SymmetricBarChartInfo.dart';
import '../../utils/widgets/chart/info/TrendLineChartInfo.dart';
import '../../utils/widgets/chart/info/VerticalBarChartInfo.dart';
import 'ChartInfo.dart';

class ChartDetailType {
  static Widget getChartDetailWidget(
    GlobalKey<BaseChartDetailState> key,
    String type,
    List<String> times,
    List<double> values,
    List<String> titles,
    ChartInfo chartInfo,
    String timeFormat,
  ) {
    switch (type) {
      case 'stackBarChart':
        return BaselineBarChartInfo(
            key: key,
            values: values,
            titles: titles,
            times: times,
            chartInfo: chartInfo,
            timeFormat: timeFormat);
      case 'barChart':
        return VerticalBarChartInfo(
            key: key,
            values: values,
            titles: titles,
            times: times,
            chartInfo: chartInfo,
            timeFormat: timeFormat);
      case 'symmetricBarChart':
        return SymmetricBarChartInfo(
            key: key,
            values: values,
            titles: titles,
            times: times,
            chartInfo: chartInfo,
            timeFormat: timeFormat);
      case 'trendLineChart':
        return TrendLineChartInfo(
            key: key,
            values: values,
            titles: titles,
            times: times,
            chartInfo: chartInfo,
            timeFormat: timeFormat);
      case 'baselineBarChart':
        return BaselineBarChartInfo(
            key: key,
            values: values,
            titles: titles,
            times: times,
            chartInfo: chartInfo,
            timeFormat: timeFormat);
      case 'symmetricBarChart':
        return BaselineBarChartInfo(
            key: key,
            values: values,
            titles: titles,
            times: times,
            chartInfo: chartInfo,
            timeFormat: timeFormat);
      default:
        return BaselineBarChartInfo(
            key: key,
            values: values,
            titles: titles,
            times: times,
            chartInfo: chartInfo,
            timeFormat: timeFormat);
    }
  }
}
