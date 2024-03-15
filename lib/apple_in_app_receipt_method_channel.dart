import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'apple_in_app_receipt_platform_interface.dart';

/// An implementation of [AppleInAppReceiptPlatform] that uses method channels.
class MethodChannelAppleInAppReceipt extends AppleInAppReceiptPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('apple_in_app_receipt');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<bool> verifySubscription(String productId) async {
    final result = await methodChannel.invokeMethod<bool>(
      'verifySubscription',
      {'productId': productId},
    );
    return result ?? false;
  }

  @override
  Future<bool> verifyLifetimePurchase(String productId) async {
    final result = await methodChannel.invokeMethod<bool>(
      'verifyLifetimePurchase',
      {'productId': productId},
    );
    return result ?? false;
  }

  @override
  Future<bool> haveActiveSubscription() async {
    final result = await methodChannel.invokeMethod<bool>(
      'hasActiveSubscription',
    );
    return result ?? false;
  }

  @override
  Future<bool> hasActiveLifetimePurchase() async {
    final result = await methodChannel.invokeMethod<bool>(
      'hasActiveLifetimePurchase',
    );
    return result ?? false;
  }
}
