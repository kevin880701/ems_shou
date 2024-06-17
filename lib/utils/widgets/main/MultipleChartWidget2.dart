import 'package:ems_app/define.dart';
import 'package:ems_app/resources/app_texts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';
import '../../../data/chart/ChartDetailType.dart';
import '../../../data/chart/ChartType.dart';
import '../../../data/chart/PieChartType.dart';
import '../../../data/apiRequest/HistoryValueStatisticsRequest.dart';
import '../../../data/apiResponse/EnergyData.dart';
import '../../../data/chart/ChartConfig.dart';
import '../../../resources/app_colors.dart';
import '../../../screen/BaseChartDetailState.dart';
import '../../../viewModel/EnergyStorageViewModel.dart';
import '../../dialog/DialogManager.dart';
import '../../dialog/window/PickerDateDialog.dart';

enum ChartStatus { error, success, loading }

class MultipleChartWidget2 extends StatefulWidget {
  final String title;
  final String subTitle;

  const MultipleChartWidget2({
    super.key,
    required this.title,
    required this.subTitle,
  });

  @override
  _MultipleChartWidget2 createState() => _MultipleChartWidget2();
}

class _MultipleChartWidget2 extends BasePageState<MultipleChartWidget2> with SingleTickerProviderStateMixin {
  GlobalKey<BaseChartDetailState> chartDetailStateKey = GlobalKey<BaseChartDetailState>();
  int selectedIndex = -1;
  late Function(bool, List<double>, List<String>, List<String>) onItemTap;
  bool _isChartClicked = false;
  bool isFirst = true;
  late ChartConfig chartConfig;
  EnergyStorageViewModel energyStorageViewModel = EnergyStorageViewModel.instance;
  late String startTime;
  late String endTime;
  late List<String> fields;
  late int interval;
  late EnergyListData energyDataList = EnergyListData(energyList: []);
  late EnergyListData? secondEnergyDataList;
  String date = ''; // 顯示選擇的日期
  var currentDevId = '';
  String timeFormat = "day";
  ChartStatus chartStatus = ChartStatus.loading;

  // 獲取當前日期時間
  DateTime now = DateTime.now();
  late DateTime? chooseDay;
  String? chooseMonth;
  String? chooseYear;

  // dialog param
  int dateSwitcherIndex = 0;

  // 目前打API取到的時間比較久，而且會不一定。為了避免後面的資料被前面取代需用dateSwitcherIndex來識別。dateSwitcherIndex只會一直遞增
  int _lastRequestId = 0;

