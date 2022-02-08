//
//  StatRowView.swift
//  DiskSpaceProvider
//
//  Created by Amit Samant on 08/02/22.
//

import SwiftUI

struct StatRowView: View {
    
    let title: String
    let formattedValue: String
    
    var body: some View {
        HStack {
            Text(title)
            Spacer()
            Text(formattedValue)
                .font(.body)
                .foregroundColor(.secondary)
        }
    }
}

struct StatRowView_Previews: PreviewProvider {
    static var previews: some View {
        StatRowView(title: "Used storage", formattedValue: "100 MB")
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
