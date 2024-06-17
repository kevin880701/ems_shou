
import 'package:ems_app/repository/AccountRepository.dart';
import 'package:ems_app/repository/CommandRepository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:ems_app/net/remote/NetworkInterface.dart';

class MockNetworkInterface extends Mock implements NetworkInterface {}

void main() {
  late CommandRepository commandRepository;
  late AccountRepository accountRepository;
  late MockNetworkInterface mockNetwork;

  setUp(() {
   accountRepository = AccountRepository.instance;
    commandRepository = CommandRepository();
    accountRepository.login(account: 'TestAdmin', password: "P@ssw0rd");
  });

  group('Command Tests', () {
    test('setSelfUseModeValue',() async {
      Future.delayed(Duration(seconds: 1) , () async {
        final result = await commandRepository.sendSelfUseModeCmd('1','1105','1305','99');
        expect(result, true);
      });
    });

    test('setSaveModeOneValue',() async {
      Future.delayed(Duration(seconds: 1) , () async {
        final result = await commandRepository.setSaveModeOneValue('0900120018002100');
        expect(result, true);
      });
    });

    test('setSaveModeTwoValue',() async {
      Future.delayed(Duration(seconds: 1) , () async {
        final result = await commandRepository.setSaveModeTwoValue('0900120018002100');
        expect(result, true);
      });
    });

    test("BatteryPriorityMode", () async {
      Future.delayed(Duration(seconds: 1) , () async {
        final result = await commandRepository.setBatteryProrityModeValue();
        expect(result, true);
      });
    });
  });
}