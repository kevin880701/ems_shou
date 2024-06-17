import 'package:flutter/cupertino.dart';
import '../../utils/widgets/chart/BaselineBarChart.dart';
import '../../utils/widgets/chart/StackBarChart.dart';
import '../../utils/widgets/chart/SymmetricBarChart.dart';
import '../../utils/widgets/chart/TrendLineChart.dart';
import '../../utils/widgets/chart/VerticalBarChart.dart';
import '../apiResponse/EnergyData.dart';

class ChartType {
  static Widget getChartWidget(String type, Function(bool, List<double>, List<String>, List<String>) onItemTap,
      bool isChartClicked, EnergyListData energyDataList,
      {String? baselineVal, EnergyListData? secondEnergyDataList}) {
    switch (type) {
      case 'stackBarChart':
        return StackBarChart(onItemTap: onItemTap, isChartClicked: isChartClicked);
      // case 'stackBarChart96':
      //   return StackBarChart96(onItemTap: onItemTap, isChartClicked: isChartClicked);
      case 'barChart':
        return VerticalBarChart(
          onItemTap: onItemTap,
          isChartClicked: isChartClicked,
          energyDataList: energyDataList,
          baselineVal: baselineVal,
        );
      case 'symmetricBarChart':
        return SymmetricBarChart(
          onItemTap: onItemTap,
          isChartClicked: isChartClicked,
          energyDataList: energyDataList,
          secondEnergyDataList: secondEnergyDataList,
        );
      case 'trendLineChart':
        return TrendLineChart(
          onItemTap: onItemTap,
          isChartClicked: isChartClicked,
          energyDataList: energyDataList,
          baselineVal: baselineVal,
        );
      case 'baselineBarChart':
        return BaselineBarChart(
          onItemTap: onItemTap,
          isChartClicked: isChartClicked,
          energyDataList: energyDataList,
          baselineVal: baselineVal,
        );
      default:
        return SymmetricBarChart(onItemTap: onItemTap, isChartClicked: isChartClicked, energyDataList: energyDataList);
    }
  }
}
