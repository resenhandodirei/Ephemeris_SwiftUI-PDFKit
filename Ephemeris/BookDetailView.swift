//
//  BookDetailView.swift
//  Ephemeris
//
//  Created by Larissa Martins Correa on 25/11/24.
//

import SwiftUI

struct BookDetailView: View {
    let bookk: Bookk
    @State private var readingProgress: Double = 0.5 // Progresso inicial (mock)

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Capa do Livro
                Image(bookk.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 250)
                    .cornerRadius(12)
                    .shadow(radius: 8)

                // Informações do Livro
                VStack(alignment: .leading, spacing: 10) {
                    Text(bookk.title)
                        .font(.title)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.leading)

                    Text("Por \(bookk.author)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)

                    Text("\(bookk.pageCount) páginas")
                        .font(.footnote)
                        .foregroundColor(.secondary)

                    Text("Sinopse")
                        .font(.headline)

                    Text(bookk.synopsis)
                        .font(.body)
                        .foregroundColor(.primary)
                        .multilineTextAlignment(.leading)
                }
                .padding(.horizontal)

                // Progresso de Leitura
                VStack(alignment: .leading, spacing: 10) {
                    Text("Progresso de Leitura")
                        .font(.headline)

                    ProgressView(value: readingProgress)
                        .progressViewStyle(LinearProgressViewStyle(tint: Color("darkBlue"))) // Certifique-se de que a cor "darkBlue" está definida também
                        .padding(.vertical, 5)

                    Text("Você leu \(Int(readingProgress * 100))% deste livro.")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding(.horizontal)

                // Botão de Ação
                Button(action: startOrContinueReading) {
                    Text(readingProgress == 1.0 ? "Revisar Leitura" : "Continuar Leitura")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color("darkBlue")) // Certifique-se de que a cor "darkBlue" está definida
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                }
                .background(Color("bege")) // Usando a cor "bege" definida no Assets.xcassets
                .ignoresSafeArea()
                .padding(.horizontal)
            }
            .padding(.vertical)
        }
        .navigationTitle("Detalhes do Livro")
        .navigationBarTitleDisplayMode(.inline)
    }

    // Ação do botão
    private func startOrContinueReading() {
        print("Leitura iniciada/continuada para o livro: \(bookk.title)")
        // Aqui você pode adicionar lógica para navegar para a tela de leitura ou atualizar progresso
    }
}

// Dados Mockados
struct Bookk {
    let title: String
    let author: String
    let pageCount: Int
    let synopsis: String
    let imageName: String
}

extension Bookk {
    static let sampleBookk = Bookk(
        title: "1984",
        author: "George Orwell",
        pageCount: 328,
        synopsis: """
        Um romance distópico que explora os perigos do totalitarismo, vigilância massiva e censura. \
        Acompanhamos Winston Smith em sua luta contra o regime opressor do Grande Irmão.
        """,
        imageName: "book_placeholder"
    )
}

// Preview
struct BookDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            BookDetailView(bookk: Bookk.sampleBookk) // Usando o sampleBookk
        }
    }
}
