import 'package:flutter_test/flutter_test.dart';
import 'package:apple_in_app_receipt/apple_in_app_receipt.dart';
import 'package:apple_in_app_receipt/apple_in_app_receipt_platform_interface.dart';
import 'package:apple_in_app_receipt/apple_in_app_receipt_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockAppleInAppReceiptPlatform
    with MockPlatformInterfaceMixin
    implements AppleInAppReceiptPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final AppleInAppReceiptPlatform initialPlatform = AppleInAppReceiptPlatform.instance;

  test('$MethodChannelAppleInAppReceipt is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelAppleInAppReceipt>());
  });

  test('getPlatformVersion', () async {
    AppleInAppReceipt appleInAppReceiptPlugin = AppleInAppReceipt();
    MockAppleInAppReceiptPlatform fakePlatform = MockAppleInAppReceiptPlatform();
    AppleInAppReceiptPlatform.instance = fakePlatform;

    expect(await appleInAppReceiptPlugin.getPlatformVersion(), '42');
  });
}
