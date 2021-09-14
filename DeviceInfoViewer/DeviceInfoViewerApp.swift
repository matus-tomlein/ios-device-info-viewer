//
//  DeviceInfoViewerApp.swift
//  DeviceInfoViewer
//
//  Created by Matus Tomlein on 09/09/2021.
//

import SwiftUI

@main
struct DeviceInfoViewerApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @State var appState: AppState = AppState()

    init() {
        appState.load()
    }

    var body: some Scene {
        WindowGroup {
            DeviceStatsListView().environmentObject(appState)
        }
    }
}
