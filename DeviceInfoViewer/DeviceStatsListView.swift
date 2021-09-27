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
            Section(header: Text("Update frequency (seconds)")) {
                if #available(iOS 15.0, *) {
                    TextField("Update frequency (seconds)", value: $appState.updateFrequency, format: .number)
                }
                Toggle(isOn: $appState.updateSysctlMemory) {
                    Text("Update memory sysctl")
                }
                Toggle(isOn: $appState.updateMemoryProcess) {
                    Text("Update memory process")
                }
                Toggle(isOn: $appState.updateMachMemory) {
                    Text("Update memory mach")
                }
                Toggle(isOn: $appState.updateMstatsMemory) {
                    Text("Update memory mstats")
                }
                Toggle(isOn: $appState.updateBattery) {
                    Text("Update battery")
                }
                Toggle(isOn: $appState.updateDisk) {
                    Text("Update disk")
                }
                Toggle(isOn: $appState.updateStatfsDisk) {
                    Text("Update disk statfs")
                }
                Toggle(isOn: $appState.updateNetwork) {
                    Text("Update network")
                }
            }

            if (appState.updateSysctlMemory) {
                Section(header: Text("Memory sysctl")) {
                    Text("Sysctl HW_MEMSIZE: \(deviceStats.memSizeString)")
                    Text("Sysctl HW_USERMEM: \(deviceStats.userMemoryString)")
                    Text("Sysctl HW_PHYSMEM: \(deviceStats.physicalMemorySyctlString)")
                }
            }

            if (appState.updateMemoryProcess) {
                Section(header: Text("Memory process")) {
                    Text("ProcessInfo physical memory: \(deviceStats.physicalMemoryString)")
                    Text("OS available memory: \(deviceStats.osAvailableMemoryString)")
                }
            }

            if (appState.updateMachMemory) {
                Section(header: Text("Memory mach")) {
                    Text("Mach free memory: \(deviceStats.machMemFreeString)")
                    Text("Mach used memory: \(deviceStats.machMemUsedString)")
                    Text("Mach total memory: \(deviceStats.machMemTotalString)")
                }
            }

            if (appState.updateMstatsMemory) {
                Section(header: Text("Memory mstats")) {
                    Text("Mstats free memory: \(deviceStats.mstatsFreeString)")
                    Text("Mstats used memory: \(deviceStats.mstatsUsedString)")
                    Text("Mstats total memory: \(deviceStats.mstatsTotalString)")
                }
            }

            if (appState.updateBattery) {
                Section(header: Text("Battery")) {
                    Text(String(format: "Level: %.02f", deviceStats.batteryLevel ?? -1))
                    Text("State: \(deviceStats.batteryState ?? "unknown")")
                    Text("Low power mode: \((deviceStats.lowPowerModeEnabled ?? false) ? "yes" : "no")")
                }
            }

            if (appState.updateDisk) {
                Section(header: Text("Disk")) {
                    Text("Available capacity: \(deviceStats.volumeAvailableCapacityString)")
                    Text("Opportunistic usage capacity: \(deviceStats.volumeAvailableCapacityForOpportunisticUsageString)")
                    Text("Important usage capacity: \(deviceStats.volumeAvailableCapacityForImportantUsageString)")
                    Text("Total capacity: \(deviceStats.volumeTotalCapacityString)")
                }
            }

            if (appState.updateStatfsDisk) {
                Section(header: Text("Disk statfs")) {
                    Text("Statfs free: \(deviceStats.statfsFreeString)")
                    Text("Statfs total: \(deviceStats.statfsTotalString)")
                }
            }

            if (appState.updateNetwork) {
                Section(header: Text("Network")) {
                    Text("Snowplow Analytics reachable via: \(deviceStats.networkStatus ?? "unknown")")
                }
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
