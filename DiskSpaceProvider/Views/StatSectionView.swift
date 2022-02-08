//
//  StatSectionView.swift
//  DiskSpaceProvider
//
//  Created by Amit Samant on 08/02/22.
//

import SwiftUI

struct StatSectionView: View {
    
    let title: String
    let stat: ContentViewModel.DiskStat.DiskUsageStat
    let totalStorage: String
    
    var body: some View {
        Section(title) {
            VStack(alignment: .trailing, spacing: 2) {
                Text("\(stat.usedStorage) of \(totalStorage) Used")
                    .font(.caption)
                    .foregroundColor(.secondary)
                BarView(filledProportion: stat.barRatio)
            }
            .padding(.vertical, 4)
            StatRowView(title: "Used storage", formattedValue: stat.usedStorage)
            StatRowView(title: "Available storage", formattedValue: stat.availableStorage)
        }
    }
}

struct StatSectionView_Previews: PreviewProvider {
    static var previews: some View {
        List {
            StatSectionView(
                title: "Important usage",
                stat: .init(
                    barRatio: 0.7,
                    usedStorage: "41.6 GB",
                    availableStorage: "22 GB"
                ),
                totalStorage: "64 GB"
            )
        }
        .padding(.vertical)
    }
}
