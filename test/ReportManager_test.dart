import 'dart:math';

import 'package:ems_app/net/remote/Managers/AccountManager.dart';
import 'package:ems_app/net/remote/Managers/EnergyNodeManager.dart';
import 'package:ems_app/net/remote/Managers/ReportManager.dart';
import 'package:ems_app/net/remote/Managers/WebManager.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:ems_app/net/remote/NetworkInterface.dart';

class MockNetworkInterface extends Mock implements NetworkInterface {}

void main() {

  late WebManager webManager;

  late AccountManager accountManager;

  late EnergyNodeManager energyNodeManager;

  late ReportManager reportManager;

  setUp(() {
    accountManager = AccountManager.instance;
    webManager = WebManager.instance;
    energyNodeManager = EnergyNodeManager.instance;
    reportManager = ReportManager.instance;
  });

  group('ReportManager Tests', () {
    test('HistoryValueStaticTest', () async {
      await accountManager.login(account: 'TestAdmin', password: 'P@ssw0rd');
      await accountManager.getUserInfo();
      await webManager.listTreeDataFromZero();
      await webManager.listTreeDataByGroupId();
      await webManager.searchConfig();

      var sCardType = energyNodeManager.getSCardTypes();
      if (sCardType.isEmpty) {
        expect(sCardType, isEmpty);
      } else {
        expect(sCardType, isNotEmpty);
        var nodeInfo = energyNodeManager.getSCardTypeDeviceAndNode(Random().nextInt(sCardType.length));
        expect(nodeInfo,isNotNull);
      }
      var mCardType = energyNodeManager.getMCardTypes();
      if (mCardType.isEmpty) {
        expect(mCardType, isEmpty);
      } else {
        expect(mCardType, isNotEmpty);
        var nodeInfo = energyNodeManager.getMCardTypeDeviceAndNode(Random().nextInt(mCardType.length));
        expect(nodeInfo,isNotNull);
      }
      var lCardType = energyNodeManager.getLCardTypes();
      if (lCardType.isEmpty) {
        expect(lCardType, isEmpty);
      } else {
        expect(lCardType, isNotEmpty);
        var nodeInfo = energyNodeManager.getLCardTypeDeviceAndNode(Random().nextInt(lCardType.length));
        expect(nodeInfo,isNotNull);
      }
    });
  });
}