import 'package:ems_app/define.dart';
import 'package:ems_app/resources/app_texts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';
import '../../../data/chart/ChartDetailData.dart';
import '../../../data/chart/ChartDetailType.dart';
import '../../../data/chart/ChartInfo.dart';
import '../../../data/chart/ChartType.dart';
import '../../../data/chart/PieChartType.dart';
import '../../../data/apiRequest/HistoryValueStatisticsRequest.dart';
import '../../../data/apiResponse/CardType.dart';
import '../../../data/apiResponse/EnergyData.dart';
import '../../../data/chart/ChartConfig.dart';
import '../../../resources/app_colors.dart';
import '../../../screen/BaseChartDetailState.dart';
import '../../../viewModel/ChartViewModel.dart';
import '../../../viewModel/DataViewModel.dart';
import '../../dialog/DialogManager.dart';
import '../../dialog/window/PickerDateDialog.dart';

class MultipleChartWidget extends StatefulWidget {
  final CardType cardType;

  const MultipleChartWidget({
    super.key,
    required this.cardType,
  });

  @override
  _MultipleChartWidget createState() => _MultipleChartWidget();
}

class _MultipleChartWidget extends State<MultipleChartWidget> {
  GlobalKey<BaseChartDetailState> chartDetailStateKey = GlobalKey<BaseChartDetailState>();
  int selectedIndex = -1;
  late Function(bool, List<double>, List<String>) onItemTap;
  bool _isChartClicked = false;
  late ChartConfig chartConfig;
  late DataViewModel dataViewModel = DataViewModel.instance;
  late ChartViewModel chartViewModel = ChartViewModel();
  late String deviceName;
  late String devicePoint;
  late String startTime;
  late String endTime;
  late List<String> fields;
  late int interval;
  late EnergyListData energyDataList = EnergyListData(energyList: []);
  late EnergyListData? secondEnergyDataList;
  String date = ''; // 顯示選擇的日期

  // 獲取當前日期時間
  DateTime now = DateTime.now();
  late DateTime chooseDay;
  late String chooseMonth;
  late String chooseYear;

  // dialog param
  int dateSwitcherIndex = 0;
  int daySelectorIndex = 0;
  int monthSelectorIndex = 0;
  int yearSelectorIndex = 0;

  // 點擊圖表後顯示的細節資料
  List<String> detailTimes = [];
  List<double> detailValues = [];
  String timeFormat = "day";

