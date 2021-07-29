import Flutter
import UIKit

public class SwiftConvexBottomAppBarPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "convex_bottom_app_bar", binaryMessenger: registrar.messenger())
    let instance = SwiftConvexBottomAppBarPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result("iOS " + UIDevice.current.systemVersion)
  }
}
