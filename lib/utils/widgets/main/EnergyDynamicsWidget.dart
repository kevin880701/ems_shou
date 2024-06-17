import 'package:ems_app/define.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../resources/app_colors.dart';
import '../../../resources/app_texts.dart';

class EnergyDynamicsWidget extends StatefulWidget {
  final String title;
  final String subTitle;

  const EnergyDynamicsWidget({
    super.key,
    required this.title,
    required this.subTitle,
  });

  @override
  _EnergyDynamicsWidget createState() => _EnergyDynamicsWidget();
}

class _EnergyDynamicsWidget extends State<EnergyDynamicsWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(height: 600,
      width: 1000,
      // child: WebView(
      //   initialUrl: 'http://35.229.129.193/web/NewEnergyStorage/map/index4.html?id=map_1662453465&zoom=1&token=eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiI4MmU2MWEyMS05ZGUyLTRlNGEtYTM0MC1kMmQ5Yjc2MDIyNjMiLCJuYW1lIjoiRWRzb24iLCJhY2NvdW50IjoiMDkxODc3MzY4NyJ9.cL4nBhxaLA8v1u0ThFOsxNUkJ9TpOk5yrXQKAEOjmO8m2PvTDKfg92kVZC0DyFdry9Wz6NxZzpgJHL9FVDUYsKQd5jPZ7uNyvbrBgPSUJEmCsI4neUaaeYuhhtlvT971qF5O9h_LMXaZGToyG2-u1GWcSK9-GvMW2xjfRqu4H2fmkAkRy96vt7QiYJR9vVC0beTfxYAps3chV9XBkQv-3ts7RA_4dBs2f5b-Vvks5G3OMDN4skb_qk5GoEbmFMI83VX44VsmMa20PQkkWmRRAQjkxyqGBtbL7NpGoV7JisEF1Q0oHosPrwtUO04o52G6NVEAcpvy2VNV_SMQ90-KOA&height=600&width=850',
      //   javascriptMode: JavascriptMode.unrestricted,
      // ),
    )
    ;
  }
}

class WebView {
}