  @override
  void initState() {
    super.initState();

    date = DateFormat("yyyy-MM-dd").format(now);
    chooseDay = now;
    chooseMonth = DateFormat("yyyy-MM").format(now);
    chooseYear = DateFormat("yyyy").format(now);

    chartConfig = ChartConfig.fromWidgetType(widget.cardType.widgetType);
    deviceName = widget.cardType.getDeviceAndPoint().item1;
    devicePoint = widget.cardType.getDeviceAndPoint().item2;
    // 將時間設定為當天的午夜（00:00:00）
    DateTime midnight = DateTime(now.year, now.month, now.day);
    DateTime endOfDay = midnight.add(Duration(days: 1));
    // 將日期時間格式化為所需的字元串形式（例如：2024-02-28T00:00:00）
    startTime = DateFormat("yyyy-MM-dd'T'HH:mm:ss").format(midnight);
    endTime = DateFormat("yyyy-MM-dd'T'HH:mm:ss").format(endOfDay);
    interval = 2;
    if (widget.cardType.chartOpType != null) {
      fields = [widget.cardType.chartOpType!];
      fetchData();
    }

    onItemTap = (bool isChartClicked, List<double> values, List<String> times) {
      setState(() {
        _isChartClicked = isChartClicked;
        if (_isChartClicked) {
          detailTimes = times;
          detailValues = values;
          chartDetailStateKey.currentState?.updateData(detailTimes, detailValues, chartConfig.chartInfo, timeFormat);
        } else {
          detailTimes.clear();
          detailValues.clear();
        }
      });
    };
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<ChartViewModel, DataViewModel>(builder: (context, chartViewModel, dataViewModel, _) {
      return GestureDetector(
          onTap: () {
            setState(() {
              _isChartClicked = false;
            });
          },
          child: Container(
            margin: EdgeInsets.fromLTRB(0, 12.h, 0, 12.h),
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
                            getText(widget.cardType.title,
                                textAlign: TextAlign.start,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                color: AppColors.grey),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 8.0),
                                  child:
                                      getText(widget.cardType.sTitle, fontSize: 16.sp, color: AppColors.primaryBlack),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      getText(dataViewModel.batteryInformation!.vals.hb3066!.toString(),
                                          fontSize: 28.sp, fontWeight: FontWeight.w600, color: AppColors.primaryBlack),
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
                          dataViewModel.batteryInformation!.vals.hb3066!,
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
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),border: Border.all(color: AppColors.borderGrey, width: 1)),
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
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),border: Border.all(color: AppColors.borderGrey, width: 1)),
                                  child: getImageIcon("arrow_right.png",
                                      height: 18.sp, width: 18.sp, color: AppColors.grey),
                                )),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 18.h,
                      ),
                      if (energyDataList != null && energyDataList.energyList.isNotEmpty)
                        Container(
                          child: ChartType.getChartWidget(
                              "symmetricBarChart", onItemTap, _isChartClicked, energyDataList,
                              baselineVal: widget.cardType.baselineVal, secondEnergyDataList: secondEnergyDataList),
                        ),
                      SizedBox(
                        height: 18.h,
                      ),
                    ],
                  ),
                if (chartConfig.chartType != null)
                  Visibility(
                      visible: (chartConfig.isAlwaysShowDetail || (_isChartClicked && !chartConfig.isAlwaysShowDetail)),
                      child: ChartDetailType.getChartDetailWidget(chartDetailStateKey, chartConfig.chartType!,
                          detailTimes, detailValues, chartConfig.chartInfo, timeFormat)),
              ],
            ),
          ));
    });
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
        date = DateFormat("yyyy-MM-dd").format(this.chooseDay);
        interval = 2;
        dateRange = dayConvertRequest(this.chooseDay);
      } else if (chooseMonth != null) {
        print("chooseMonth：${chooseMonth}");
        timeFormat = "month";
        this.chooseMonth = chooseMonth;
        dateRange = monthConvertRequest(this.chooseMonth);
        date = this.chooseMonth + " 　";
        interval = 3;
      } else if (chooseYear != null) {
        print("chooseYear：${chooseYear}");
        timeFormat = "year";
        this.chooseYear = chooseYear;
        dateRange = yearConvertRequest(this.chooseYear);
        date = this.chooseYear + " 　 　";
        interval = 4;
      }

      startTime = dateRange.item1;
      endTime = dateRange.item2;
      fetchData();
    });
  }

  void fetchData() async {
    setState(() async {


    energyDataList = EnergyListData(energyList: []);
    secondEnergyDataList = null;
    if (timeFormat == "day") {
      fields = ["E_KWHHour:max", "PV_KWHHour:max", "B_In_KWHHour:max", "B_Out_KWHHour:max"];
    } else if (timeFormat == "month") {
      fields = ["E_KWHDay:max", "PV_KWHDay:max", "B_In_KWHDay:max", "B_Out_KWHDay:max"];
    } else if (timeFormat == "year") {
      fields = ["E_KWHMonth:max", "PV_KWHMonth:max", "B_In_KWHMonth:max", "B_Out_KWHMonth:max"];
    }
    EnergyListData? response = await dataViewModel.getChartData(startTime, endTime, fields, interval);
    if (response != null) {
      energyDataList = response;
    } else {
      // 處理未能獲取到有效數據的情況
    }
    if (timeFormat == "day") {
      EnergyListData? response2 = await dataViewModel.getChartData(startTime, endTime, fields, 1);
      if (response2 != null) {
        secondEnergyDataList = response2;
      } else {
        // 處理未能獲取到有效數據的情況
      }
    }
    });
  }

  void addSubtractClick(bool isAdd) {
    setState(() {
      _isChartClicked = false;
      this.dateSwitcherIndex = dateSwitcherIndex;
      late Tuple2<String, String> dateRange;
      if (timeFormat == "day") {
        DateTime dateTime = DateTime.parse(date);
        DateTime changeDate = isAdd ? dateTime.add(Duration(days: 1)) : dateTime.subtract(Duration(days: 1));
        date = DateFormat("yyyy-MM-dd").format(changeDate);
        String startTime =
            '${changeDate.year}-${addLeadingZero(changeDate.month.toString())}-${addLeadingZero(changeDate.day.toString())}T00:00:00';
        String endTime =
            '${changeDate.year}-${addLeadingZero(changeDate.month.toString())}-${addLeadingZero(changeDate.day.toString())}T24:00:00';
        dateRange = Tuple2(startTime, endTime);
      } else if (timeFormat == "month") {
        DateTime dateTime = DateTime.parse(date.substring(0, 7) + '-01');
        DateTime changeDate =
            isAdd ? DateTime(dateTime.year, dateTime.month + 1) : DateTime(dateTime.year, dateTime.month - 1);
        date = DateFormat("yyyy-MM").format(changeDate);
        dateRange = monthConvertRequest(date);
        date = date + " 　";
      } else if (timeFormat == "year") {
        int year = int.parse(date.substring(0, 4));
        int changeDate = isAdd ? year + 1 : year - 1;
        date = changeDate.toString();
        dateRange = yearConvertRequest(date);
        date = date + " 　 　";
      }

      startTime = dateRange.item1;
      endTime = dateRange.item2;
      fetchData();
    });
  }
}

Widget informationTableWidget(String quantity) {
  return Column(
    children: [
      Container(
        height: 1,
        color: AppColors.borderGrey,
      ),
      SizedBox(height: 8),
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            width: 4.sp,
            height: 16.sp,
            color: Color(0xFFFFB800),
          ),
          SizedBox(width: 8),
          getText("機台-1", fontSize: 16.sp, fontWeight: FontWeight.w400, color: AppColors.primaryBlack),
          SizedBox(width: 8),
          Expanded(child: Container()),
          getText(quantity, fontSize: 16.sp, fontWeight: FontWeight.w400, color: AppColors.primaryBlack),
          SizedBox(width: 8),
          getText(
            "kWh",
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.grey,
          ),
          SizedBox(width: 8),
          Container(
            width: 1,
            height: 12,
            color: AppColors.borderGrey,
          ),
          SizedBox(width: 8),
          getText("65", fontSize: 16.sp, fontWeight: FontWeight.w400, color: AppColors.primaryBlack),
          SizedBox(width: 8),
          getText("%", fontSize: 12.sp, fontWeight: FontWeight.w400, color: AppColors.grey),
        ],
      ),
      SizedBox(height: 8),
    ],
  );
}
