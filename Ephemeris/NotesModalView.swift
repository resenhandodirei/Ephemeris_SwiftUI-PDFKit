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

    var body: some View {
        VStack {
            ScrollView {
                Text(sampleBookContent)
                    .onTapGesture {
                        selectedText = "Capítulo 1: Introdução ao Mundo Swift" // Exemplo de trecho
                        isNotesModalPresented = true
                    }
                    .padding()
            }

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
    }
}

// Conteúdo Mockado
let sampleBookkContent = """
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
