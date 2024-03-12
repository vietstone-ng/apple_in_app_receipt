import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'apple_in_app_receipt_method_channel.dart';

abstract class AppleInAppReceiptPlatform extends PlatformInterface {
  /// Constructs a AppleInAppReceiptPlatform.
  AppleInAppReceiptPlatform() : super(token: _token);

  static final Object _token = Object();

  static AppleInAppReceiptPlatform _instance = MethodChannelAppleInAppReceipt();

  /// The default instance of [AppleInAppReceiptPlatform] to use.
  ///
  /// Defaults to [MethodChannelAppleInAppReceipt].
  static AppleInAppReceiptPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [AppleInAppReceiptPlatform] when
  /// they register themselves.
  static set instance(AppleInAppReceiptPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<bool> verifySubscription(String productId) {
    throw UnimplementedError('verifySubscription() has not been implemented.');
  }

  Future<bool> verifyPurchase(String productId) {
    throw UnimplementedError('verifyPurchase() has not been implemented.');
  }

  Future<bool> haveActiveSubscription() {
    throw UnimplementedError(
        'haveActiveSubscription() has not been implemented.');
  }

  Future<bool> havePurchases() {
    throw UnimplementedError('havePurchases() has not been implemented.');
  }
}
