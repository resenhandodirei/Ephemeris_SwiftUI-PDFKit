//
//  HeaderView.swift
//  Ephemeris
//
//  Created by Larissa Martins Correa on 11/12/24.
//

import SwiftUI

struct HeaderView: View {
    @State private var userImage: Image? = Image("user_placeholder")
    @State private var userName: String = "Larissa"

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Bem-vinda de volta, \(userName)!")
                    .font(.headline)
                    .foregroundColor(.bege)

                Text("Descubra novos desafios de leitura!")
                    .font(.subheadline)
                    .foregroundColor(.nude)
            }

            Spacer()

            if let image = userImage {
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                    .overlay(
                        Circle()
                            .stroke(Color.nude.opacity(0.5), lineWidth: 1)
                    )
            } else {
                Circle()
                    .fill(Color.nude.opacity(0.3))
                    .frame(width: 50, height: 50)
                    .overlay(
                        Image(systemName: "person.fill")
                            .foregroundColor(.nude)
                    )
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.darkBlue.opacity(0.9)) 
        .cornerRadius(12)
        .shadow(color: Color.bege, radius: 5, x: 0, y: 2)
    }
}

struct Header_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView()
            .previewLayout(.sizeThatFits)
            .padding()
    }
}

