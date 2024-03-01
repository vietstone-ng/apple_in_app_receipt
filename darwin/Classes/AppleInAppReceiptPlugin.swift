#if os(OSX)
import Cocoa
import FlutterMacOS
#else
import Flutter
import UIKit
#endif

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
    default:
      result(FlutterMethodNotImplemented)
    }
  }
}
