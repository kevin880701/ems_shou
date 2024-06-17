
import 'package:flutter/cupertino.dart';

import '../../utils/widgets/chart/pieChart/BaselinePieChart.dart';
import '../../utils/widgets/chart/pieChart/MultiplePieChart.dart';

class PieChartType {
  static Widget getChartWidget(String type, String pieIcon, List<Color> colors, int value) {
    switch (type) {
      case 'multiplePieChart':
        return MultiplePieChart(chartColor: colors, icon: pieIcon);
      case 'baselinePieChart':
        return BaselinePieChart(value: value, chartColor: colors, icon: pieIcon);
      default:
        return Container();
    }
  }
}