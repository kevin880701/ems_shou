import 'package:ems_app/define.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../../../resources/app_colors.dart';
import '../../../../resources/app_texts.dart';
import '../../../data/apiRequest/SendBatteryPriorityModeCmdRequest.dart';
import '../../../data/apiRequest/SendPeakShavingModeCmdRequest.dart';
import '../../../data/apiRequest/SendSelfUseModeCmdRequest.dart';
import '../../../viewModel/EnergyModeViewModel.dart';
import '../../../viewModel/EnergyStorageViewModel.dart';
import '../DialogManager.dart';
import '../widget/DialogTitleBar.dart';
import 'SetPeakShavingTimeDialog.dart';
import 'SetSelfModeTimeDialog.dart';

class MyQrCodeDialog extends StatefulWidget {
  const MyQrCodeDialog({super.key, required this.uid});

  final String uid;

  @override
  _MyQrCodeDialog createState() => _MyQrCodeDialog();
}

class _MyQrCodeDialog extends State<MyQrCodeDialog> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0.sp, 8.sp, 0.sp, 0.sp),
      color: AppColors.white,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(12.sp, 8.sp, 12.sp, 8.sp),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 28.sp,
                ),
                getText(AppTexts.myQrCode, fontSize: 18.sp, color: AppColors.primaryBlack),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();},
                  child: getImageIcon("cancel2.png", width: 28.sp, height: 28.sp, color: AppColors.lightBlue),
                )
              ],
            ),
          ),
          Container(
            height: 1.sp,
            color: AppColors.borderGrey,
          ),
          SizedBox(height: 48.sp,),
          QrImageView(
            data: widget.uid,
            version: QrVersions.auto,
            size: 280.sp,
            gapless: false,
            embeddedImage: AssetImage('assets/images/my_embedded_image.png'),
          ),
          SizedBox(height: 24.sp,),
          getText(AppTexts.provideQrCode,fontSize: 16.sp,color: AppColors.grey,fontWeight: FontWeight.w400)
        ],
      ),
    );
  }
}
