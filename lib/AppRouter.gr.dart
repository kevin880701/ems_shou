// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i1;
import 'package:ems_app/screen/notification/NotificationPage.dart';
import 'screen/LoginPage.dart' as _i2;
import 'screen/login/ForgotPasswordPage.dart' as _i3;
import 'screen/login/ChangePasswordPage.dart' as _i4;
import 'screen/MainPage.dart' as _i5;
import 'screen/personal/AccountManagerPage.dart' as _i6;
import 'screen/login/PasswordLoginPage.dart' as _i7;
import 'screen/personal/SystemSettingPage.dart' as _i8;
import 'screen/personal/PrivacyPolicyPage.dart' as _i9;
import 'screen/LaunchScreenPage.dart' as _i10;
import 'screen/personal/NotificationSettingPage.dart' as _i11;
import 'screen/personal/PrivacySettingPage.dart' as _i12;
import 'screen/login/RegisterDeviceQrPage.dart' as _i14;
import 'screen/login/CompleteBindingPage.dart' as _i15;
import 'screen/login/EnterUserNamePage.dart' as _i16;
import 'screen/login/BindEnergyStoragePage.dart' as _i17;
import 'screen/energyStorage/ScanUidQrPage.dart' as _i18;
import 'screen/login/RegisterAccountPage.dart' as _i19;
import 'screen/login/RegisterPasswordPage.dart' as _i20;
import 'screen/TestPage.dart' as _i100;

abstract class $AppRouter extends _i1.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i1.PageFactory> pagesMap = {

    LoginRoute.name: (routeData) {
      return _i1.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.LoginPage(),
      );
    },
    ForgotPasswordRoute.name: (routeData) {
      return _i1.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.ForgotPasswordPage(),
      );
    },
    ChangePasswordRoute.name: (routeData) {
      return _i1.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.ChangePasswordPage(),
      );
    },
    MainRoute.name: (routeData) {
      return _i1.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.MainPage(),
      );
    },
    AccountManagerRoute.name: (routeData) {
      return _i1.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.AccountManagerPage(),
      );
    },
    PasswordLoginRoute.name: (routeData) {
      return _i1.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.PasswordLoginPage(),
      );
    },
    SystemSettingRoute.name: (routeData) {
      return _i1.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i8.SystemSettingPage(),
      );
    },
    PrivacyPolicyRoute.name: (routeData) {
      return _i1.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i9.PrivacyPolicyPage(),
      );
    },
    LaunchScreenRoute.name: (routeData) {
      return _i1.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i10.LaunchScreenPage(),
      );
    },
    NotificationSettingRoute.name: (routeData) {
      return _i1.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i11.NotificationSettingPage(),
      );
    },
    PrivacySettingRoute.name: (routeData) {
      return _i1.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i12.PrivacySettingPage(),
      );
    },
    RegisterDeviceQrRoute.name: (routeData) {
      return _i1.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i14.RegisterDeviceQrPage(),
      );
    },
    CompleteBindingRoute.name: (routeData) {
      return _i1.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i15.CompleteBindingPage(),
      );
    },
    EnterUserNameRoute.name: (routeData) {
      return _i1.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i16.EnterUserNamePage(),
      );
    },
    BindEnergyStorageRoute.name: (routeData) {
      return _i1.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i17.BindEnergyStoragePage(),
      );
    },
    ScanUidQrRoute.name: (routeData) {
      return _i1.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i18.ScanUidQrPage(devId: '',),
      );
    },
    RegisterAccountRoute.name: (routeData) {
      return _i1.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i19.RegisterAccountPage(),
      );
    },
    RegisterPasswordRoute.name: (routeData) {
      return _i1.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i20.RegisterPasswordPage(),
      );
    },
    TestChartRoute.name: (routeData) {
      return _i1.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i100.TestPage(),
      );
    },
  };
}

/// generated route for
/// [_i2.LoginPage]
class LoginRoute extends _i1.PageRouteInfo<void> {
  const LoginRoute({List<_i1.PageRouteInfo>? children})
      : super(
    LoginRoute.name,
    initialChildren: children,
  );

