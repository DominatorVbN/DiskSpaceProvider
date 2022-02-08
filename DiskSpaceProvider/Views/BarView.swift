//
//  BarView.swift
//  DiskSpaceProvider
//
//  Created by Amit Samant on 08/02/22.
//

import SwiftUI

struct BarView: View {
    let filledProportion: CGFloat
    var body: some View {
        GeometryReader  { geo in
            HStack(spacing:0) {
                Color.accentColor.frame(width: geo.size.width * filledProportion)
                Color.green
                    .saturation(0.5)
                    .frame(width: geo.size.width * (1 - filledProportion))
            }
        }
        .frame(height: 16)
        .cornerRadius(3)
    }
}

struct BarView_Previews: PreviewProvider {
    static var previews: some View {
        BarView(filledProportion: 0.8)
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
