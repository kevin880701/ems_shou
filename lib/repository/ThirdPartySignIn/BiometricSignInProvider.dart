import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth/error_codes.dart' as auth_error;
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_darwin/local_auth_darwin.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class BiometricAuth extends ChangeNotifier {
  final LocalAuthentication _localAuthentication = LocalAuthentication();

  bool _isBiometricAvailable = false;
  bool _isAuthenticated = false;

  BiometricAuth() {
    checkBiometricAvailability();
  }

  bool get isBiometricAvailable => _isBiometricAvailable;

  bool get isAuthenticated => _isAuthenticated;

  Future<void> checkBiometricAvailability() async {
    try {
      final bool canAuthenticate =
          await _localAuthentication.canCheckBiometrics ||
              await _localAuthentication.isDeviceSupported();
      _isBiometricAvailable = canAuthenticate;
      print('_isBiometricAvailable:$_isBiometricAvailable');
    } catch (e) {
      _isBiometricAvailable = false;
      print('_isBiometricAvailable:$_isBiometricAvailable');
    }
    notifyListeners();
  }

  Future<void> makeAuth(Function bioAuthSuccess) async {
    try {
      _isAuthenticated = await _localAuthentication.authenticate(
        localizedReason: '請使用您的生物辨識特徵進行驗證',
        authMessages: const <AuthMessages>[
          AndroidAuthMessages(
              cancelButton: "關閉",
              biometricRequiredTitle: "需要生物辨識設定",
              goToSettingsButton: "前往設定",
              goToSettingsDescription:
                  "如果您未設定生物辨識功能，請點按前往設定頁面，進行相關功能設定，完成設定後，可再次嘗試生物辨識服務。",
              deviceCredentialsSetupDescription: '',
              signInTitle: "身份認證"),
          IOSAuthMessages(
              cancelButton: 'cancel',
              goToSettingsButton: 'settings',
              goToSettingsDescription: 'Please set up your Touch ID.',
              lockOut: 'Please reenable your Touch ID'),
        ],
        options: const AuthenticationOptions(
            biometricOnly: true,
            stickyAuth: true,
            useErrorDialogs: true,
            sensitiveTransaction: false),
      );
      if (_isAuthenticated) {
        bioAuthSuccess();
      }
    } on PlatformException catch (e) {
      if (e.code == auth_error.notAvailable) {
        print('auth_error.notAvailable');
        _isAuthenticated = false;
      } else if (e.code == auth_error.notEnrolled) {
        print('auth_error.notEnrolled');
        _isAuthenticated = false;
      } else {
        print('auth_error:${e.code}');
        _isAuthenticated = false;
      }
    }
    notifyListeners();
  }

  Future<void> checkAvalableBiometricFeat() async {
    final List<BiometricType> availableBiometrics =
        await _localAuthentication.getAvailableBiometrics();
    print('availableBiometrics:$availableBiometrics');
    if (availableBiometrics.isNotEmpty) {
      print('availableBiometric not empty');
    } else {
      if (Platform.isIOS) {
        _openFaceIdSettings();
      }
    }

    if (availableBiometrics.contains(BiometricType.fingerprint) ||
        availableBiometrics.contains(BiometricType.face)) {
      print('Can both fingerprint and face ID');
    }
  }

  void _openFaceIdSettings() async {
    const url = 'App-Prefs:root=Face ID';
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
