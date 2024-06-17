import 'package:ems_app/define.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../data/apiResponse/EnergyData.dart';
import '../../../resources/app_colors.dart';
import '../Indicator.dart';

class SymmetricBarChart extends StatefulWidget {
  const SymmetricBarChart(
      {super.key,
      required this.onItemTap,
      required this.isChartClicked,
      required this.energyDataList,
      this.secondEnergyDataList});

  final Function(bool, List<double>, List<String>) onItemTap;
  final bool isChartClicked;
  final EnergyListData energyDataList;
  final EnergyListData? secondEnergyDataList;

  @override
  State<StatefulWidget> createState() => _SymmetricBarChartState();
}

class _SymmetricBarChartState extends State<SymmetricBarChart> {
  double barsWidth = 4.0; // 長條圖長條寬度
  late double barsSpace; // 長條圖長條間距
  double maxYValue = 20.0; // 圖表Y軸最大值
  Function(bool, List<double>, List<String>)? onItemTap =
      (bool isTapped, List<double>? data, List<String> times) {};

  // 長條圖資料
  List<BarChartGroupData> barDataList = [];

  // 長條圖值列表（用於點擊後回傳值）
  List<List<double>> barValueList = [];

  // 時間列表（用於點擊後回傳值）
  List<String> timeList = [];
  int touchedIndex = -1;

  @override
  void initState() {
    super.initState();
    onItemTap = widget.onItemTap;
  }

  @override
  void didUpdateWidget(covariant SymmetricBarChart oldWidget) {
    super.didUpdateWidget(oldWidget);
    // 當 isChartClicked 變為 false 時，也就是圖表外部被點擊時，將 touchedIndex 設定為 -1取消圖表的點擊效果
    if (!widget.isChartClicked!) {
      setState(() {
        touchedIndex = -1;
      });
    }
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    String text = '';
    // 顯示X軸提示條件：value加一後除以5的餘數是否為0，並且同時檢查value是否等於第一筆或最後一筆
    if ((value + 1) % 5 == 0 || value == barDataList.length - 1 || value == 0) {
      text = addLeadingZero((value + 1.0).toInt().toString());
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: getText(text, fontSize: 10.sp, color: AppColors.primaryBlack),
    );
  }

