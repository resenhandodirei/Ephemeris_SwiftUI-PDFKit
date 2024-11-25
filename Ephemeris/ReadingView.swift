//
//  ReadingView.swift
//  Ephemeris
//
//  Created by Larissa Martins Correa on 25/11/24.
//

import SwiftUI
import PDFKit

struct ReadingView: View {
    @State private var isNightMode: Bool = false
    @State private var fontSize: CGFloat = 16
    @State private var lineSpacing: CGFloat = 5
    @State private var currentPage: Int = 1
    @State private var totalPages: Int = 100 // Número total de páginas (mock)

    var body: some View {
        VStack {
            // Barra de Ajustes
            HStack {
                // Modo Noturno
                Button(action: {
                    isNightMode.toggle()
                }) {
                    Image(systemName: isNightMode ? "sun.max.fill" : "moon.fill")
                        .foregroundColor(isNightMode ? .yellow : .darkBlue)
                        .padding()
                }

                Spacer()

                // Ajuste de Fonte
                Stepper("Tamanho da Fonte", value: $fontSize, in: 12...24)
                    .padding(.horizontal)
            }
            .padding()
            .background(isNightMode ? Color.black : Color.gray.opacity(0.1))

            // Conteúdo do Livro
            ScrollView {
                Text(sampleBookContent)
                    .font(.system(size: fontSize))
                    .foregroundColor(isNightMode ? .white : .black)
                    .lineSpacing(lineSpacing)
                    .padding()
                    .background(isNightMode ? Color.black : Color("bege")) // Usando a cor bege dos assets
                    .cornerRadius(10)
                    .shadow(radius: 5)
            }
            .padding()
            .background(isNightMode ? Color.black : Color("bege")) // Usando a cor bege dos assets

            // Navegação de Páginas
            HStack {
                Button(action: goToPreviousPage) {
                    Image(systemName: "chevron.left")
                        .padding()
                        .background(isNightMode ? Color.nude : Color.gray.opacity(0.2))
                        .clipShape(Circle())
                }
                .disabled(currentPage == 1)

                Spacer()

                Text("Página \(currentPage) de \(totalPages)")
                    .font(.footnote)
                    .foregroundColor(isNightMode ? .white : .black)

                Spacer()

                Button(action: goToNextPage) {
                    Image(systemName: "chevron.right")
                        .padding()
                        .background(isNightMode ? Color.nude : Color.gray.opacity(0.2))
                        .clipShape(Circle())
                }
                .disabled(currentPage == totalPages)
            }
            .padding()
            .background(isNightMode ? Color.black : Color.gray.opacity(0.1))
        }
        .edgesIgnoringSafeArea(.bottom)
        .background(isNightMode ? Color.black : Color("bege").opacity(0.7)) // Usando a cor bege dos assets
        .navigationTitle("Leitura")
        .navigationBarTitleDisplayMode(.inline)
    }

    // Funções de Navegação
    private func goToPreviousPage() {
        if currentPage > 1 {
            currentPage -= 1
        }
    }

    private func goToNextPage() {
        if currentPage < totalPages {
            currentPage += 1
        }
    }
}

// Conteúdo Mockado
let sampleBookContent = """
Capítulo 1: Introdução ao Mundo Swift

Swift é uma linguagem de programação poderosa e intuitiva, desenvolvida pela Apple para criar aplicativos para iOS, macOS, watchOS e tvOS.

Ela foi projetada para ser amigável aos desenvolvedores, promovendo produtividade e segurança ao mesmo tempo.

Capítulo 2: Entendendo SwiftUI

O SwiftUI é uma framework declarativa para construir interfaces de usuário em todos os dispositivos Apple. Ele torna o desenvolvimento mais rápido e menos propenso a erros.

...

(Fim do Livro)
"""

// Preview
struct ReadingView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ReadingView()
        }
    }
}