  static const String name = 'LoginRoute';

  static const _i1.PageInfo<void> page = _i1.PageInfo<void>(name);
}

/// generated route for
/// [_i3.ForgotPasswordPage]
class ForgotPasswordRoute extends _i1.PageRouteInfo<void> {
  const ForgotPasswordRoute({List<_i1.PageRouteInfo>? children})
      : super(
    ForgotPasswordRoute.name,
    initialChildren: children,
  );

  static const String name = 'ForgotPasswordRoute';

  static const _i1.PageInfo<void> page = _i1.PageInfo<void>(name);
}

/// generated route for
/// [_i4.ChangePasswordPage]
class ChangePasswordRoute extends _i1.PageRouteInfo<void> {
  const ChangePasswordRoute({List<_i1.PageRouteInfo>? children})
      : super(
    ChangePasswordRoute.name,
    initialChildren: children,
  );

  static const String name = 'ChangePasswordRoute';

  static const _i1.PageInfo<void> page = _i1.PageInfo<void>(name);
}

/// generated route for
/// [_i5.MainPage]
class MainRoute extends _i1.PageRouteInfo<void> {
  const MainRoute({List<_i1.PageRouteInfo>? children})
      : super(
    MainRoute.name,
    initialChildren: children,
  );

  static const String name = 'MainRoute';

  static const _i1.PageInfo<void> page = _i1.PageInfo<void>(name);
}

/// generated route for
/// [_i6.AccountManagerPage]
class AccountManagerRoute extends _i1.PageRouteInfo<void> {
  const AccountManagerRoute({List<_i1.PageRouteInfo>? children})
      : super(
    AccountManagerRoute.name,
    initialChildren: children,
  );

  static const String name = 'AccountManagerRoute';

  static const _i1.PageInfo<void> page = _i1.PageInfo<void>(name);
}

/// generated route for
/// [_i7.PasswordLoginPage]
class PasswordLoginRoute extends _i1.PageRouteInfo<void> {
  const PasswordLoginRoute({List<_i1.PageRouteInfo>? children})
      : super(
    PasswordLoginRoute.name,
    initialChildren: children,
  );

  static const String name = 'PasswordLoginRoute';

  static const _i1.PageInfo<void> page = _i1.PageInfo<void>(name);
}

/// generated route for
/// [_i8.SystemSettingPage]
class SystemSettingRoute extends _i1.PageRouteInfo<void> {
  const SystemSettingRoute({List<_i1.PageRouteInfo>? children})
      : super(
    SystemSettingRoute.name,
    initialChildren: children,
  );

  static const String name = 'SystemSettingRoute';

  static const _i1.PageInfo<void> page = _i1.PageInfo<void>(name);
}

/// generated route for
/// [_i9.PrivacyPolicyPage]
class PrivacyPolicyRoute extends _i1.PageRouteInfo<void> {
  const PrivacyPolicyRoute({List<_i1.PageRouteInfo>? children})
      : super(
    PrivacyPolicyRoute.name,
    initialChildren: children,
  );

  static const String name = 'privacyPolicyRoute';

  static const _i1.PageInfo<void> page = _i1.PageInfo<void>(name);
}

/// [_i10.LaunchScreenPage]
class LaunchScreenRoute extends _i1.PageRouteInfo<void> {
  const LaunchScreenRoute({List<_i1.PageRouteInfo>? children})
      : super(
    LaunchScreenRoute.name,
    initialChildren: children,
  );

  static const String name = 'LaunchScreenRoute';

  static const _i1.PageInfo<void> page = _i1.PageInfo<void>(name);
}

/// [_i11.NotificationSettingPage]
class NotificationSettingRoute extends _i1.PageRouteInfo<void> {
  const NotificationSettingRoute({List<_i1.PageRouteInfo>? children})
      : super(
    NotificationSettingRoute.name,
    initialChildren: children,
  );

