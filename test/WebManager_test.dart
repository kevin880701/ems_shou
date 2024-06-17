import 'package:ems_app/net/remote/Managers/WebManager.dart';
import 'package:flutter_test/flutter_test.dart';


void main() {

  late WebManager webManager;

  setUp(() {
    webManager = WebManager.instance;
  });

  group('WebManager Tests', () {
    test('ListDeviceTest', () async {
      final result = await webManager.getListDevice();
      expect(result, isNotNull);
    });
  });
}