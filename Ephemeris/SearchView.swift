//
//  SearchView.swift
//  Ephemeris
//
//  Created by Larissa Martins Correa on 25/11/24.
//

import SwiftUI

struct SearchView: View {
    @State private var searchQuery = ""
    @State private var books: [SearchBook] = SearchBook.sampleBooks() // Dados mockados
    @State private var filteredBooks: [SearchBook] = []

    var body: some View {
        NavigationView {
            VStack {
                // Barra de Pesquisa
                SearchBarView(searchQuery: $searchQuery)
                    .padding(.horizontal)

                // Sugestões de Livros
                if searchQuery.isEmpty {
                    Text("Digite algo para buscar livros...")
                        .foregroundColor(.gray)
                        .padding()
                } else if filteredBooks.isEmpty {
                    Text("Nenhum livro encontrado.")
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    List(filteredBooks) { book in
                        HStack {
                            Image(book.imageName)
                                .resizable()
                                .frame(width: 50, height: 75)
                                .cornerRadius(4)

                            VStack(alignment: .leading) {
                                Text(book.title)
                                    .font(.headline)
                                Text(book.author)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            Spacer()
                        }
                    }
                }
            }
            .navigationBarTitle("Pesquisar", displayMode: .inline)
            .onAppear {
                filteredBooks = books
            }
            .onChange(of: searchQuery) { _ in
                filterBooks()
            }
        }
    }

    // Filtrar livros de acordo com o texto de busca
    private func filterBooks() {
        if searchQuery.isEmpty {
            filteredBooks = books
        } else {
            filteredBooks = books.filter { book in
                book.title.lowercased().contains(searchQuery.lowercased()) ||
                book.author.lowercased().contains(searchQuery.lowercased())
            }
        }
    }
}

struct SearchBarView: View {
    @Binding var searchQuery: String

    var body: some View {
        HStack {
            TextField("Buscar livros...", text: $searchQuery)
                .padding(10)
                .background(Color(.secondarySystemBackground))
                .cornerRadius(8)
                .overlay(
                    HStack {
                        Spacer()
                        if !searchQuery.isEmpty {
                            Button(action: { searchQuery = "" }) {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 8)
                            }
                        }
                    }
                )
        }
    }
}

// Dados mockados
struct SearchBook: Identifiable { // Renomeando para SearchBook
    let id = UUID()
    let title: String
    let author: String
    let imageName: String
}

extension SearchBook {
    static func sampleBooks() -> [SearchBook] {
        return [
            SearchBook(title: "1984", author: "George Orwell", imageName: "book_placeholder"),
            SearchBook(title: "O Pequeno Príncipe", author: "Antoine de Saint-Exupéry", imageName: "book_placeholder"),
            SearchBook(title: "Sapiens", author: "Yuval Noah Harari", imageName: "book_placeholder"),
            SearchBook(title: "A Revolução dos Bichos", author: "George Orwell", imageName: "book_placeholder")
        ]
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
