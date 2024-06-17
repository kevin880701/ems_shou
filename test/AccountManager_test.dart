import 'package:ems_app/net/remote/Managers/AccountManager.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:ems_app/net/remote/NetworkInterface.dart';

class MockNetworkInterface extends Mock implements NetworkInterface {}

void main() {
  late AccountManager accountManager;
  late MockNetworkInterface mockNetwork;

  setUp(() {
    accountManager = AccountManager.instance;
  });

  group('AccountManager Tests', () {
    test('Login Success', () async {
      final result = await accountManager.login(account: 'TestAdmin', password: 'P@ssw0rd');
      expect(result, true);
      expect(accountManager.userToken, isA<String>());
    });

    test('GetUserInfo Success', () async {
      await accountManager.login(account: 'TestAdmin', password: 'P@ssw0rd');
      final result = await accountManager.getUserInfo();
      expect(result, true);
      expect(accountManager.currentUserDetailInfo, isNotNull);
    });
  });
}