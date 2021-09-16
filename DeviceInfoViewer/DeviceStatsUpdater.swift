//
//  StatsUpdater.swift
//  DeviceInfoViewer
//
//  Created by Matus Tomlein on 13/09/2021.
//

import Foundation
import SystemConfiguration
import os
import SwiftUI
import UIKit

class DeviceStatsUpdater {

    static func update(deviceStats: DeviceStats) {
        DispatchQueue.global(qos: .userInitiated).async {
            let start = DispatchTime.now()

            let memSize = getHWMemSize()
            let userMemory = getHWUserMem()
            let physicalMemory = ProcessInfo.processInfo.physicalMemory /// The amount of physical memory on the computer in bytes.
            let sysCtlPhysicalMemory = getHWPhysMem()
            let osAvailableMemory = os_proc_available_memory() /// The amount of memory available to the current app. iOS 13+, not on MacOS
            let memoryStats = getMachMemoryStats()

            let batteryLevel = UIDevice.current.batteryLevel
            let batteryState = getBatterState()
            let lowPowerModeEnabled = ProcessInfo.processInfo.isLowPowerModeEnabled

            let volumeAvailableCapacityForOpportunisticUsage = getVolumeAvailableCapacityForOpportunisticUsage()
            let volumeAvailableCapacityForImportantUsage = getVolumeAvailableCapacityForImportantUsage()
            let volumeTotalCapacity = getVolumeTotalCapacity()

            let networkStatus = getNetworkStatus()

            let mstats = mstats()

            let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
            let documentsDirectory = paths[0]
            let path = documentsDirectory.cString(using: .utf8)!
            let statfsFree = statfsFree(path)
            let statfsTotal = statfsTotal(path)

            let end = DispatchTime.now()
            let nanoTime = end.uptimeNanoseconds - start.uptimeNanoseconds
            let timeIntervalSeconds = Double(nanoTime) / 1_000_000_000

            DispatchQueue.main.async {
                deviceStats.memSize = memSize
                deviceStats.userMemory = userMemory
                deviceStats.physicalMemory = physicalMemory
                deviceStats.physicalMemorySyctl = sysCtlPhysicalMemory
                deviceStats.osAvailableMemory = osAvailableMemory

                deviceStats.machMemFree = memoryStats?.mem_free
                deviceStats.machMemUsed = memoryStats?.mem_used
                deviceStats.machMemTotal = memoryStats?.mem_total

                deviceStats.mstatsBytesFree = mstats.bytes_free
                deviceStats.mstatsBytesUsed = mstats.bytes_used
                deviceStats.mstatsBytesTotal = mstats.bytes_total

                deviceStats.batteryLevel = batteryLevel
                deviceStats.batteryState = batteryState
                deviceStats.lowPowerModeEnabled = lowPowerModeEnabled

                deviceStats.volumeAvailableCapacityForOpportunisticUsage = volumeAvailableCapacityForOpportunisticUsage
                deviceStats.volumeAvailableCapacityForImportantUsage = volumeAvailableCapacityForImportantUsage
                deviceStats.volumeTotalCapacity = volumeTotalCapacity

                deviceStats.networkStatus = networkStatus
                deviceStats.runningTimeSeconds = timeIntervalSeconds

                deviceStats.statfsFree = statfsFree
                deviceStats.statfsTotal = statfsTotal
            }
        }
    }

    private static func getHWPhysMem() -> UInt32 {
        return try! Sysctl.value(ofType: UInt32.self, forKeys: [CTL_HW, HW_PHYSMEM]) /// The bytes of physical memory.
    }

    private static func getHWMemSize() -> UInt64 {
        return try! Sysctl.value(ofType: UInt64.self, forKeys: [CTL_HW, HW_MEMSIZE]) /// physical ram size
    }

    private static func getHWUserMem() -> UInt32 {
        return try! Sysctl.value(ofType: UInt32.self, forKeys: [CTL_HW, HW_USERMEM]) /// The bytes of non-kernel memory.
    }

    private static func getVolumeAvailableCapacityForOpportunisticUsage() -> Int64? {
        return (
            try? URL(fileURLWithPath: NSHomeDirectory()).resourceValues(forKeys: [.volumeAvailableCapacityForOpportunisticUsageKey])
        )?.volumeAvailableCapacityForOpportunisticUsage
    }

    private static func getVolumeAvailableCapacityForImportantUsage() -> Int64? {
        return (
            try? URL(fileURLWithPath: NSHomeDirectory()).resourceValues(forKeys: [.volumeAvailableCapacityForImportantUsageKey])
        )?.volumeAvailableCapacityForImportantUsage
    }

    private static func getVolumeTotalCapacity() -> Int? {
        return (
            try? URL(fileURLWithPath: NSHomeDirectory()).resourceValues(forKeys: [.volumeTotalCapacityKey])
        )?.volumeTotalCapacity
    }

    private static func getBatterState() -> String {
        switch UIDevice.current.batteryState {
            case .charging:
                return "Charging"
            case .full:
                return "Full"
            case .unknown:
                return "Unknown"
            case .unplugged:
                return "Unplugged"
            @unknown default:
                return "Other unknown"
        }
    }

    private static func getNetworkStatus() -> String {
        let reachability = SCNetworkReachabilityCreateWithName(nil, "www.snowplowanalytics.com")
        var flags = SCNetworkReachabilityFlags()
        SCNetworkReachabilityGetFlags(reachability!, &flags)
        return flags.contains(.reachable) ? (
            flags.contains(.isWWAN) ? "mobile data" : "wifi"
        ) : "not reachable"
    }
}
