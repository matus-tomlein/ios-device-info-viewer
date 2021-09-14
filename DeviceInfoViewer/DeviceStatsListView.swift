//
//  ContentView.swift
//  DeviceInfoViewer
//
//  Created by Matus Tomlein on 09/09/2021.
//

import SwiftUI
import SystemConfiguration
import os

struct DeviceStatsListView: View {
    @EnvironmentObject var appState: AppState
    var deviceStats: DeviceStats { appState.deviceStats }

    var body: some View {
        List {
            Section(header: Text("Memory")) {
                Text(String(format: "Sysctl HW_MEMSIZE: %u bytes", deviceStats.memSize ?? 0))
                Text(String(format: "Sysctl HW_USERMEM: %u bytes", deviceStats.userMemory ?? 0))
                Text(String(format: "ProcessInfo physical memory: %u bytes", deviceStats.physicalMemory ?? 0))
                Text(String(format: "OS available memory: %u bytes", deviceStats.osAvailableMemory ?? 0))
                Text(String(format: "Mach free memory: %u bytes", deviceStats.machMemFree ?? 0))
                Text(String(format: "Mach used memory: %u bytes", deviceStats.machMemUsed ?? 0))
                Text(String(format: "Mach total memory: %u bytes", deviceStats.machMemTotal ?? 0))
            }

            Section(header: Text("Battery")) {
                Text(String(format: "Level: %.02f", deviceStats.batteryLevel ?? -1))
                Text("State: \(deviceStats.batteryState ?? "unknown")")
                Text("Low power mode: \((deviceStats.lowPowerModeEnabled ?? false) ? "yes" : "no")")
            }

            Section(header: Text("Disk")) {
                Text(String(format: "Opportunistic usage capacity: %d bytes", deviceStats.volumeAvailableCapacityForOpportunisticUsage ?? 0))
                Text(String(format: "Important usage capacity: %d bytes", deviceStats.volumeAvailableCapacityForImportantUsage ?? 0))
            }

            Section(header: Text("Network")) {
                Text("Snowplow Analytics reachable via: \(deviceStats.networkStatus ?? "unknown")")
            }

            Section(header: Text("Info")) {
                Text("Time to update stats: \(deviceStats.runningTimeSeconds ?? 0) seconds")
                Text("Updated at: \(appState.updatedAtString)")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        DeviceStatsListView().environmentObject(AppState())
    }
}