  // 點擊圖表後顯示的細節資料
  List<String> detailTimes = [];
  List<double> detailValues = [];
  List<String> detailTitles = [];

  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    )..repeat();
    // 要去掉時分秒
    now = now.subtract(Duration(
        hours: now.hour,
        minutes: now.minute,
        seconds: now.second,
        milliseconds: now.millisecond,
        microseconds: now.microsecond));

    date = DateFormat("yyyy-MM-dd").format(now);
    chooseDay = now;

    chartConfig = ChartConfig.fromWidgetType("");
    interval = 2;

    onItemTap = (bool isChartClicked, List<double> values, List<String> times, List<String> titles) {
      setState(() {
        _isChartClicked = isChartClicked;
        if (_isChartClicked) {
          detailTimes = times;
          detailValues = values;
          detailTitles = titles;
          chartDetailStateKey.currentState?.updateData(detailTimes, detailValues, chartConfig.chartInfo, timeFormat);
        } else {
          detailTimes.clear();
          detailValues.clear();
          detailTitles.clear();
        }
      });
    };

    _chooseDate(now, null, null, dateSwitcherIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<EnergyStorageViewModel>(builder: (context, energyStorageViewModel, _) {
      if (energyStorageViewModel.updateStatus == UpdateStatus.updateData) {
        fetchData();
        _isChartClicked = false;
      }

      return GestureDetector(
          onTap: () {
            setState(() {
              _isChartClicked = false;
            });
          },
          child: Container(
            padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24.r),
              color: AppColors.white,
            ),
            child: Column(
              children: [
                Container(
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            getText(widget.title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.start,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                color: AppColors.grey),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 8.0),
                                  child: getText(widget.subTitle, fontSize: 16.sp, color: AppColors.primaryBlack),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      getText(
                                          (energyStorageViewModel.batteryInformation != null)
                                              ? energyStorageViewModel.batteryInformation!.vals.hb3066.toString()
                                              : "",
                                          fontSize: 28.sp,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.primaryBlack),
                                      getText(AppTexts.percent,
                                          textAlign: TextAlign.right,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.grey),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        height: 84.sp,
                        width: 84.sp,
                        child: PieChartType.getChartWidget(
                          chartConfig.pieChartType,
                          chartConfig.chartInfo.iconPath,
                          chartConfig.chartInfo.colors,
                          (energyStorageViewModel.batteryInformation != null)
                              ? (energyStorageViewModel.batteryInformation!.vals.hb3066 != null)
                                  ? energyStorageViewModel.batteryInformation!.vals.hb3066!
                                  : 0
                              : 0,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 24.h,
                ),
                if (chartConfig.hasChart)
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: dateButtonWidget(context),
                          ),
                          SizedBox(
                            width: 8.sp,
                          ),
                          IgnorePointer(
                            ignoring: false,
                            child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    addSubtractClick(false);
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.all(18.sp),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(color: AppColors.borderGrey, width: 1)),
                                  child: getImageIcon("arrow_left.png",
                                      height: 18.sp, width: 18.sp, color: AppColors.grey),
                                )),
                          ),
                          SizedBox(
                            width: 8.sp,
                          ),
                          IgnorePointer(
                            ignoring: false,
                            child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    addSubtractClick(true);
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.all(18.sp),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(color: AppColors.borderGrey, width: 1)),
                                  child: getImageIcon("arrow_right.png",
                                      height: 18.sp, width: 18.sp, color: AppColors.grey),
                                )),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 18.h,
                      ),
                      _buildChart(),
                      SizedBox(
                        height: 18.h,
                      ),
                    ],
                  ),
                if (chartConfig.chartType != null)
                  Visibility(
                      visible: (chartConfig.isAlwaysShowDetail || (_isChartClicked && !chartConfig.isAlwaysShowDetail)),
                      child: ChartDetailType.getChartDetailWidget(chartDetailStateKey, chartConfig.chartType!,
                          detailTimes, detailValues, detailTitles, chartConfig.chartInfo, timeFormat)),
              ],
            ),
          ));
    });
  }

  Widget _buildChart() {
    switch (chartStatus) {
      case ChartStatus.success:
        return Container(
          child: ChartType.getChartWidget(
            "symmetricBarChart",
            onItemTap,
            _isChartClicked,
            energyDataList,
            secondEnergyDataList: secondEnergyDataList,
          ),
        );
      case ChartStatus.loading:
        return Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              getText(AppTexts.chartLoading, fontSize: 20),
              AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Opacity(
                        opacity: _controller.value < 0.3 ? 0 : 1,
                        child: getText(".", fontSize: 20, fontWeight: FontWeight.w400),
                      ),
                      Opacity(
                        opacity: _controller.value < 0.6 ? 0 : 1,
                        child: getText(".", fontSize: 20, fontWeight: FontWeight.w400),
                      ),
                      Opacity(
                        opacity: _controller.value < 0.9 ? 0 : 1,
                        child: getText(".", fontSize: 20, fontWeight: FontWeight.w400),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        );
      case ChartStatus.error:
      default:
        return GestureDetector(
          onTap: () {fetchData();},
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                getText(AppTexts.chartLoadingFailed, fontSize: 20, color: Colors.red),
                getImageIcon('reload.png', color: AppColors.red, width: 28.sp, height: 28.sp),
              ],
            ),
          ),
        );
    }
  }

  Widget iconButtonWidget(String image, Color color) {
    return Container(
      padding: EdgeInsets.all(12.sp),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderGrey),
      ),
      child: Row(
        children: [
          getImageIcon(image, width: 24.w, height: 24.h, color: color),
        ],
      ),
    );
  }

  Widget dateButtonWidget(BuildContext context) {
    return InkWell(
      onTap: () {
        _isChartClicked = false;
        showPickerDateDialog(
          context,
          PickerDateDialog(
            chooseDay: chooseDay,
            chooseMonth: chooseMonth,
            chooseYear: chooseYear,
            chooseDate: _chooseDate,
            dateSwitcherIndex: dateSwitcherIndex,
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(12.sp),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.borderGrey),
        ),
        child: Row(
          children: [
            getImageIcon('calendar.png', width: 24.w, height: 24.h, color: AppColors.grey),
            SizedBox(
              width: 8.w,
            ),
            getText(date, fontSize: 16.sp, fontWeight: FontWeight.w400, color: AppColors.primaryBlack),
          ],
        ),
      ),
    );
  }

  void _chooseDate(DateTime? chooseDay, String? chooseMonth, String? chooseYear, int dateSwitcherIndex) {
    setState(() {
      this.dateSwitcherIndex = dateSwitcherIndex;
      late Tuple2<String, String> dateRange;
      if (chooseDay != null) {
        print("chooseDay：${chooseDay}");
        timeFormat = "day";
        this.chooseDay = chooseDay;
        date = DateFormat("yyyy-MM-dd").format(chooseDay);
        interval = 2;
        dateRange = dayConvertRequest(
            chooseDay,
            convertTimezoneToSeconds(
                energyStorageViewModel.deviceList[energyStorageViewModel.deviceListIndex].attrs?.timezoneVal));
        fields = ["E_KWHHour:max", "PV_KWHHour:max", "B_In_KWHHour:max", "B_Out_KWHHour:max"];
      } else if (chooseMonth != null) {
        print("chooseMonth：${chooseMonth}");
        timeFormat = "month";
        this.chooseMonth = chooseMonth;
        dateRange = monthConvertRequest(
            chooseMonth,
            convertTimezoneToSeconds(
                energyStorageViewModel.deviceList[energyStorageViewModel.deviceListIndex].attrs?.timezoneVal));
        date = chooseMonth + " 　";
        interval = 3;
        fields = ["E_KWHDay:max", "PV_KWHDay:max", "B_In_KWHDay:max", "B_Out_KWHDay:max"];
      } else if (chooseYear != null) {
        print("chooseYear：${chooseYear}");
        timeFormat = "year";
        this.chooseYear = chooseYear;
        dateRange = yearConvertRequest(
            chooseYear,
            convertTimezoneToSeconds(
                energyStorageViewModel.deviceList[energyStorageViewModel.deviceListIndex].attrs?.timezoneVal));
        date = chooseYear + " 　 　";
        interval = 4;
        fields = ["E_KWHMonth:max", "PV_KWHMonth:max", "B_In_KWHMonth:max", "B_Out_KWHMonth:max"];
      }
      this.chooseDay = chooseDay;
      this.chooseMonth = chooseMonth;
      this.chooseYear = chooseYear;

      startTime = dateRange.item1;
      endTime = dateRange.item2;
      fetchData();
    });
  }

  void fetchData() async {
    setState(() {
      energyStorageViewModel.updateStatus = UpdateStatus.updateChart;
      energyDataList = EnergyListData(energyList: []);
      secondEnergyDataList = null;
      chartStatus = ChartStatus.loading;
      // 持續遞增識別值
      ++_lastRequestId;

      energyStorageViewModel.getChartData(startTime, endTime, fields, interval, _lastRequestId).then((response) {
        if (response.energyListData != null && response.lastRequestId == _lastRequestId) {
          energyDataList = response.energyListData!;
        }

        if (timeFormat == "day") {
          Future.delayed(Duration(seconds: 2)).then((value) {
            var minFields = ["E_KWH15Min:max", "PV_KWH15Min:max", "B_In_KWH15Min:max", "B_Out_KWH15Min:max"];
            energyStorageViewModel.getChartData(startTime, endTime, minFields, 9, _lastRequestId).then((response2) {
              if (response2.energyListData != null &&
                  response2.lastRequestId == _lastRequestId &&
                  response.energyListData != null &&
                  response.lastRequestId == _lastRequestId) {
                secondEnergyDataList = response2.energyListData;
                chartStatus = ChartStatus.success;
              } else if(response2.lastRequestId == _lastRequestId && response.lastRequestId == _lastRequestId){
                chartStatus = ChartStatus.error;
              }
              energyStorageViewModel.notifyListeners();
            });
          });
        } else {
          if (response.energyListData != null && response.lastRequestId == _lastRequestId) {
            chartStatus = ChartStatus.success;
          } else if(response.lastRequestId == _lastRequestId){
            chartStatus = ChartStatus.error;
          }
          energyStorageViewModel.notifyListeners();
        }
      });
    });
  }

  void addSubtractClick(bool isAdd) {
    setState(() {
      _isChartClicked = false;
      late Tuple2<String, String> dateRange;
      if (timeFormat == "day") {
        DateTime dateTime = DateTime.parse(date);
        DateTime changeDate = isAdd ? dateTime.add(Duration(days: 1)) : dateTime.subtract(Duration(days: 1));
        _chooseDate(changeDate, null, null, dateSwitcherIndex);
      } else if (timeFormat == "month") {
        DateTime dateTime = DateTime.parse(date.substring(0, 7) + '-01');
        DateTime changeDate =
            isAdd ? DateTime(dateTime.year, dateTime.month + 1) : DateTime(dateTime.year, dateTime.month - 1);
        String formattedDate = DateFormat('yyyy-MM').format(changeDate);
        _chooseDate(null, formattedDate, null, dateSwitcherIndex);
      } else if (timeFormat == "year") {
        int year = int.parse(date.substring(0, 4));
        int changeDate = isAdd ? year + 1 : year - 1;
        _chooseDate(null, null, changeDate.toString(), dateSwitcherIndex);
      }
    });
  }
}
