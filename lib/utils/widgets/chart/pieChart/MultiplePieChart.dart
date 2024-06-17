import 'package:ems_app/define.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../resources/app_colors.dart';

class MultiplePieChart extends StatefulWidget {

  const MultiplePieChart({super.key, required this.chartColor, required this.icon});
  final List<Color> chartColor;
  final String icon;


  @override
  State<StatefulWidget> createState() => _MultiplePieChartState();
}

class _MultiplePieChartState extends State<MultiplePieChart> {
  int touchedIndex = -1;
  late List<Color> colors;

  @override
  Widget build(BuildContext context) {
    colors = widget.chartColor;
    return Container(
      child: SfCircularChart(
        annotations: <CircularChartAnnotation>[
          CircularChartAnnotation(
              widget: Center(
                  child: getImage(widget.icon, height: 24.sp, width: 24.sp)))
        ],
        series: _getDoughnutCustomizationSeries(),
      ),
    );
  }

  /// Return the list of doughnut series which need to be color mapping.
  List<DoughnutSeries<ChartSampleData, String>>
      _getDoughnutCustomizationSeries() {
    return <DoughnutSeries<ChartSampleData, String>>[
      DoughnutSeries<ChartSampleData, String>(
        dataSource: <ChartSampleData>[
          ChartSampleData(x: 'A', y: 24, pointColor: colors[0]),
          ChartSampleData(x: 'B', y: 37, pointColor: colors[1]),
          ChartSampleData(x: 'C', y: 65, pointColor: colors[2]),
          ChartSampleData(x: 'D', y: 10, pointColor: colors[3]),
        ],
        radius: '100%',
        strokeColor: AppColors.white,
        xValueMapper: (ChartSampleData data, _) => data.x as String,
        yValueMapper: (ChartSampleData data, _) => data.y,

        /// The property used to apply the color for each douchnut series.
        pointColorMapper: (ChartSampleData data, _) => data.pointColor,
        dataLabelMapper: (ChartSampleData data, _) => data.x as String,
      ),
    ];
  }
}

class ChartSampleData {
  /// Holds the datapoint values like x, y, etc.,
  ChartSampleData(
      {this.x,
      this.y,
      this.xValue,
      this.yValue,
      this.index,
      this.secondSeriesYValue,
      this.thirdSeriesYValue,
      this.pointColor,
      this.size,
      this.text,
      this.open,
      this.close,
      this.low,
      this.high,
      this.volume});

  /// Holds x value of the datapoint
  final dynamic x;

  /// Holds y value of the datapoint
  final num? y;

  /// Holds x value of the datapoint
  final dynamic xValue;

  /// Holds y value of the datapoint
  final num? yValue;

  final num? index;

  /// Holds y value of the datapoint(for 2nd series)
  final num? secondSeriesYValue;

  /// Holds y value of the datapoint(for 3nd series)
  final num? thirdSeriesYValue;

  /// Holds point color of the datapoint
  final Color? pointColor;

  /// Holds size of the datapoint
  final num? size;

  /// Holds datalabel/text value mapper of the datapoint
  final String? text;

  /// Holds open value of the datapoint
  final num? open;

  /// Holds close value of the datapoint
  final num? close;

  /// Holds low value of the datapoint
  final num? low;

  /// Holds high value of the datapoint
  final num? high;

  /// Holds open value of the datapoint
  final num? volume;
}
