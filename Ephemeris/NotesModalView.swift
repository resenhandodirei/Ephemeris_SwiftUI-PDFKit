//
//  NotesModalView.swift
//  Ephemeris
//
//  Created by Larissa Martins Correa on 25/11/24.
//

import SwiftUI

struct NotesModalView: View {
    @Binding var isPresented: Bool // Para controlar a exibição do modal
    @State private var noteText: String = ""
    let selectedText: String // Trecho do livro ao qual a nota será vinculada
    let onSave: (String) -> Void // Closure para salvar a nota

    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("Trecho Selecionado")
                    .font(.headline)
                    .padding(.bottom, 2)

                Text("\"\(selectedText)\"")
                    .font(.body)
                    .foregroundColor(.gray)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)
                    .padding(.bottom)

                Text("Adicione sua nota:")
                    .font(.headline)
                    .padding(.bottom, 2)

                TextEditor(text: $noteText)
                    .frame(height: 150)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)
                    .padding(.bottom)

                Spacer()
            }
            .padding()
            .navigationTitle("Adicionar Nota")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancelar") {
                        isPresented = false
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Salvar") {
                        onSave(noteText)
                        isPresented = false
                    }
                    .disabled(noteText.isEmpty)
                }
            }
        }
    }
}

struct ReadingViewWithNotes: View {
    @State private var isNotesModalPresented: Bool = false
    @State private var selectedText: String = ""
    @State private var notes: [String: String] = [:] // Dicionário de trecho -> nota
    @State private var currentChapter: String = sampleBookContentImproved

    var body: some View {
        VStack {
            // Área de leitura com trecho selecionável
            ScrollView {
                Text(currentChapter)
                    .onTapGesture {
                        // Simulando um trecho selecionado
                        selectedText = "Capítulo 1: Introdução ao Mundo Swift"
                        isNotesModalPresented = true
                    }
                    .padding()
            }

            // Botões para navegação ou finalizar a leitura
            HStack {
                Button(action: {
                    // Lógica para avançar para o próximo capítulo
                    currentChapter = "Capítulo 2: Fundamentos do Swift"
                    selectedText = "Capítulo 2: Fundamentos do Swift"
                }) {
                    Text("Avançar Capítulo")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.darkBlue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }

                Button(action: {
                    // Lógica para finalizar a leitura
                    currentChapter = "Leitura finalizada! Você terminou o livro."
                    selectedText = "Fim da leitura"
                }) {
                    Text("Finalizar Leitura")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.nude)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .padding()

            // Listagem de Notas
            List {
                ForEach(notes.keys.sorted(), id: \.self) { key in
                    VStack(alignment: .leading) {
                        Text("Trecho: \"\(key)\"")
                            .font(.headline)

                        Text("Nota: \(notes[key] ?? "")")
                            .font(.body)
                            .foregroundColor(.gray)
                    }
                    .padding(.vertical)
                }
            }
            .listStyle(InsetGroupedListStyle())
        }
        .sheet(isPresented: $isNotesModalPresented) {
            NotesModalView(isPresented: $isNotesModalPresented, selectedText: selectedText) { note in
                notes[selectedText] = note
            }
        }
        .navigationTitle("Leitura com Notas")
        .navigationBarTitleDisplayMode(.inline)

        .navigationBarItems(trailing: Button(action: {
            // Ação do botão extra (mock)
            print("Botão extra clicado!")
        }) {
            Image(systemName: "bookmark.fill")
                .font(.title3)
                .foregroundColor(.nude)
        })
    }
}

let sampleBookContentImproved = """
Capítulo 1: Introdução ao Mundo Swift

Swift é uma linguagem de programação poderosa e intuitiva, desenvolvida pela Apple para criar aplicativos para iOS, macOS, watchOS e tvOS.

Ela foi projetada para ser amigável aos desenvolvedores, promovendo produtividade e segurança ao mesmo tempo.

...

(Fim do Livro)
"""

struct NotesModalView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ReadingViewWithNotes()
        }
    }
}

