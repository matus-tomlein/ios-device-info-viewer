//
//  DeviceStats.swift
//  DeviceInfoViewer
//
//  Created by Matus Tomlein on 13/09/2021.
//

import Foundation
import SwiftUI

class DeviceStats: ObservableObject {
    /// memory stats
    @Published var memSize: UInt64?
    @Published var userMemory: UInt32?
    @Published var physicalMemory: UInt64?
    @Published var physicalMemorySyctl: UInt32?
    @Published var osAvailableMemory: Int?
    @Published var machMemFree: natural_t?
    @Published var machMemTotal: natural_t?
    @Published var machMemUsed: natural_t?
    @Published var mstatsBytesFree: Int?
    @Published var mstatsBytesUsed: Int?
    @Published var mstatsBytesTotal: Int?
    
    var memSizeString: String {
        ByteCountFormatter().string(fromByteCount: Int64(memSize ?? 0))
    }
    var userMemoryString: String {
        ByteCountFormatter().string(fromByteCount: Int64(userMemory ?? 0))
    }
    var physicalMemoryString: String {
        ByteCountFormatter().string(fromByteCount: Int64(physicalMemory ?? 0))
    }
    var physicalMemorySyctlString: String {
        ByteCountFormatter().string(fromByteCount: Int64(physicalMemorySyctl ?? 0))
    }
    var osAvailableMemoryString: String {
        ByteCountFormatter().string(fromByteCount: Int64(osAvailableMemory ?? 0))
    }
    var machMemFreeString: String {
        ByteCountFormatter().string(fromByteCount: Int64(machMemFree ?? 0))
    }
    var machMemTotalString: String {
        ByteCountFormatter().string(fromByteCount: Int64(machMemTotal ?? 0))
    }
    var machMemUsedString: String {
        ByteCountFormatter().string(fromByteCount: Int64(machMemUsed ?? 0))
    }
    var mstatsFreeString: String {
        ByteCountFormatter().string(fromByteCount: Int64(mstatsBytesFree ?? 0))
    }
    var mstatsUsedString: String {
        ByteCountFormatter().string(fromByteCount: Int64(mstatsBytesUsed ?? 0))
    }
    var mstatsTotalString: String {
        ByteCountFormatter().string(fromByteCount: Int64(mstatsBytesTotal ?? 0))
    }

    /// battery stats
    @Published var batteryLevel: Float?
    @Published var batteryState: String?
    @Published var lowPowerModeEnabled: Bool?

    /// disk stats
    @Published var volumeAvailableCapacity: Int?
    @Published var volumeAvailableCapacityForOpportunisticUsage: Int64?
    @Published var volumeAvailableCapacityForImportantUsage: Int64?
    @Published var volumeTotalCapacity: Int?
    @Published var statfsFree: Int?
    @Published var statfsTotal: Int?

    var volumeAvailableCapacityString: String {
        ByteCountFormatter().string(fromByteCount: Int64(volumeAvailableCapacity ?? 0))
    }
    var volumeAvailableCapacityForOpportunisticUsageString: String {
        ByteCountFormatter().string(fromByteCount: volumeAvailableCapacityForOpportunisticUsage ?? 0)
    }
    var volumeAvailableCapacityForImportantUsageString: String {
        ByteCountFormatter().string(fromByteCount: volumeAvailableCapacityForImportantUsage ?? 0)
    }
    var volumeTotalCapacityString: String {
        ByteCountFormatter().string(fromByteCount: Int64(volumeTotalCapacity ?? 0))
    }
    var statfsFreeString: String {
        ByteCountFormatter().string(fromByteCount: Int64(statfsFree ?? 0))
    }
    var statfsTotalString: String {
        ByteCountFormatter().string(fromByteCount: Int64(statfsTotal ?? 0))
    }

    /// network stats
    @Published var networkStatus: String?

    /// other
    @Published var runningTimeSeconds: Double?
}
