//
//  DiskSpaceProvider.swift
//  DiskSpaceProvider
//
//  Created by Amit Samant on 08/02/22.
//

import Foundation

class DiskSpaceProvider {
    
    enum UsageType {
        case importantUsage
        case opportunisticUsage
    }
    
    private let homeDirectoryPath = NSHomeDirectory() as String
    private let homeDirectoryUrl = URL(fileURLWithPath: NSHomeDirectory() as String)
    
    func getTotalDiskSpace() throws -> Int64 {
        let systemAttributes = try FileManager.default.attributesOfFileSystem(forPath: homeDirectoryPath)
        let space = (systemAttributes[FileAttributeKey.systemSize] as? NSNumber)?.int64Value
        return space ?? 0
    }
    
    @available(iOS 11.0, *)
    func getFreeDiskSpace(forUsageType usageType: UsageType) throws -> Int64 {
        let size: Int64?
        switch usageType {
        case .importantUsage:
            let resourceKey = URLResourceKey.volumeAvailableCapacityForImportantUsageKey
            let resourceValues = try homeDirectoryUrl.resourceValues(forKeys: [resourceKey])
             size = resourceValues.volumeAvailableCapacityForImportantUsage
        case .opportunisticUsage:
            let resourceKey = URLResourceKey.volumeAvailableCapacityForOpportunisticUsageKey
            let resourceValues = try homeDirectoryUrl.resourceValues(forKeys: [resourceKey])
            size = resourceValues.volumeAvailableCapacityForOpportunisticUsage
        }
        return size ?? 0
    }
    
    func getFreeDiskSpace() throws -> Int64 {
        let systemAttributes = try FileManager.default.attributesOfFileSystem(forPath: homeDirectoryPath)
        let freeSpace = (systemAttributes[FileAttributeKey.systemFreeSize] as? NSNumber)?.int64Value
        return freeSpace ?? 0
    }
    
}
