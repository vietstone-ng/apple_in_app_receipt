#if os(OSX)
  import Cocoa
  import FlutterMacOS
#else
  import Flutter
  import UIKit
#endif

import TPInAppReceipt

public class AppleInAppReceiptPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    #if os(OSX)
      let messenger = registrar.messenger
    #else
      let messenger = registrar.messenger()
    #endif

    let channel = FlutterMethodChannel(name: "apple_in_app_receipt", binaryMessenger: messenger)
    let instance = AppleInAppReceiptPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getPlatformVersion":
      #if os(OSX)
        result("macOS " + ProcessInfo.processInfo.operatingSystemVersionString)
      #else
        result("iOS " + UIDevice.current.systemVersion)
      #endif
    case "verifySubscription":
      let arguments = call.arguments as? [String: Any]
      let productId = arguments?["productId"] as? String ?? ""
      _verifySubscription(productId: productId, result: result)
    case "verifyPurchase":
      let arguments = call.arguments as? [String: Any]
      let productId = arguments?["productId"] as? String ?? ""
      _verifyPurchase(productId: productId, result: result)
    case "hasActiveSubscription":
      _hasActiveSubscription(result: result)
    case "havePurchases":
      _havePurchases(result: result)
    default:
      result(FlutterMethodNotImplemented)
    }
  }
}

private func _verifySubscription(productId: String, result: @escaping FlutterResult) {
  func _verify() -> Bool {
    if let receipt = try? InAppReceipt.localReceipt(),
       let _ = try? receipt.validate()
    {
      let actives = receipt.activeAutoRenewableSubscriptionPurchases
      return actives.contains { $0.productIdentifier == productId }
    }
    return false
  }

  InAppReceipt.refresh { _ in
    result(_verify())
  }
}

private func _verifyPurchase(productId: String, result: @escaping FlutterResult) {
  func _verify() -> Bool {
    if let receipt = try? InAppReceipt.localReceipt(),
       let _ = try? receipt.validate()
    {
      return receipt.containsPurchase(ofProductIdentifier: productId)
    }
    return false
  }

  InAppReceipt.refresh { _ in
    result(_verify())
  }
}

private func _hasActiveSubscription(result: @escaping FlutterResult) {
  func _verify() -> Bool {
    if let receipt = try? InAppReceipt.localReceipt(),
       let _ = try? receipt.validate()
    {
      return receipt.hasActiveAutoRenewablePurchases
    }
    return false
  }

  InAppReceipt.refresh { _ in
    result(_verify())
  }
}

private func _havePurchases(result: @escaping FlutterResult) {
  func _verify() -> Bool {
    if let receipt = try? InAppReceipt.localReceipt(),
       let _ = try? receipt.validate()
    {
      return receipt.hasPurchases
    }
    return false
  }

  InAppReceipt.refresh { _ in
    result(_verify())
  }
}