  static const String name = 'NotificationSettingRoute';

  static const _i1.PageInfo<void> page = _i1.PageInfo<void>(name);
}

/// [_i12.PrivacySettingPage]
class PrivacySettingRoute extends _i1.PageRouteInfo<void> {
  const PrivacySettingRoute({List<_i1.PageRouteInfo>? children})
      : super(
    PrivacySettingRoute.name,
    initialChildren: children,
  );

  static const String name = 'PrivacySettingRoute';

  static const _i1.PageInfo<void> page = _i1.PageInfo<void>(name);
}


/// [_i14.RegisterDeviceQrPage]
class RegisterDeviceQrRoute extends _i1.PageRouteInfo<void> {
  const RegisterDeviceQrRoute({List<_i1.PageRouteInfo>? children})
      : super(
    RegisterDeviceQrRoute.name,
    initialChildren: children,
  );

  static const String name = 'RegisterDeviceQrRoute';

  static const _i1.PageInfo<void> page = _i1.PageInfo<void>(name);
}


/// [_i15.CompleteBindingPage]
class CompleteBindingRoute extends _i1.PageRouteInfo<void> {
  const CompleteBindingRoute({List<_i1.PageRouteInfo>? children})
      : super(
    CompleteBindingRoute.name,
    initialChildren: children,
  );

  static const String name = 'CompleteBindingRoute';

  static const _i1.PageInfo<void> page = _i1.PageInfo<void>(name);
}


/// [_i16.EnterUserNamePage]
class EnterUserNameRoute extends _i1.PageRouteInfo<void> {
  const EnterUserNameRoute({List<_i1.PageRouteInfo>? children})
      : super(
    EnterUserNameRoute.name,
    initialChildren: children,
  );

  static const String name = 'EnterUserNameRoute';

  static const _i1.PageInfo<void> page = _i1.PageInfo<void>(name);
}


/// [_i17.BindEnergyStoragePage]
class BindEnergyStorageRoute extends _i1.PageRouteInfo<void> {
  const BindEnergyStorageRoute({List<_i1.PageRouteInfo>? children})
      : super(
    BindEnergyStorageRoute.name,
    initialChildren: children,
  );

  static const String name = 'BindEnergyStorageRoute';

  static const _i1.PageInfo<void> page = _i1.PageInfo<void>(name);
}


/// [_i18.ScanUidQrPage]
class ScanUidQrRoute extends _i1.PageRouteInfo<void> {
  const ScanUidQrRoute({List<_i1.PageRouteInfo>? children})
      : super(
    ScanUidQrRoute.name,
    initialChildren: children,
  );

  static const String name = 'ScanUidQrRoute';

  static const _i1.PageInfo<void> page = _i1.PageInfo<void>(name);
}


/// [_i19.RegisterAccountPage]
class RegisterAccountRoute extends _i1.PageRouteInfo<void> {
  const RegisterAccountRoute({List<_i1.PageRouteInfo>? children})
      : super(
    RegisterAccountRoute.name,
    initialChildren: children,
  );

  static const String name = 'RegisterAccountRoute';

  static const _i1.PageInfo<void> page = _i1.PageInfo<void>(name);
}


/// [_i20.RegisterPasswordPage]
class RegisterPasswordRoute extends _i1.PageRouteInfo<void> {
  const RegisterPasswordRoute({List<_i1.PageRouteInfo>? children})
      : super(
    RegisterPasswordRoute.name,
    initialChildren: children,
  );

  static const String name = 'RegisterPasswordRoute';

  static const _i1.PageInfo<void> page = _i1.PageInfo<void>(name);
}

/// generated route for
/// [_i100.TestPage]
class TestChartRoute extends _i1.PageRouteInfo<void> {
  const TestChartRoute({List<_i1.PageRouteInfo>? children})
      : super(
    TestChartRoute.name,
    initialChildren: children,
  );

  static const String name = 'TestChartRoute';

  static const _i1.PageInfo<void> page = _i1.PageInfo<void>(name);
}
