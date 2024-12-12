//
//  ReadingChallengeView.swift
//  Ephemeris
//
//  Created by Larissa Martins Correa on 25/11/24.
//

import SwiftUI

struct ReadingChallengeView: View {
    @State private var targetBooks: Int = 12 // Meta de livros
    @State private var booksRead: Int = 5 // Livros já lidos
    @State private var currentBook: String = "O Alquimista" // Livro atual
    @State private var showMarkAsReadAlert = false

    var body: some View {
        VStack(spacing: 20) {

            ProgressView(value: Double(booksRead), total: Double(targetBooks))
                .progressViewStyle(LinearProgressViewStyle(tint: .brown))
                .padding()
                .frame(height: 20)

            Text("\(booksRead) de \(targetBooks) livros lidos")
                .font(.headline)

            VStack(alignment: .leading, spacing: 10) {
                Text("Livro Atual:")
                    .font(.headline)
                
                Text(currentBook)
                    .font(.title3)
                    .italic()
                    .foregroundColor(.brown)

                Button(action: {
                    showMarkAsReadAlert = true
                }) {
                    Text("Marcar como Lido")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.darkBlue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .alert(isPresented: $showMarkAsReadAlert) {
                    Alert(
                        title: Text("Confirmar"),
                        message: Text("Deseja marcar \(currentBook) como lido?"),
                        primaryButton: .default(Text("Sim")) {
                            booksRead += 1
                            currentBook = "Próximo Livro..." // Alterar para um próximo livro real
                        },
                        secondaryButton: .cancel()
                    )
                }
            }
            .padding()
            .background(Color.nude.opacity(0.5))
            .cornerRadius(10)

            Spacer()

            // Botão para ajustar a meta
            HStack {
                Button(action: {
                    if targetBooks > 1 {
                        targetBooks -= 1
                    }
                }) {
                    Image(systemName: "minus.circle")
                        .font(.title)
                        .foregroundColor(.bege)
                }

                Text("Meta: \(targetBooks) livros")
                    .font(.headline)

                Button(action: {
                    targetBooks += 1
                }) {
                    Image(systemName: "plus.circle")
                        .font(.title)
                        .foregroundColor(.darkBlue)
                }
            }

            Spacer()
        }
        .padding()
        .navigationTitle("Desafio de Leitura")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ReadingChallengeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ReadingChallengeView()
        }
    }
}

