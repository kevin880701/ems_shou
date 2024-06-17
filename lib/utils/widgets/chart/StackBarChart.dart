import 'package:ems_app/define.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../resources/app_colors.dart';
import '../Indicator.dart';

class StackBarChart extends StatefulWidget {
  const StackBarChart({super.key, required this.onItemTap, required this.isChartClicked});

  final Function(bool, List<double>, List<String>, List<String>) onItemTap;
  final bool isChartClicked;

  @override
  State<StatefulWidget> createState() => _StackBarChartState();
}

class _StackBarChartState extends State<StackBarChart> {
  late double fieldWidth;
  late double barsWidth;
  int touchedIndex = -1;
  static const mainItems = <int, List<double>>{
    0: [2000, 10000, 5000],
    1: [13000, 2000, 5000],
    2: [6000, 12000, 5000],
    3: [9000, 6000, 14000],
    4: [2000, 15000, 15000],
    5: [2000, 10000, 5000],
    6: [13000, 2000, 5000],
    7: [6000, 12000, 5000],
    8: [9000, 6000, 14000],
    9: [2000, 15000, 15000],
    10: [2000, 10000, 5000],
    11: [13000, 2000, 5000],
    12: [6000, 12000, 5000],
    13: [9000, 6000, 14000],
    14: [2000, 15000, 15000],
    15: [2000, 10000, 5000],
    16: [13000, 2000, 5000],
    17: [6000, 12000, 5000],
    18: [9000, 6000, 14000],
    19: [2000, 15000, 15000],
    20: [2000, 10000, 5000],
    21: [13000, 2000, 5000],
    22: [6000, 12000, 5000],
    23: [9000, 6000, 14000],
    24: [2000, 15000, 15000],
    25: [2000, 10000, 5000],
    26: [13000, 2000, 5000],
    27: [6000, 12000, 5000],
    28: [9000, 6000, 14000],
    29: [2000, 15000, 15000],
  };

  Widget bottomTitles(double value, TitleMeta meta) {
    const style = TextStyle(fontSize: 10);
    String text;
    switch (value.toInt()) {
      case 0:
        text = '1';
        break;
      case 4:
        text = '5';
        break;
      case 9:
        text = '10';
        break;
      case 14:
        text = '15';
        break;
      case 19:
        text = '20';
        break;
      case 24:
        text = '25';
        break;
      case 29:
        text = '30';
        break;
      default:
        text = '';
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(
        text,
        style: style,
        textAlign: TextAlign.left,
      ),
    );
  }

  Function(bool, List<double>, List<String>, List<String>)? onItemTap = (bool isTapped, List<double>? data,
      List<String> times, List<String> titles) {};

  @override
  void initState() {
    onItemTap = widget.onItemTap;
  }


