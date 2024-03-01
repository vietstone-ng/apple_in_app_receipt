
import 'apple_in_app_receipt_platform_interface.dart';

class AppleInAppReceipt {
  Future<String?> getPlatformVersion() {
    return AppleInAppReceiptPlatform.instance.getPlatformVersion();
  }
}
