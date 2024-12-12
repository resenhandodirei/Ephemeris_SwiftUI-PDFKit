//
//  HighlightModalView.swift
//  Ephemeris
//
//  Created by Larissa Martins Correa on 25/11/24.
//

import SwiftUI

struct HighlightModalView: View {
    @Binding var isPresented: Bool // Controle do modal
    let selectedText: String // Trecho selecionado
    @State private var selectedColor: Color = .yellow // Cor padrão
    @State private var selectedStyle: HighlightStyle = .highlight // Estilo padrão
    let onSave: (Highlight) -> Void // Closure para salvar a marcação

    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                Text("Trecho Selecionado")
                    .font(.headline)

                Text("\"\(selectedText)\"")
                    .font(.body)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)

                Text("Escolha uma cor:")
                    .font(.headline)

                HStack {
                    ForEach(HighlightColor.allCases, id: \.self) { color in
                        Circle()
                            .fill(color.colorValue)
                            .frame(width: 40, height: 40)
                            .overlay(
                                Circle()
                                    .stroke(selectedColor == color.colorValue ? Color.darkBlue : Color.clear, lineWidth: 3)
                            )
                            .onTapGesture {
                                selectedColor = color.colorValue
                            }
                    }
                }

                Text("Escolha um estilo:")
                    .font(.headline)

                Picker("Estilo", selection: $selectedStyle) {
                    ForEach(HighlightStyle.allCases, id: \.self) { style in
                        Text(style.rawValue.capitalized)
                            .tag(style)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())

                Spacer()
            }
            .padding()
            .navigationTitle("Marcar Texto")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancelar") {
                        isPresented = false
                    }.foregroundColor(.darkBlue)
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Salvar") {
                        let highlight = Highlight(text: selectedText, color: selectedColor, style: selectedStyle)
                        onSave(highlight)
                        isPresented = false
                    }.foregroundColor(.darkBlue)
                }
            }
        }
    }
}

struct ReadingViewWithHighlight: View {
    @State private var isHighlightModalPresented: Bool = false
    @State private var selectedText: String = ""
    @State private var highlights: [Highlight] = []

    var body: some View {
        VStack {
            ScrollView {
                Text(sampleBookContent)
                    .onTapGesture {
                        selectedText = "Capítulo 1: Introdução ao Mundo Swift" // Trecho fixo de exemplo
                        isHighlightModalPresented = true
                    }
                    .padding()

                ForEach(highlights, id: \.id) { highlight in
                    VStack(alignment: .leading) {
                        Text("\"\(highlight.text)\"")
                            .foregroundColor(highlight.color)
                            .underline(highlight.style == .underline)
                            .strikethrough(highlight.style == .strikethrough)
                            .padding()
                    }
                }
            }
        }
        .sheet(isPresented: $isHighlightModalPresented) {
            HighlightModalView(isPresented: $isHighlightModalPresented, selectedText: selectedText) { highlight in
                highlights.append(highlight)
            }
        }
        .navigationTitle("Leitura com Marcação")
    }
}

// Modelos e Helpers

struct Highlight: Identifiable {
    let id = UUID()
    let text: String
    let color: Color
    let style: HighlightStyle
}

enum HighlightStyle: String, CaseIterable {
    case highlight = "highlight"
    case underline = "underline"
    case strikethrough = "strikethrough"
}

enum HighlightColor: CaseIterable {
    case yellow, pink, green, blue

    var colorValue: Color {
        switch self {
        case .yellow: return .yellow
        case .pink: return .pink
        case .green: return .green
        case .blue: return .blue
        }
    }
}

// Conteúdo Mockado
let sampleBoookContent = """
Capítulo 1: Introdução ao Mundo Swift

Swift é uma linguagem de programação poderosa e intuitiva, desenvolvida pela Apple para criar aplicativos para iOS, macOS, watchOS e tvOS.

Ela foi projetada para ser amigável aos desenvolvedores, promovendo produtividade e segurança ao mesmo tempo.

...

"""

struct HighlightModalView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ReadingViewWithHighlight()
        }
    }
}
