//
//  ContentViewModel.swift
//  DiskSpaceProvider
//
//  Created by Amit Samant on 08/02/22.
//

import Foundation
import CoreGraphics
import DiskSpaceProvider

@dynamicMemberLookup
class ContentViewModel {
    
    struct DiskStat {
        struct DiskUsageStat {
            let barRatio: CGFloat
            let usedStorage: String
            let availableStorage: String
        }
        
        let importantUsageStat: DiskUsageStat
        let opportunisticUsageStat: DiskUsageStat
        let inaccurateApiUsageState: DiskUsageStat
        let purgeableStorage: String
        let totalStorage: String
    }
    
    let diskSpaceProvider: DiskSpaceProvider = .init()
    let byteFormatter: ByteCountFormatter = {
        let formatter = ByteCountFormatter()
        formatter.allowedUnits = .useAll
        formatter.countStyle = .decimal
        return formatter
    }()
    
    let diskStat: DiskStat
    
    subscript<T>(dynamicMember member: KeyPath<DiskStat, T>) -> T {
        get { return diskStat[keyPath: member] }
    }
    
    init() {
        self.diskStat = Self.mapDiskState(
            fromProvider: diskSpaceProvider,
            byteFormatter: byteFormatter
        )
    }
    
    private static func mapDiskState(fromProvider diskSpaceProvider: DiskSpaceProvider, byteFormatter: ByteCountFormatter) -> DiskStat {
        let totalDiskSizeInBytes = (try? diskSpaceProvider.getTotalDiskSpace()) ?? 0
        let formattedTotalDiskSizeInBytes =  byteFormatter.string(fromByteCount: totalDiskSizeInBytes)
        
        let importantUsageFreeSizeInBytes = (try? diskSpaceProvider.getFreeDiskSpace(forUsageType: .importantUsage)) ?? 0
        let importantUsageUsedSizeinBytes = totalDiskSizeInBytes - importantUsageFreeSizeInBytes
        let importantUsageRatio = CGFloat(importantUsageFreeSizeInBytes)/CGFloat(totalDiskSizeInBytes)
        let formattedImportantUsageFreeSize = byteFormatter.string(fromByteCount: importantUsageFreeSizeInBytes)
        let formattedImportantUsageUsedSize = byteFormatter.string(fromByteCount: importantUsageUsedSizeinBytes)
        
        let opportunisticUsageFreeSizeInBytes = (try? diskSpaceProvider.getFreeDiskSpace(forUsageType: .opportunisticUsage)) ?? 0
        let opportunisticUsageUsedSizeInBytes = totalDiskSizeInBytes - opportunisticUsageFreeSizeInBytes
        let opportunisticUsageRatio = CGFloat(opportunisticUsageFreeSizeInBytes)/CGFloat(totalDiskSizeInBytes)
        let formattedOpportunisticUsageFreeSize = byteFormatter.string(fromByteCount: opportunisticUsageFreeSizeInBytes)
        let formattedOpportunisticUsageUsedSize = byteFormatter.string(fromByteCount: opportunisticUsageUsedSizeInBytes)
        
        let inaccurateApiFreeSizeInBytes = (try? diskSpaceProvider.getFreeDiskSpace()) ?? 0
        let inaccurateApiUsedSizeInBytes = totalDiskSizeInBytes - inaccurateApiFreeSizeInBytes
        let inaccurateApiRatio = CGFloat(inaccurateApiUsedSizeInBytes)/CGFloat(totalDiskSizeInBytes)
        let formattedInaccurateApiFreeSize = byteFormatter.string(fromByteCount: inaccurateApiFreeSizeInBytes)
        let formattedInaccuarteApiUsedSize = byteFormatter.string(fromByteCount: inaccurateApiUsedSizeInBytes)
        
        let purgeableSizeInBytes = importantUsageFreeSizeInBytes - opportunisticUsageFreeSizeInBytes
        let formattedPurgeableSizeInBytes = byteFormatter.string(fromByteCount: purgeableSizeInBytes)
        
        
        let diskState: DiskStat = .init(
            importantUsageStat: .init(
                barRatio: importantUsageRatio,
                usedStorage: formattedImportantUsageUsedSize,
                availableStorage: formattedImportantUsageFreeSize
            ),
            opportunisticUsageStat: .init(
                barRatio: opportunisticUsageRatio,
                usedStorage: formattedOpportunisticUsageUsedSize,
                availableStorage: formattedOpportunisticUsageFreeSize
            ),
            inaccurateApiUsageState: .init(
                barRatio: inaccurateApiRatio,
                usedStorage: formattedInaccuarteApiUsedSize,
                availableStorage: formattedInaccurateApiFreeSize
            ),
            purgeableStorage: formattedPurgeableSizeInBytes,
            totalStorage: formattedTotalDiskSizeInBytes
        )
        return diskState
    }
}