  BarChartGroupData generateGroup(
    int x,
    double value1,
    double value2,
    double value3,
  ) {
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
          borderRadius: const BorderRadius.all(Radius.circular(6)),
          rodStackItems: [
            BarChartRodStackItem(
              0,
              value1,
              (touchedIndex > -1 && touchedIndex != x)
                  ? Color(0xFFDFDFDF)
                  : Color(0xFF5BA2EB),
              const BorderSide(
                width: 1,
                color: AppColors.white,
              ),
            ),
            BarChartRodStackItem(
              value1,
              value1 + value2,
              (touchedIndex > -1 && touchedIndex != x)
                  ? Color(0xFFB5B5B5)
                  : Color(0xFF34D491),
              const BorderSide(
                width: 1,
                color: AppColors.white,
              ),
            ),
            BarChartRodStackItem(
              value1 + value2,
              value1 + value2 + value3,
              (touchedIndex > -1 && touchedIndex != x)
                  ? Color(0xFFC7C7C7)
                  : Color(0xFFFFAA7A),
              const BorderSide(
                width: 0.5,
                color: AppColors.white,
              ),
            ),
          ],
        ),
      ],
    );
  }

  bool isShadowBar(int rodIndex) => rodIndex == 1;

  @override
  Widget build(BuildContext context) {
    // 建立圖表資料
    initData();

    return AspectRatio(
      aspectRatio: 2.7,
      child: LayoutBuilder(
        builder: (context, constraints) {
          barsSpace =
              (constraints.maxWidth - (barDataList.length * barsWidth)) /
                  (barDataList.length);
          return Container(
              height: constraints.maxWidth / 2.7,
              child: Column(
                children: [
                  Container(
                    height: constraints.maxWidth / 2.7 * 0.8,
                    child: BarChart(
                      BarChartData(
                        alignment: BarChartAlignment.center,
                        maxY: maxYValue,
                        minY: -maxYValue,
                        groupsSpace: 12,
                        barTouchData: BarTouchData(
                          touchTooltipData: BarTouchTooltipData(
                            tooltipBgColor: AppColors.milkOrange,
                            getTooltipItem: (group, groupIndex, rod, rodIndex) {
                              return null;
                            },
                          ),
                          handleBuiltInTouches: false,
                          touchCallback:
                              (FlTouchEvent event, barTouchResponse) {
                            if (event is FlTapDownEvent) {
                              print("###：FlTapDownEvent");

                              if (!event.isInterestedForInteractions ||
                                  barTouchResponse == null ||
                                  barTouchResponse.spot == null) {
                                setState(() {
                                  onItemTap!(false, [], []);
                                  touchedIndex = -1;
                                });
                                return;
                              }
                              setState(() {
                                touchedIndex =
                                    barTouchResponse.spot!.touchedBarGroupIndex;

                                onItemTap!(true, barValueList[touchedIndex],
                                    [timeList[touchedIndex]]);
                              });
                            }
                            print("touchedIndex：${touchedIndex}");
                          },
                        ),
                        titlesData: FlTitlesData(
                          show: true,
                          topTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 32,
                              getTitlesWidget: bottomTitles,
                            ),
                          ),
                          leftTitles: const AxisTitles(
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
                          horizontalInterval: maxYValue / 3,
                          verticalInterval: 1 / 6,
                          getDrawingHorizontalLine: (value) {
                            return FlLine(
                              color: Color(0xFFEAEAEA),
                              strokeWidth: 1,
                            );
                          },
                          getDrawingVerticalLine: (value) {
                            return const FlLine(
                              color: Color(0xFFEAEAEA),
                              strokeWidth: 1,
                            );
                          },
                        ),
                        borderData: FlBorderData(
                          show: true,
                          border: Border.all(
                            color: AppColors.borderGrey,
                          ),
                        ),
                        barGroups: barDataList,
                      ),
                    ),
                  ),
                  Container(
                    height: constraints.maxWidth / 2.7 * 0.2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Indicator(
                          color: Color(0xFF5BA2EB),
                          text: '市電',
                          isSquare: false,
                          width: 12.w,
                          height: 4.h,
                          textColor: AppColors.primaryBlack,
                        ),
                        Indicator(
                          color: Color(0xFF34D491),
                          text: '綠電',
                          isSquare: false,
                          width: 12.w,
                          height: 4.h,
                          textColor: AppColors.primaryBlack,
                        ),
                        Indicator(
                          color: Color(0xFFFFAA7A),
                          text: '儲能櫃',
                          isSquare: false,
                          width: 12.w,
                          height: 4.h,
                          textColor: AppColors.primaryBlack,
                        ),
                      ],
                    ),
                  )
                ],
              ));
        },
      ),
    );
  }

  void initData() {
    // 建立長條圖資料
    barDataList.clear();
    barValueList.clear();
    timeList.clear();
    maxYValue = 20.0;
    for (int index = 0;
        index < widget.energyDataList.energyList.length;
        index++) {
      List<double> values = [];
      for (double? value in widget.energyDataList.energyList[index].valueList) {
        values.add(value != null ? value : 0);
      }

      double sum = values.reduce((value, element) => value + element);
      if (maxYValue < sum) {
        maxYValue = sum;
      } else if (maxYValue < (sum * -1)) {
        maxYValue = -sum;
      }
      String time = widget.energyDataList.energyList[index].time.toString();
      barDataList.add(generateGroup(index, values[0], values[1], values[2]));
      barValueList.add(values);
      timeList.add(time);
    }
    maxYValue = maxYValue * 1.2;
  }
}
