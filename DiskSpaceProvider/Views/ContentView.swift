//
//  ContentView.swift
//  DiskSpaceProvider
//
//  Created by Amit Samant on 08/02/22.
//

import SwiftUI

struct ContentView: View {
    
    let viewModel = ContentViewModel()
    
    var body: some View {
        NavigationView {
            List {
                StatSectionView(
                    title: "Important Usage",
                    stat: viewModel.importantUsageStat,
                    totalStorage: viewModel.totalStorage
                )
                StatSectionView(
                    title: "Opportunistic Usage",
                    stat: viewModel.diskStat.opportunisticUsageStat,
                    totalStorage: viewModel.totalStorage
                )
                StatSectionView(
                    title: "Inaccurate iOS 11 prior API Storage Usage",
                    stat: viewModel.diskStat.inaccurateApiUsageState,
                    totalStorage: viewModel.totalStorage
                )
                StatRowView(title: "Purgeable storage", formattedValue: viewModel.purgeableStorage)
                    .font(.headline)
                StatRowView(title: "Total storage", formattedValue: viewModel.totalStorage)
                    .font(.headline)
                
            }
            .navigationTitle("Storage")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

