import 'package:ems_app/define.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../../resources/app_colors.dart';
import '../../../resources/app_texts.dart';

// 手刻動畫
class EnergyDynamicsWidget2 extends StatefulWidget {
  final String title;
  final String subTitle;

  const EnergyDynamicsWidget2({
    super.key,
    required this.title,
    required this.subTitle,
  });

  @override
  _EnergyDynamicsWidget2 createState() => _EnergyDynamicsWidget2();
}

class _EnergyDynamicsWidget2 extends State<EnergyDynamicsWidget2> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        double parentWidth = constraints.maxWidth;
        double parentHeight = constraints.maxHeight;
        return Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  getText(widget.title,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.grey),
                  getText(widget.subTitle,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryBlack),
                ],
              ),
              SizedBox(
                height: 8.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  deviceItem('device1.png', '193', AppTexts.watt),
                  deviceItem('device2.png', '193', AppTexts.watt),
                  deviceItem('battery.png', '193', AppTexts.watt)
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Container(padding: EdgeInsets.fromLTRB(20.sp, 0, 20.sp, 0),
              child: CustomPaint(
                size: Size(parentWidth - 44.sp, 50.sp),
                painter: PainterLine(
                  width: parentWidth - 44.sp,
                  height: 50.sp,
                ),
              ),),
            ],
          ),
        );
      },
    );
  }

  Widget deviceItem(String icon, String value, String unit) {
    return Column(
      children: [
        getImage(icon, width: 40.sp, height: 40.sp),
        getText(value,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.primaryBlack),
        getText(unit,
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.grey),
      ],
    );
  }
}

class PainterLine extends CustomPainter {
  final double width;
  final double height;
  final Color color;

  PainterLine({
    required this.width,
    required this.height,
    this.color = const Color(0xFF82ADD9),
  });

  @override
  void paint(Canvas canvas, Size size) {
    const radius = 8.0;
    const arcSize = Size.square(radius);

    final paint = Paint()
      ..color = color // 線條顏色
      ..strokeWidth = 2.0 // 線條寬度
      ..strokeCap = StrokeCap.round // 線的端點樣式為圓角
      ..style = PaintingStyle.stroke; // 繪制樣式為線條

    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(0, height / 2)
      ..arcTo(Offset(0, height / 2) & arcSize, 3.14, -3.14 / 2, false)
      ..lineTo(width, (height / 2) + radius)
      ..arcTo(Offset(width - (radius / 2), (height / 2)) & arcSize, 3.14 * 2,
          3.14 / 2, true)
      ..moveTo(width + (radius / 2), (height / 2) + (radius / 2))
      ..lineTo(width + (radius / 2), 0)
      ..moveTo(width / 2, 0)
      ..lineTo(width / 2, height);

    canvas.drawPath(path, paint); // 繪制路徑
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
