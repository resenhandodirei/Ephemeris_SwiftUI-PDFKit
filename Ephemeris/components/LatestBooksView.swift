//
//  LatestBooksView.swift
//  Ephemeris
//
//  Created by Larissa Martins Correa on 11/12/24.
//

import SwiftUI

// Modelo do Livro (renomeado para evitar conflito)
struct BookItem: Identifiable {
    var id = UUID()
    var title: String
    var author: String
    var releaseDate: String
}

// Componente LatestBooksView
struct LatestBooksView: View {
    // Lista de livros (você pode adicionar mais livros aqui)
    let books: [BookItem] = [
        BookItem(title: "O Mistério do Mar", author: "Ana Souza", releaseDate: "10/12/2024"),
        BookItem(title: "Corações em Fuga", author: "Carlos Lima", releaseDate: "05/12/2024"),
        BookItem(title: "Além das Estrelas", author: "Mariana Rocha", releaseDate: "01/12/2024"),
        BookItem(title: "A Jornada do Destino", author: "João Costa", releaseDate: "28/11/2024")
    ]
    
    var body: some View {
        VStack {
            ZStack {
                Rectangle()
                    .foregroundColor(.bege)  // Usando a cor 'Beige' do Assets
                    .opacity(0.7)
                    .frame(width: 360)
                    .cornerRadius(8.0)
                
                VStack(alignment: .leading) {
                    Text("Últimos livros lançados")
                        .textCase(.uppercase)
                        .font(.title2)
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.darkBlue)
                        .padding(.top)
                    
                    // Lista de livros
                    ScrollView {
                        VStack(alignment: .leading, spacing: 15) {
                            ForEach(books) { book in
                                VStack(alignment: .leading, spacing: 10) {
                                    Text(book.title)
                                        .font(.headline)
                                        .foregroundColor(.primary)
                                    
                                    Text("Autor: \(book.author)")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                    
                                    Text("Lançado em: \(book.releaseDate)")
                                        .font(.footnote)
                                        .foregroundColor(.gray)
                                }
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 10).fill(Color.blue.opacity(0.1)))
                                .shadow(radius: 5)
                            }
                        }
                        .padding(.bottom)
                    }
                }
                .padding()
            }
        }
    }
}

#Preview {
    LatestBooksView()
}
