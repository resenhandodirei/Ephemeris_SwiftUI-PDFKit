//
//  MainView.swift
//  Ephemeris
//
//  Created by Larissa Martins Correa on 11/12/24.
//

import SwiftUI

struct MainView: View {
    // Lista de livros mockados
    let books: [BookCardModel] = [
        BookCardModel(title: "1984", author: "George Orwell", pageCount: 328, synopsis: "Distopia totalitária.", imageName: "book_placeholder", readingProgress: 0.5),
        BookCardModel(title: "O Sol é Para Todos", author: "Harper Lee", pageCount: 336, synopsis: "Racismo e justiça no sul dos EUA.", imageName: "book_placeholder", readingProgress: 0.8),
        BookCardModel(title: "Orgulho e Preconceito", author: "Jane Austen", pageCount: 279, synopsis: "Romance clássico e crítica social.", imageName: "book_placeholder", readingProgress: 0.6)
    ]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                
                HeaderView()
                    .padding(.bottom, 16)
                    .edgesIgnoringSafeArea(.all)
                    
                
                SearchView()
                
                // Espaço para distanciar do Header
                
                
                // ScrollView horizontal para os livros
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(spacing: 16) {
                        ForEach(books, id: \.title) { book in
                            BookCardView(book: book)
                                .frame(width: 200) // Define a largura dos cards
                                .padding(.horizontal, 10)
                        }
                    }
                    .padding(.horizontal)
                }
        
                Spacer()
                
                BookListView()
                    .padding(.horizontal, 12)
                
                LatestBooksView()
                    .padding(.horizontal, 20)
                
            }
        }
    }
}

#Preview {
    MainView()
}

