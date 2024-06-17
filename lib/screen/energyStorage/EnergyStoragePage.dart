import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:ems_app/define.dart';
import 'package:ems_app/viewModel/SettingViewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import '../../data/apiResponse/DeviceListResponse.dart';
import '../../resources/app_colors.dart';
import '../../resources/app_texts.dart';
import '../../utils/dialog/DialogManager.dart';
import '../../utils/dialog/window/ChooseStorageDialog.dart';
import '../../utils/dialog/window/ModeChooseDialog.dart';
import '../../utils/dialog/window/MyQrCodeDialog.dart';
import '../../utils/widgets/energyStorage/ModeWidget.dart';
import '../../utils/widgets/main/BatteryStatusWidget.dart';
import '../../utils/widgets/main/MultipleChartWidget2.dart';
import '../../utils/widgets/main/subTitleWidget.dart';
import '../../viewModel/EnergyModeViewModel.dart';
import '../../viewModel/EnergyStorageViewModel.dart';
import 'ScanUidQrPage.dart';

@RoutePage()
class EnergyStoragePage extends StatefulWidget {
  const EnergyStoragePage(
      {super.key, this.statusBarBgColor = AppColors.appPrimaryBlack, this.statusBarIconColor = Brightness.light});

  final Color? statusBarBgColor;
  final Brightness? statusBarIconColor;

  @override
  State<EnergyStoragePage> createState() => _EnergyStoragePageState();
}