  @override
  void didUpdateWidget(covariant StackBarChart oldWidget) {
    super.didUpdateWidget(oldWidget);
    // 當 isChartClicked 變為 false 時，也就是圖表外部被點擊時，將 touchedIndex 設定為 -1
    if (!widget.isChartClicked!) {
      setState(() {
        touchedIndex = -1;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2.7,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final barsSpace = 2.0 * (constraints.maxWidth / 90);
          barsWidth = 1.0 * (constraints.maxWidth / 90);
          fieldWidth = (barsWidth * 5) + (barsSpace * 5) - 1;
          return Container(
            height: constraints.maxWidth / 2.7,
            child: Column(
              children: [
                Container(
                  height: constraints.maxWidth / 2.7 * 0.8,
                  child: BarChart(
                    BarChartData(
                      alignment: BarChartAlignment.start,
                      barTouchData: BarTouchData(
                        handleBuiltInTouches: false,
                        touchCallback: (FlTouchEvent event, barTouchResponse) {
                          if (event is FlTapDownEvent) {
                            if (!event.isInterestedForInteractions ||
                                barTouchResponse == null ||
                                barTouchResponse.spot == null) {
                              setState(() {
                                onItemTap!(false ,[],[],[]);
                                touchedIndex = -1;
                              });
                              return;
                            }
                            setState(() {
                              touchedIndex = barTouchResponse.spot!.touchedBarGroupIndex;
                              onItemTap!(true, mainItems[touchedIndex]!, [], []);
                            });
                          }
                          print("touchedIndex：${touchedIndex}");
                        },
                      ),
                      titlesData: FlTitlesData(
                        show: true,
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 28,
                            getTitlesWidget: bottomTitles,
                          ),
                        ),
                        leftTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        topTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        rightTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                      ),
                      gridData: FlGridData(
                        show: true,
                        drawHorizontalLine: true,
                        drawVerticalLine: false,
                        horizontalInterval: 32000 / 6,
                        // verticalInterval: 1 / 6,
                        // checkToShowHorizontalLine: (value) => value % 16 == 0,
                        // checkToShowVerticalLine: (value) => value % 0.1 == 0,
                        getDrawingHorizontalLine: (value) {
                          return FlLine(
                            color: Color(0xFFEAEAEA),
                            strokeWidth: 1,
                          );
                        },
                        // getDrawingVerticalLine: (value) {
                        //   return const FlLine(
                        //     color: Color(0xFFEAEAEA),
                        //     strokeWidth: 1,
                        //   );
                        // },
                      ),
                      borderData: FlBorderData(
                        show: true,
                        border: Border.all(color: const Color(0xFFEAEAEA)),
                      ),
                      groupsSpace: barsSpace,
                      barGroups: mainItems.entries
                          .map(
                            (e) =>
                            generateGroup(
                              e.key,
                              e.value[0],
                              e.value[1],
                              e.value[2],
                            ),
                      )
                          .toList(),
                    ),
                  ),
                ),
                Container(
                  height: constraints.maxWidth / 2.7 * 0.2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Indicator(
                        color: Color(0xFFFFE3B9),
                        text: '項目名稱1',
                        isSquare: false,
                        width: 12.w,
                        height: 4.h,
                        textColor: AppColors.primaryBlack,
                      ),
                      Indicator(
                        color: Color(0xFFFFD18B),
                        text: '項目名稱2',
                        isSquare: false,
                        width: 12.w,
                        height: 4.h,
                        textColor: AppColors.primaryBlack,
                      ),
                      Indicator(
                        color: Color(0xFFFFB02F),
                        text: '項目名稱3',
                        isSquare: false,
                        width: 12.w,
                        height: 4.h,
                        textColor: AppColors.primaryBlack,
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  BarChartGroupData generateGroup(int x,
      double value1,
      double value2,
      double value3,) {
    final isTop = value1 > 0;
    final sum = value1 + value2 + value3;
    final isTouched = touchedIndex == x;
    return BarChartGroupData(
      x: x,
      groupVertically: true,
      showingTooltipIndicators: isTouched ? [0] : [],
      barRods: [
        BarChartRodData(
          toY: sum,
          width: barsWidth,
          borderRadius: isTop
              ? const BorderRadius.only(
            topLeft: Radius.circular(6),
            topRight: Radius.circular(6),
          )
              : const BorderRadius.only(
            bottomLeft: Radius.circular(6),
            bottomRight: Radius.circular(6),
          ),
          rodStackItems: [
            BarChartRodStackItem(
              0,
              value1,
              (touchedIndex > -1 && touchedIndex != x)
                  ? Color(0xFFDFDFDF)
                  : Color(0xFFFFE3B9),
              BorderSide(
                color: AppColors.transparent,
              ),
            ),
            BarChartRodStackItem(
              value1,
              value1 + value2,
              (touchedIndex > -1 && touchedIndex != x)
                  ? Color(0xFFC7C7C7)
                  : Color(0xFFFFD18B),
              BorderSide(
                color: AppColors.transparent,
              ),
            ),
            BarChartRodStackItem(
              value1 + value2,
              value1 + value2 + value3,
              (touchedIndex > -1 && touchedIndex != x)
                  ? Color(0xFFB5B5B5)
                  : Color(0xFFFFB02F),
              BorderSide(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
