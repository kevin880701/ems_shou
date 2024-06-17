import 'package:ems_app/define.dart';
import 'package:ems_app/resources/app_colors.dart';
import 'package:ems_app/resources/app_resources.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../../../../data/chart/ChartInfo.dart';
import '../../../../screen/BaseChartDetailState.dart';

class VerticalBarChartInfo extends StatefulWidget {
  const VerticalBarChartInfo({
    super.key,
    required this.times,
    required this.values,
    required this.titles,
    required this.chartInfo,
    required this.timeFormat,
  });

  final List<String> times;
  final List<double> values;
  final List<String> titles;
  final ChartInfo chartInfo;
  final String timeFormat;

  @override
  State<VerticalBarChartInfo> createState() => VerticalBarChartInfoState();
}

class VerticalBarChartInfoState extends BaseChartDetailState<VerticalBarChartInfo> {
  String time = "";
  List<String> times = [];
  List<double> values = [];
  String timeFormat = "day";
  double value = 0;
  double baseValue = 0;
  int percent = 0;

  @override
  void initState() {
    super.initState();
    times = widget.times;
    values = widget.values;
    timeFormat = widget.timeFormat;
  }


  @override
  void updateData(List<String> times, List<double> values,
      ChartInfo chartInfo, String timeFormat) {
    setState(() {
      this.times = times;
      this.values = values;
      this.timeFormat = timeFormat;
    });

  }

  @override
  Widget build(BuildContext context) {
    if (times.isNotEmpty) {
      DateTime dateTime = DateTime.parse(times[0]);
      switch (timeFormat) {
        case "day":
          time = DateFormat('HH:mm').format(dateTime);
        case "month":
          time = DateFormat('MM-dd').format(dateTime);
        case "year":
          time = DateFormat("MM月").format(dateTime);
        default:
          time = DateFormat('HH:mm').format(dateTime);
      }
    } else {
      time = "";
    }
    if (values.length > 1) {
      value = values.isNotEmpty ? values[1] : 0;
      baseValue = values.isNotEmpty ? values[0] : 0;
    }
    if (baseValue == 0 || value == 0) {
      percent = 0;
    } else {
      percent = (((value - baseValue) / baseValue) * 100).toInt();
    }

    return Container(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 16.sp),
        color: AppColors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  getText(AppTexts.time,
                      fontWeight: FontWeight.w400,
                      fontSize: 14.sp,
                      color: AppColors.grey),
                  getText(time, fontSize: 20.sp, color: AppColors.primaryBlack),
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  getText("用${widget.chartInfo.chinese}量",
                      fontWeight: FontWeight.w400,
                      fontSize: 14.sp,
                      color: AppColors.grey),
                  Row(
                    children: [
                      getText(formatValue(value).toString(),
                          fontSize: 20.sp, color: AppColors.primaryBlack),
                      SizedBox(
                        width: 4.sp,
                      ),
                      getText(widget.chartInfo.unit,
                          fontWeight: FontWeight.w400,
                          fontSize: 12.sp,
                          color: AppColors.grey)
                    ],
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
