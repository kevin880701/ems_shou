import 'dart:ffi';

import 'package:ems_app/utils/widgets/chart/pieChart/MultiplePieChart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../resources/app_colors.dart';

class StackBarChart2 extends StatefulWidget {
  const StackBarChart2({
    super.key,
  });

  @override
  State<StatefulWidget> createState() => StackBarChart2State();
}

class StackBarChart2State extends State<StackBarChart2> {
  TooltipBehavior? _tooltipBehavior;
  Color firstColor = Colors.red;
  static const mainItems = <int, List<double>>{
    0: [2000, 10000, 5000],
    1: [13000, 2000, 5000],
    2: [6000, 12000, 5000],
    3: [9000, 6000, 14000]
  };

  var chartData = <ChartSampleData>[
    ChartSampleData(
        x: 'Q1',
        y: 50,
        yValue: 55,
        index: 0,
        secondSeriesYValue: 72,
        thirdSeriesYValue: 65),
    ChartSampleData(
        x: 'Q2',
        y: 80,
        yValue: 75,
        index: 1,
        secondSeriesYValue: 70,
        thirdSeriesYValue: 60),
    ChartSampleData(
        x: 'Q3',
        y: 35,
        yValue: 45,
        index: 2,
        secondSeriesYValue: 55,
        thirdSeriesYValue: 52),
    ChartSampleData(
        x: 'Q4',
        y: 65,
        yValue: 50,
        index: 3,
        secondSeriesYValue: 70,
        thirdSeriesYValue: 65),
  ];

  int _pointIndex = -1;

  @override
  Widget build(BuildContext context) {
    _tooltipBehavior =
        TooltipBehavior(enable: true, header: '', canShowMarker: true);

    return SfCartesianChart(
      plotAreaBorderWidth: 2,
      primaryXAxis: const CategoryAxis(
        majorGridLines: MajorGridLines(width: 0),
      ),
      primaryYAxis: const NumericAxis(
          axisLine: AxisLine(width: 0),
          labelFormat: '{value}K',
          maximum: 300,
          majorTickLines: MajorTickLines(size: 0)),

      onSelectionChanged: (SelectionArgs args) {
        setState(() {
          _pointIndex = args.pointIndex;
          print("pointIndex：" + args.pointIndex.toString());
          print("_pointIndex：" + _pointIndex.toString());
        });
        // print("pointIndex：" + args.pointIndex.toString());
        // args.selectedColor = Colors.red;
        // args.unselectedColor = Colors.lightGreen;
      },
      // onAxisLabelTapped: (AxisLabelTapArgs args) => print("AAAAAAAAAA"),
      // onChartTouchInteractionUp: (ChartTouchInteractionArgs args){
      //   print(args.position.dx.toString());
      //   print(args.position.dy.toString());
      // },
      series: _getStackedColumnSeries(),
      tooltipBehavior: _tooltipBehavior,
    );
  }

  List<StackedColumnSeries<ChartSampleData, String>> _getStackedColumnSeries() {
    return <StackedColumnSeries<ChartSampleData, String>>[
      StackedColumnSeries<ChartSampleData, String>(
          selectionBehavior: SelectionBehavior(
            enable: true,
            // selectedColor: Color(0xFFFFE399),
            // selectedBorderColor: AppColors.white,
            // unselectedColor: Color(0xFFEBEBEB),
            unselectedOpacity: 1,
          ),
          color: (_pointIndex > -1 && _pointIndex == chartData[0].index)
              ? () {
            print('Condition is true!');
            return Color(0xFFFFE399);
          }()
              : () {
            print('Condition is false!${_pointIndex},${chartData[0].index}');
            return Color(0xFFEBEBEB);
          }(),
          dataSource: chartData,
          borderWidth: 2,
          borderColor: AppColors.white,
          xValueMapper: (ChartSampleData sales, index) {
            // print("sales.x" + sales.x.toString());
            // print("sales.index" + index.toString());
            return sales.x as String;
          },
          yValueMapper: (ChartSampleData sales, index) => sales.y,
          name: 'Product A'),
      StackedColumnSeries<ChartSampleData, String>(
          selectionBehavior: SelectionBehavior(
            enable: true,
            // selectedColor: Color(0xFFFFE399),
            // unselectedColor: Color(0xFFC2C2C2),
            unselectedOpacity: 1,
          ),

          color: (_pointIndex > -1 && _pointIndex == chartData[1].index)
              ? () {
            print('Condition is true!${_pointIndex},${chartData[1].index}');
            return Color(0xFFFFD466);
          }()
              : () {
            print('Condition is false!${_pointIndex},${chartData[1].index}');
            return Color(0xFFC2C2C2);
          }(),
          dataSource: chartData,
          borderWidth: 2,
          borderColor: AppColors.white,
          xValueMapper: (ChartSampleData sales, _) => sales.x as String,
          yValueMapper: (ChartSampleData sales, _) => sales.yValue,
          name: 'Product B'),
      StackedColumnSeries<ChartSampleData, String>(
          selectionBehavior: SelectionBehavior(
            enable: true,
            // selectedColor: Color(0xFFFFE399),
            // unselectedColor: Color(0xFFADADAD),
            unselectedOpacity: 1,
          ),

          color: (_pointIndex > -1 && _pointIndex == chartData[2].index)
              ? () {
            print('Condition is true!${_pointIndex},${chartData[2].index}');
            return Color(0xFFFFC633);
          }()
              : () {
            print('Condition is false!${_pointIndex},${chartData[2].index}');
            return Color(0xFFADADAD);
          }(),
          dataSource: chartData,
          borderWidth: 2,
          borderColor: AppColors.white,
          xValueMapper: (ChartSampleData sales, _) => sales.x as String,
          yValueMapper: (ChartSampleData sales, _) => sales.secondSeriesYValue,
          name: 'Product C'),
      StackedColumnSeries<ChartSampleData, String>(
          selectionBehavior: SelectionBehavior(
            enable: true,
            // selectedColor: Color(0xFFFFE399),
            // unselectedColor: Color(0xFF999999),
            unselectedOpacity: 1,
          ),

          color: (_pointIndex > -1 && _pointIndex == chartData[3].index)
              ? () {
            print('Condition is true!${_pointIndex},${chartData[3].index}');
            return Color(0xFFFFB800);
          }()
              : () {
            print('Condition is false!${_pointIndex},${chartData[3].index}');
            return Color(0xFF999999);
          }(),
          dataSource: chartData,
          borderWidth: 2,
          borderColor: AppColors.white,
          xValueMapper: (ChartSampleData sales, _) => sales.x as String,
          yValueMapper: (ChartSampleData sales, _) => sales.thirdSeriesYValue,
          name: 'Product D')
    ];
  }
}
