import 'package:ems_app/data/apiRequest/SetPeakShavingModeTimeRequest.dart';
import 'package:ems_app/define.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tuple/tuple.dart';
import '../../../../resources/app_colors.dart';
import '../../../../resources/app_texts.dart';
import '../../../viewModel/EnergyModeViewModel.dart';
import '../DialogManager.dart';
import '../widget/DialogTitleBar.dart';
import '../widget/TimeRangeWidget.dart';
import 'PeakShavingChooseTimeDialog.dart';

class SetPeakShavingTimeDialog extends StatefulWidget {
  const SetPeakShavingTimeDialog({
    super.key,
  });

  @override
  _SetPeakShavingTimeDialog createState() => _SetPeakShavingTimeDialog();
}

class _SetPeakShavingTimeDialog extends State<SetPeakShavingTimeDialog> {
  EnergyModeViewModel energyModeViewModel = EnergyModeViewModel.instance;

  bool showPeriod2 = false;

  @override
  void initState() {
    super.initState();

    if (energyModeViewModel.modeData.peakShavingChargeStart2Index != -1 ||
        energyModeViewModel.modeData.peakShavingDischargeStart2Index != -1) {
      showPeriod2 = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
        alignment: Alignment.bottomCenter,
        insetPadding: EdgeInsets.zero,
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
            color: AppColors.white,
          ),
          child: IntrinsicHeight(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                DialogTitleBar(
                  title: AppTexts.setChargingTime,
                  rightWidget: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: getImage(
                      "dialog_cancel.png",
                      height: 32.sp,
                      width: 32.sp,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(24.sp, 12.sp, 24.sp, 24.sp),
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: Column(
                              children: [
                                getText(AppTexts.period1, fontSize: 18.sp),
                                Container(
                                  width: 24.sp,
                                  height: 2.sp,
                                  color: AppColors.grey,
                                ),
                              ],
                            ),
                          ),
                          Visibility(
                            visible: showPeriod2,
                            child: SizedBox(
                              width: double.infinity,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    showPeriod2 = false;

                                    energyModeViewModel.modeData
                                      ..peakShavingChargeStart1Index = energyModeViewModel.modeData.peakShavingChargeStart2Index
                                      ..peakShavingChargeEnd1Index = energyModeViewModel.modeData.peakShavingChargeEnd2Index
                                      ..peakShavingDischargeStart1Index = energyModeViewModel.modeData.peakShavingDischargeStart2Index
                                      ..peakShavingDischargeEnd1Index = energyModeViewModel.modeData.peakShavingDischargeEnd2Index
                                      ..peakShavingChargeStart2Index = -1
                                      ..peakShavingChargeEnd2Index = -1
                                      ..peakShavingDischargeStart2Index = -1
                                      ..peakShavingDischargeEnd2Index = -1;

                                    energyModeViewModel.setPeakShavingModeTime(SetPeakShavingModeTimeRequest.create(
                                      energyModeViewModel.modeData.peakShavingChargeStart1Index,
                                      energyModeViewModel.modeData.peakShavingChargeEnd1Index,
                                      energyModeViewModel.modeData.peakShavingDischargeStart1Index,
                                      energyModeViewModel.modeData.peakShavingDischargeEnd1Index,
                                      energyModeViewModel.modeData.peakShavingChargeStart2Index,
                                      energyModeViewModel.modeData.peakShavingChargeEnd2Index,
                                      energyModeViewModel.modeData.peakShavingDischargeStart2Index,
                                      energyModeViewModel.modeData.peakShavingDischargeEnd2Index,
                                    ));
                                  });
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    getImageIcon("delete.png", width: 24.sp, color: AppColors.red),
                                    getText(AppTexts.delete, fontSize: 14.sp, color: AppColors.red),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 16.sp,
                      ),
                      timeRangeWidget(AppTexts.charge, energyModeViewModel.modeData.peakShavingChargeStart1Index,
                          energyModeViewModel.modeData.peakShavingChargeEnd1Index, () async {
                        showChooseTimeDialog(
                            context,
                            PeakShavingChooseTimeDialog(
                              typeName: AppTexts.charge,
                              defaultTimeRange: Tuple2(energyModeViewModel.modeData.peakShavingChargeStart1Index,
                                  energyModeViewModel.modeData.peakShavingChargeEnd1Index),
                              timeRange2: Tuple2(energyModeViewModel.modeData.peakShavingDischargeStart1Index,
                                  energyModeViewModel.modeData.peakShavingDischargeEnd1Index),
                              timeRange3: Tuple2(energyModeViewModel.modeData.peakShavingChargeStart2Index,
                                  energyModeViewModel.modeData.peakShavingChargeEnd2Index),
                              timeRange4: Tuple2(energyModeViewModel.modeData.peakShavingDischargeStart2Index,
                                  energyModeViewModel.modeData.peakShavingDischargeEnd2Index),
                            )).then((value) {
                          setState(() {
                            energyModeViewModel.modeData
                              ..peakShavingChargeStart1Index = value.item1
                              ..peakShavingChargeEnd1Index = value.item2;
                            energyModeViewModel.setPeakShavingModeTime(SetPeakShavingModeTimeRequest.create(
                              energyModeViewModel.modeData.peakShavingChargeStart1Index,
                              energyModeViewModel.modeData.peakShavingChargeEnd1Index,
                              energyModeViewModel.modeData.peakShavingDischargeStart1Index,
                              energyModeViewModel.modeData.peakShavingDischargeEnd1Index,
                              energyModeViewModel.modeData.peakShavingChargeStart2Index,
                              energyModeViewModel.modeData.peakShavingChargeEnd2Index,
                              energyModeViewModel.modeData.peakShavingDischargeStart2Index,
                              energyModeViewModel.modeData.peakShavingDischargeEnd2Index,
                            ));
                            showToast(
                                context: context,
                                text: AppTexts.saved,
                                textColor: AppColors.white,
                                backgroundColor: AppColors.lightBlue,);
                          });
                        });
                      }),
                      SizedBox(
                        height: 16.sp,
                      ),
                      timeRangeWidget(AppTexts.discharge, energyModeViewModel.modeData.peakShavingDischargeStart1Index,
                          energyModeViewModel.modeData.peakShavingDischargeEnd1Index, () async {
                        showChooseTimeDialog(
                            context,
                            PeakShavingChooseTimeDialog(
                              typeName: AppTexts.discharge,
                              defaultTimeRange: Tuple2(energyModeViewModel.modeData.peakShavingDischargeStart1Index,
                                  energyModeViewModel.modeData.peakShavingDischargeEnd1Index),
                              timeRange2: Tuple2(energyModeViewModel.modeData.peakShavingChargeStart1Index,
                                  energyModeViewModel.modeData.peakShavingChargeEnd1Index),
                              timeRange3: Tuple2(energyModeViewModel.modeData.peakShavingChargeStart2Index,
                                  energyModeViewModel.modeData.peakShavingChargeEnd2Index),
                              timeRange4: Tuple2(energyModeViewModel.modeData.peakShavingDischargeStart2Index,
                                  energyModeViewModel.modeData.peakShavingDischargeEnd2Index),
                            )).then((value) {
                          setState(() {
                            energyModeViewModel.modeData
                              ..peakShavingDischargeStart1Index = value.item1
                              ..peakShavingDischargeEnd1Index = value.item2;
                            energyModeViewModel.setPeakShavingModeTime(SetPeakShavingModeTimeRequest.create(
                              energyModeViewModel.modeData.peakShavingChargeStart1Index,
                              energyModeViewModel.modeData.peakShavingChargeEnd1Index,
                              energyModeViewModel.modeData.peakShavingDischargeStart1Index,
                              energyModeViewModel.modeData.peakShavingDischargeEnd1Index,
                              energyModeViewModel.modeData.peakShavingChargeStart2Index,
                              energyModeViewModel.modeData.peakShavingChargeEnd2Index,
                              energyModeViewModel.modeData.peakShavingDischargeStart2Index,
                              energyModeViewModel.modeData.peakShavingDischargeEnd2Index,
                            ));
                            showToast(
                                context: context,
                                text: AppTexts.saved,
                                textColor: AppColors.white,
                                backgroundColor: AppColors.lightBlue,);
                          });
                        });
                      }),
                      SizedBox(
                        height: 16.sp,
                      ),
                      Visibility(
                        visible: !showPeriod2,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              showPeriod2 = true;
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              getImageIcon("add.png", width: 24.sp, color: AppColors.lightBlue),
                              getText(AppTexts.addPeriod, fontSize: 16.sp, color: AppColors.lightBlue),
                            ],
                          ),
                        ),
                      ),
                      Visibility(
                          visible: showPeriod2,
                          child: Column(
                            children: [
                              Stack(
                                children: [
                                  SizedBox(
                                    width: double.infinity,
                                    child: Column(
                                      children: [
                                        getText(AppTexts.period2, fontSize: 18.sp),
                                        Container(
                                          width: 24.sp,
                                          height: 2.sp,
                                          color: AppColors.grey,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Visibility(
                                    visible: showPeriod2,
                                    child: SizedBox(
                                      width: double.infinity,
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            showPeriod2 = false;

                                            energyModeViewModel.modeData
                                              ..peakShavingChargeStart2Index = -1
                                              ..peakShavingChargeEnd2Index = -1
                                              ..peakShavingDischargeStart2Index = -1
                                              ..peakShavingDischargeEnd2Index = -1;

                                            energyModeViewModel.setPeakShavingModeTime(SetPeakShavingModeTimeRequest.create(
                                              energyModeViewModel.modeData.peakShavingChargeStart1Index,
                                              energyModeViewModel.modeData.peakShavingChargeEnd1Index,
                                              energyModeViewModel.modeData.peakShavingDischargeStart1Index,
                                              energyModeViewModel.modeData.peakShavingDischargeEnd1Index,
                                              energyModeViewModel.modeData.peakShavingChargeStart2Index,
                                              energyModeViewModel.modeData.peakShavingChargeEnd2Index,
                                              energyModeViewModel.modeData.peakShavingDischargeStart2Index,
                                              energyModeViewModel.modeData.peakShavingDischargeEnd2Index,
                                            ));
                                          });
                                        },
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            getImageIcon("delete.png", width: 24.sp, color: AppColors.red),
                                            getText(AppTexts.delete, fontSize: 14.sp, color: AppColors.red),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 16.sp,
                              ),
                              timeRangeWidget(
                                  AppTexts.charge,
                                  energyModeViewModel.modeData.peakShavingChargeStart2Index,
                                  energyModeViewModel.modeData.peakShavingChargeEnd2Index, () async {
                                showChooseTimeDialog(
                                    context,
                                    PeakShavingChooseTimeDialog(
                                      typeName: AppTexts.charge,
                                      defaultTimeRange: Tuple2(
                                          energyModeViewModel.modeData.peakShavingChargeStart2Index,
                                          energyModeViewModel.modeData.peakShavingChargeEnd2Index),
                                      timeRange2: Tuple2(energyModeViewModel.modeData.peakShavingDischargeStart1Index,
                                          energyModeViewModel.modeData.peakShavingDischargeEnd1Index),
                                      timeRange3: Tuple2(energyModeViewModel.modeData.peakShavingChargeStart1Index,
                                          energyModeViewModel.modeData.peakShavingChargeEnd1Index),
                                      timeRange4: Tuple2(energyModeViewModel.modeData.peakShavingDischargeStart2Index,
                                          energyModeViewModel.modeData.peakShavingDischargeEnd2Index),
                                    )).then((value) {
                                  setState(() {
                                    energyModeViewModel.modeData
                                      ..peakShavingChargeStart2Index = value.item1
                                      ..peakShavingChargeEnd2Index = value.item2;
                                    energyModeViewModel.setPeakShavingModeTime(SetPeakShavingModeTimeRequest.create(
                                      energyModeViewModel.modeData.peakShavingChargeStart1Index,
                                      energyModeViewModel.modeData.peakShavingChargeEnd1Index,
                                      energyModeViewModel.modeData.peakShavingDischargeStart1Index,
                                      energyModeViewModel.modeData.peakShavingDischargeEnd1Index,
                                      energyModeViewModel.modeData.peakShavingChargeStart2Index,
                                      energyModeViewModel.modeData.peakShavingChargeEnd2Index,
                                      energyModeViewModel.modeData.peakShavingDischargeStart2Index,
                                      energyModeViewModel.modeData.peakShavingDischargeEnd2Index,
                                    ));
                                    showToast(
                                        context: context,
                                        text: AppTexts.saved,
                                        textColor: AppColors.white,
                                        backgroundColor: AppColors.lightBlue,);
                                  });
                                });
                              }),
                              SizedBox(
                                height: 16.sp,
                              ),
                              timeRangeWidget(
                                  AppTexts.discharge,
                                  energyModeViewModel.modeData.peakShavingDischargeStart2Index,
                                  energyModeViewModel.modeData.peakShavingDischargeEnd2Index, () async {
                                showChooseTimeDialog(
                                    context,
                                    PeakShavingChooseTimeDialog(
                                      typeName: AppTexts.discharge,
                                      defaultTimeRange: Tuple2(
                                          energyModeViewModel.modeData.peakShavingDischargeStart2Index,
                                          energyModeViewModel.modeData.peakShavingDischargeEnd2Index),
                                      timeRange2: Tuple2(energyModeViewModel.modeData.peakShavingDischargeStart1Index,
                                          energyModeViewModel.modeData.peakShavingDischargeEnd1Index),
                                      timeRange3: Tuple2(energyModeViewModel.modeData.peakShavingChargeStart2Index,
                                          energyModeViewModel.modeData.peakShavingChargeEnd2Index),
                                      timeRange4: Tuple2(energyModeViewModel.modeData.peakShavingChargeStart1Index,
                                          energyModeViewModel.modeData.peakShavingChargeEnd1Index),
                                    )).then((value) {
                                  setState(() {
                                    energyModeViewModel.modeData
                                      ..peakShavingDischargeStart2Index = value.item1
                                      ..peakShavingDischargeEnd2Index = value.item2;
                                    energyModeViewModel.setPeakShavingModeTime(SetPeakShavingModeTimeRequest.create(
                                      energyModeViewModel.modeData.peakShavingChargeStart1Index,
                                      energyModeViewModel.modeData.peakShavingChargeEnd1Index,
                                      energyModeViewModel.modeData.peakShavingDischargeStart1Index,
                                      energyModeViewModel.modeData.peakShavingDischargeEnd1Index,
                                      energyModeViewModel.modeData.peakShavingChargeStart2Index,
                                      energyModeViewModel.modeData.peakShavingChargeEnd2Index,
                                      energyModeViewModel.modeData.peakShavingDischargeStart2Index,
                                      energyModeViewModel.modeData.peakShavingDischargeEnd2Index,
                                    ));
                                    showToast(
                                        context: context,
                                        text: AppTexts.saved,
                                        textColor: AppColors.white,
                                        backgroundColor: AppColors.lightBlue,);
                                  });
                                });
                              }),
                            ],
                          )),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
