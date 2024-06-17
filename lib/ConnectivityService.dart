
import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:ems_app/resources/app_colors.dart';
import 'package:ems_app/resources/app_texts.dart';
import 'package:flutter/cupertino.dart';

import 'define.dart';

class ConnectivityService {
  ConnectivityService._();

  static final ConnectivityService instance = ConnectivityService._();

  late StreamSubscription<List<ConnectivityResult>> _subscription;

  void startListening(BuildContext context) {
    _subscription = Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> result) {
      bool connected = result.contains(ConnectivityResult.wifi) || result.contains(ConnectivityResult.mobile);
      if (!connected) {
        showToast(
          context: context,
          text: AppTexts.noWifi,
          backgroundColor: AppColors.red,
          textColor: AppColors.white,
        );
        print("No internet connection!");
      }
    });
  }

  void dispose() {
    _subscription.cancel();
  }
}