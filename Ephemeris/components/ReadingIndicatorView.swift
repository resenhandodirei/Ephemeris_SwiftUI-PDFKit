//
//  ReadingIndicatorView.swift
//  Ephemeris
//
//  Created by Larissa Martins Correa on 11/12/24.
//

import SwiftUI

struct ReadingIndicatorView: View {
    let progress: Double // Valor entre 0.0 e 1.0

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color.gray.opacity(0.2))
                    .frame(height: 8)

                RoundedRectangle(cornerRadius: 4)
                    .fill(Color("darkBlue"))
                    .frame(width: geometry.size.width * CGFloat(progress), height: 8)
            }
        }
        .frame(height: 8)
    }
}

#Preview {
    ReadingIndicatorView(progress: 0.65) // 65% lido
        .frame(width: 200)
        .padding()
}
