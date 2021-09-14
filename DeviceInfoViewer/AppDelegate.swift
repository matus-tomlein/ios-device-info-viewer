//
//  AppDelegate.swift
//  DeviceInfoViewer
//
//  Created by Matus Tomlein on 09/09/2021.
//

import Foundation
import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        UIDevice.current.isBatteryMonitoringEnabled = true
        return true
    }
}