class _EnergyStoragePageState extends BasePageState<EnergyStoragePage> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  late EnergyStorageViewModel energyStorageViewModel = EnergyStorageViewModel.instance;
  EnergyModeViewModel energyModeViewModel = EnergyModeViewModel.instance;

  Future<void> _refresh() async {
    await Future.delayed(Duration(seconds: 1));
    uploadData();
  }

  @override
  void initState() {
    super.initState();
    uploadData();
    // checkBiometric();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<EnergyStorageViewModel>(
        builder: (context, energyStorageViewModel, _) {
          return Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(0), // 將 AppBar 高度設 0
              child: AppBar(
                backgroundColor: AppColors.primaryBlack,
              ),
            ),
            backgroundColor: AppColors.bgColor,
            body: SafeArea(
                bottom: false,
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.zero,
                          topRight: Radius.zero,
                          bottomLeft: Radius.circular(16),
                          bottomRight: Radius.circular(16),
                        ),
                        color: widget.statusBarBgColor,
                      ),
                      padding: EdgeInsets.fromLTRB(16.sp, 8.sp, 16.sp, 16.sp),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              showDefaultDialog(
                                  context,
                                  ChooseStorageDialog(
                                    energyStorageViewModel: energyStorageViewModel,
                                    uploadData: uploadData,
                                  ));
                            },
                            child: Row(
                              children: [
                                Container(
                                  width: 160.sp,
                                  child: getText(energyStorageViewModel.deviceList.isNotEmpty?
                                      energyStorageViewModel.deviceList[energyStorageViewModel.deviceListIndex].name:"",
                                      overflow: TextOverflow.ellipsis,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20.sp,
                                      color: AppColors.white,
                                      maxLines: 1),
                                ),
                                getImageIcon('arrow_down.png', width: 28.sp, height: 28.sp, color: AppColors.white),
                              ],
                            ),
                          ),
                          Spacer(),
                          (energyStorageViewModel.deviceList.isNotEmpty)
                              ? (!energyStorageViewModel.energyStorageRepository.userPermissionsMap.containsKey(
                                      energyStorageViewModel.deviceList[energyStorageViewModel.deviceListIndex].id))
                                  ? GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => ScanUidQrPage(
                                                devId: energyStorageViewModel
                                                    .deviceList[energyStorageViewModel.deviceListIndex].id),
                                          ),
                                        );
                                      },
                                      child: getImageIcon('share.png',
                                          width: 28.sp, height: 28.sp, color: AppColors.white),
                                    )
                                  : SizedBox()
                              : SizedBox(),
                        ],
                      ),
                    ),
                    Expanded(
                        child: RefreshIndicator(
                            onRefresh: _refresh,
                            color: AppColors.primaryBlack,
                            child: SingleChildScrollView(
                                child: Container(
                              padding: EdgeInsets.fromLTRB(16.sp, 0, 16.sp, 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 16.sp,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      showModeChooseDialog(context, const ModeChooseDialog());
                                    },
                                    child: const ModeWidget(),
                                  ),
                                  SizedBox(
                                    height: 16.sp,
                                  ),
                                  subTitleWidget(AppTexts.overview, "home.png"),
                                  SizedBox(
                                    height: 16.sp,
                                  ),
                                  // 判斷是哪種尺寸Widget並且判斷需不需要顯示
                                  MultipleChartWidget2(
                                    title:
                                        energyStorageViewModel.deviceList[energyStorageViewModel.deviceListIndex].name,
                                    subTitle: "能源資訊",
                                  ),
                                  SizedBox(
                                    height: 16.sp,
                                  ),
                                  subTitleWidget(AppTexts.batteryInformation, "battery_icon.png"),
                                  SizedBox(
                                    height: 16.sp,
                                  ),
                                  if (energyStorageViewModel.batteryInformation != null)
                                    Column(
                                      children: [
                                        BatteryStatusWidget(
                                          storageName: energyStorageViewModel.batteryInformation!.name,
                                          batteryName: "電池" + energyStorageViewModel.batteryInformation!.vals.info3441,
                                          batteryPower: energyStorageViewModel.batteryInformation!.vals.hb3450,
                                          powerSupply: energyStorageViewModel.batteryInformation!.vals.l2_3457,
                                          batteryStatus: getBatteryOperatingStatus(
                                              energyStorageViewModel.batteryInformation!.vals.reqAndInfo3444B8,
                                              energyStorageViewModel.batteryInformation!.vals.reqAndInfo3444B9),
                                          healthStatus: getBatteryHealthStatus(
                                              energyStorageViewModel.batteryInformation!.vals.l2_3449),
                                          temperature:
                                              energyStorageViewModel.batteryInformation!.vals.l2_3460.toString(),
                                          operationTime: "",
                                        ),
                                        SizedBox(
                                          height: 8.sp,
                                        ),
                                        BatteryStatusWidget(
                                          storageName: energyStorageViewModel.batteryInformation!.name,
                                          batteryName: "電池" + energyStorageViewModel.batteryInformation!.vals.info3485,
                                          batteryPower: energyStorageViewModel.batteryInformation!.vals.hb3494,
                                          powerSupply: energyStorageViewModel.batteryInformation!.vals.l2_3501,
                                          batteryStatus: getBatteryOperatingStatus(
                                              energyStorageViewModel.batteryInformation!.vals.reqAndInfo3488B8,
                                              energyStorageViewModel.batteryInformation!.vals.reqAndInfo3488B9),
                                          healthStatus: getBatteryHealthStatus(
                                              energyStorageViewModel.batteryInformation!.vals.l2_3493),
                                          temperature:
                                              energyStorageViewModel.batteryInformation!.vals.l2_3504.toString(),
                                          operationTime: "",
                                        ),
                                        // BatteryStatusWidget(
                                        //   storageName:
                                        //       viewModel.batteryInformation!.name,
                                        //   batteryName: "電池" +
                                        //       viewModel
                                        //           .batteryInformation!.vals.info3529,
                                        //   batteryPower:
                                        //       viewModel.batteryInformation!.vals.hb3538,
                                        //   powerSupply: viewModel
                                        //       .batteryInformation!.vals.l2_3545,
                                        //   batteryStatus: getBatteryOperatingStatus(
                                        //       viewModel.batteryInformation!.vals
                                        //           .reqAndInfo3532B8,
                                        //       viewModel.batteryInformation!.vals
                                        //           .reqAndInfo3532B9),
                                        //   healthStatus: getBatteryHealthStatus(viewModel
                                        //       .batteryInformation!.vals.l2_3537),
                                        //   temperature: viewModel
                                        //       .batteryInformation!.vals.l2_3548
                                        //       .toString(),
                                        //   operationTime: "",
                                        // ),
                                        // BatteryStatusWidget(
                                        //   storageName:
                                        //       viewModel.batteryInformation!.name,
                                        //   batteryName: "電池" +
                                        //       viewModel
                                        //           .batteryInformation!.vals.info3573,
                                        //   batteryPower:
                                        //       viewModel.batteryInformation!.vals.hb3582,
                                        //   powerSupply: viewModel
                                        //       .batteryInformation!.vals.l2_3589,
                                        //   batteryStatus: getBatteryOperatingStatus(
                                        //       viewModel.batteryInformation!.vals
                                        //           .reqAndInfo3576B8,
                                        //       viewModel.batteryInformation!.vals
                                        //           .reqAndInfo3576B9),
                                        //   healthStatus: getBatteryHealthStatus(viewModel
                                        //       .batteryInformation!.vals.l2_3581),
                                        //   temperature: viewModel
                                        //       .batteryInformation!.vals.l2_3592
                                        //       .toString(),
                                        //   operationTime: "",
                                        // ),
                                      ],
                                    ),
                                ],
                              ),
                            ))))
                  ],
                )),
          );
        },
      ),
    );
  }

  List<PopupMenuItem<int>> menuItemList(List<DeviceListData> deviceList) {
    List<PopupMenuItem<int>> list = [];
    for (var i = 0; i < deviceList.length; i++) {
      list.add(PopupMenuItem<int>(
          padding: EdgeInsets.zero,
          height: 0,
          value: i,
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: (i < deviceList.length - 1) ? AppColors.borderGrey : AppColors.transparent,
                  width: (i < deviceList.length - 1) ? 1 : 0,
                ),
              ),
              color: Color(0xFFFAFAFA),
            ),
            padding: EdgeInsets.fromLTRB(16.sp, 8.sp, 16.sp, 8.sp),
            width: double.infinity,
            child: getText(
              deviceList[i].name,
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.primaryBlack,
            ),
          )));
    }
    return list;
  }

  void uploadData() async {
    setState(() {
      energyStorageViewModel.getListDevice().then((value) {
        if (energyStorageViewModel.deviceList.isNotEmpty) {
          energyModeViewModel.setEnergyMode(energyStorageViewModel.deviceList[energyStorageViewModel.deviceListIndex]);
        }
      });
    });
  }

  void checkBiometric() {
    Future.delayed(const Duration(seconds: 1), () {
      if (SettingViewModel.instance.isBiometricLoginOpen) {
        print('生物辨識已開啟');
      } else {
        print('是否啟動生物辨識');
        SettingViewModel.instance.isBiometricLoginOpen = true;
        launchPopUp();
      }
    });
  }

  void launchPopUp() {
    customAlertPopUp(context,
        child: Container(
          padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
          width: MediaQuery.of(context).size.width * 0.6,
          height: MediaQuery.of(context).size.height * 0.3,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: AppColors.white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Center(
                child: Text('啟用FaceID登入',
                    style: TextStyle(color: AppColors.black, fontSize: 14, fontWeight: FontWeight.bold)),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                child: const Text(
                  '啟用後，您可使用Face ID登入帳號。ihouse 不會保存您的Face ID資訊。',
                  style: TextStyle(
                    color: AppColors.black,
                    fontSize: 14,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    child: const Text(
                      '取消',
                      style: TextStyle(color: AppColors.black, fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      AutoRouter.of(context).maybePop();
                    },
                  ),
                  InkWell(
                    child: const Text(
                      '確認',
                      style: TextStyle(color: AppColors.appPrimaryBlue, fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      AutoRouter.of(context).maybePop();
                    },
                  )
                ],
              )
            ],
          ),
        ));
  }
}
