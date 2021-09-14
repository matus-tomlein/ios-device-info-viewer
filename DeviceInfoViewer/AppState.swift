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
    var updatedAtString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter.string(from: updatedAt ?? Date(timeIntervalSince1970: TimeInterval(0)))
    }

    private var timer = Timer()
    private let updateFrequencySeconds: Double = 0.5

    func load() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
            DeviceStatsUpdater.update(deviceStats: self.deviceStats)
            self.updatedAt = Date()
        })
    }
}
