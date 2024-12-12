//
//  BookCardView.swift
//  Ephemeris
//
//  Created by Larissa Martins Correa on 11/12/24.
//
import SwiftUI

struct BookCardView: View {
    let book: BookCardModel // Renomeando para BookCardModel

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            // Capa do Livro
            Image(book.imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 180, height: 100)
                .cornerRadius(12)
                .shadow(radius: 5)

            // Informações do Livro
            VStack(alignment: .leading, spacing: 5) {
                Text(book.title)
                    .font(.headline)
                    .foregroundColor(.primary)
                    .lineLimit(2)

                Text("Por \(book.author)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                Text("\(book.pageCount) páginas")
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }
            .padding(.horizontal, 5)

            // Progresso de Leitura
            VStack(alignment: .leading, spacing: 5) {
                ProgressView(value: book.readingProgress)
                    .progressViewStyle(LinearProgressViewStyle(tint: Color("darkBlue")))

                Text("\(Int(book.readingProgress * 100))% lido")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .padding(.horizontal, 5)
        }
        .padding()
        .background(Color("bege"))
        .cornerRadius(12)
        .shadow(radius: 5)
    }
}

// Dados Mockados
struct BookCardModel {
    let title: String
    let author: String
    let pageCount: Int
    let synopsis: String
    let imageName: String
    let readingProgress: Double
}

extension BookCardModel {
    static let sampleBook = BookCardModel(
        title: "1984",
        author: "George Orwell",
        pageCount: 328,
        synopsis: """
        Um romance distópico que explora os perigos do totalitarismo, vigilância massiva e censura. \
        Acompanhamos Winston Smith em sua luta contra o regime opressor do Grande Irmão.
        """,
        imageName: "book_placeholder",
        readingProgress: 0.5
    )
}

// Preview
struct BookCardView_Previews: PreviewProvider {
    static var previews: some View {
        BookCardView(book: BookCardModel.sampleBook)
            .frame(width: 200, height: 300)
    }
}
