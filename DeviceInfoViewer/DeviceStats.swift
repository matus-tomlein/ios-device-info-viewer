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
    @Published var osAvailableMemory: Int?
    @Published var machMemFree: natural_t?
    @Published var machMemTotal: natural_t?
    @Published var machMemUsed: natural_t?
    
    /// battery stats
    @Published var batteryLevel: Float?
    @Published var batteryState: String?
    @Published var lowPowerModeEnabled: Bool?
    
    /// disk stats
    @Published var volumeAvailableCapacityForOpportunisticUsage: Int64?
    @Published var volumeAvailableCapacityForImportantUsage: Int64?
    
    /// network stats
    @Published var networkStatus: String?
    
    /// other
    @Published var runningTimeSeconds: Double?
}
