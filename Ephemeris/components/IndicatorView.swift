//
//  IndicatorView.swift
//  Ephemeris
//
//  Created by Larissa Martins Correa on 11/12/24.
//

import SwiftUI

struct IndicatorView: View {
    let totalPages: Int
    let currentPage: Int

    var body: some View {
        HStack(spacing: 8) {
            ForEach(0..<totalPages, id: \.self) { index in
                Circle()
                    .fill(index == currentPage ? Color("darkBlue") : Color.gray.opacity(0.5))
                    .frame(width: 8, height: 8)
            }
        }
    }
}

#Preview {
    IndicatorView(totalPages: 5, currentPage: 2)
}

