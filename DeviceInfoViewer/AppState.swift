//
//  AppState.swift
//  DeviceInfoViewer
//
//  Created by Matus Tomlein on 13/09/2021.
//

import Foundation
import SwiftUI

class AppState: ObservableObject {

    @Published var deviceStats: DeviceStats = DeviceStats()
    @Published var updatedAt: Date?
    @Published var updateFrequency = 1.0
    @Published var updateSysctlMemory = true
    @Published var updateMemoryProcess = true
    @Published var updateMachMemory = true
    @Published var updateMstatsMemory = true
    @Published var updateBattery = true
    @Published var updateDisk = true
    @Published var updateStatfsDisk = true
    @Published var updateNetwork = true
    
    var updatedAtString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter.string(from: updatedAt ?? Date(timeIntervalSince1970: TimeInterval(0)))
    }

    private var timer = Timer()
    private let updateFrequencySeconds: Double = 0.5

    func load() {
        DeviceStatsUpdater.update(deviceStats: deviceStats,
                                  updateSysctlMemory: updateSysctlMemory,
                                  updateMemoryProcess: updateMemoryProcess,
                                  updateMachMemory: updateMachMemory,
                                  updateMstatsMemory: updateMstatsMemory,
                                  updateBattery: updateBattery,
                                  updateDisk: updateDisk,
                                  updateStatfsDisk: updateStatfsDisk,
                                  updateNetwork: updateNetwork)
        self.updatedAt = Date()
        Timer.scheduledTimer(withTimeInterval: updateFrequency, repeats: false, block: { _ in
            self.load()
        })
    }
}
