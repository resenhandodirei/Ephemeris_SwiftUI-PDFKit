//
//  LibraryView.swift
//  Ephemeris
//
//  Created by Larissa Martins Correa on 25/11/24.
//

import SwiftUI

struct LibraryView: View {
    @State private var searchQuery = ""
    @State private var selectedFilter: FilterOption = .all
    @State private var books: [Book] = Book.sampleBooks() // Mock de dados
    @State private var filteredBooks: [Book] = []

    var body: some View {
        NavigationView {
            VStack {
                // Barra de Pesquisa
                SearchBarView(searchQuery: $searchQuery)
                    .padding(.horizontal)

                // Filtros
                HStack {
                    Text("Filtrar por:")
                        .font(.headline)
                    Spacer()
                    Menu {
                        ForEach(FilterOption.allCases, id: \.self) { option in
                            Button(option.rawValue) {
                                selectedFilter = option
                                applyFilters()
                            }
                        }
                    } label: {
                        Label(selectedFilter.rawValue, systemImage: "line.3.horizontal.decrease.circle")
                            .foregroundColor(.primary)
                    }
                }
                .padding(.horizontal)

                // Lista de Livros
                if filteredBooks.isEmpty {
                    Text("Nenhum livro encontrado")
                        .font(.callout)
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    List(filteredBooks) { book in
                        HStack {
                            // Miniatura do Livro
                            Image(book.imageName)
                                .resizable()
                                .frame(width: 50, height: 75)
                                .cornerRadius(4)
                            // Informações do Livro
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

                // Botão de Adicionar Livro
                Button(action: {
                    print("Adicionar Novo Livro")
                }) {
                    HStack {
                        Image(systemName: "plus.circle")
                        Text("Adicionar Livro")
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color("NavyBlue"))
                    .foregroundColor(.white)
                    .cornerRadius(8)
                }
                .padding(.horizontal)
            }
            .navigationBarTitle("Biblioteca", displayMode: .inline)
            .onAppear {
                filteredBooks = books
            }
            .onChange(of: searchQuery) { _ in
                applyFilters()
            }
        }
    }

    // Aplicar Filtros
    private func applyFilters() {
        filteredBooks = books.filter { book in
            (selectedFilter == .all || book.category == selectedFilter) &&
                (searchQuery.isEmpty || book.title.lowercased().contains(searchQuery.lowercased()))
        }
    }
}

struct SearchhBarView: View {
    @Binding var searchQuery: String

    var body: some View {
        HStack {
            TextField("Pesquisar livros...", text: $searchQuery)
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

// Dados Mockados
struct Book: Identifiable {
    let id = UUID()
    let title: String
    let author: String
    let imageName: String
    let category: FilterOption
}

extension Book {
    static func sampleBooks() -> [Book] {
        return [
            Book(title: "1984", author: "George Orwell", imageName: "book_placeholder", category: .fiction),
            Book(title: "O Pequeno Príncipe", author: "Antoine de Saint-Exupéry", imageName: "book_placeholder", category: .children),
            Book(title: "Sapiens", author: "Yuval Noah Harari", imageName: "book_placeholder", category: .nonFiction)
        ]
    }
}

// Filtros
enum FilterOption: String, CaseIterable {
    case all = "Todos"
    case fiction = "Ficção"
    case nonFiction = "Não Ficção"
    case children = "Infantil"
}

struct LibraryView_Previews: PreviewProvider {
    static var previews: some View {
        LibraryView()
    }
}
