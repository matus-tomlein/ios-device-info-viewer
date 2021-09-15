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
                Text("Sysctl HW_MEMSIZE: \(deviceStats.memSizeString)")
                Text("Sysctl HW_USERMEM: \(deviceStats.userMemoryString)")
                Text("Sysctl HW_PHYSMEM: \(deviceStats.physicalMemorySyctlString)")
                Text("ProcessInfo physical memory: \(deviceStats.physicalMemoryString)")
                Text("OS available memory: \(deviceStats.osAvailableMemoryString)")
                Text("Mach free memory: \(deviceStats.machMemFreeString)")
                Text("Mach used memory: \(deviceStats.machMemUsedString)")
                Text("Mach total memory: \(deviceStats.machMemTotalString)")
            }

            Section(header: Text("Battery")) {
                Text(String(format: "Level: %.02f", deviceStats.batteryLevel ?? -1))
                Text("State: \(deviceStats.batteryState ?? "unknown")")
                Text("Low power mode: \((deviceStats.lowPowerModeEnabled ?? false) ? "yes" : "no")")
            }

            Section(header: Text("Disk")) {
                Text("Opportunistic usage capacity: \(deviceStats.volumeAvailableCapacityForOpportunisticUsageString)")
                Text("Important usage capacity: \(deviceStats.volumeAvailableCapacityForImportantUsageString)")
                Text("Total capacity: \(deviceStats.volumeTotalCapacityString)")
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
