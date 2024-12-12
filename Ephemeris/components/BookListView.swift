//
//  BookListView.swift
//  Ephemeris
//
//  Created by Larissa Martins Correa on 11/12/24.
//

import SwiftUI

struct BookListView: View {
    var body: some View {
        VStack {
            HStack {
                ZStack {
                    Rectangle()
                        .foregroundColor(.darkBlue.opacity(0.9))
                        .frame(height: 160)
                        .cornerRadius(8.0)
                        .padding(3)
                    
                    VStack {
                        HStack {
                            Image(systemName: "heart.fill")
                                .foregroundColor(.white)
                            Text("curtidos")
                                .textCase(.uppercase)
                                .font(.headline)
                                .foregroundColor(.white)
                        }.padding(.bottom, 16)
                        
                        
                        Text("45")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                    }
                    
                }
                
                ZStack {
                    Rectangle()
                        .foregroundColor(.darkBlue.opacity(0.9))
                        .foregroundColor(.darkBlue.opacity(0.9))
                        .frame(height: 160)
                        .cornerRadius(8.0)
                        .padding(3)
                    
                    VStack {
                        HStack {
                            Image(systemName: "heart.fill")
                                .foregroundColor(.white)
                            Text("SALVOS")
                                .textCase(.uppercase)
                                .font(.headline)
                                .foregroundColor(.white)
                        }.padding(.bottom, 16)
                        
                        Text("10")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                    }
                }
            }
        }
    }
}

#Preview {
    BookListView()
}
