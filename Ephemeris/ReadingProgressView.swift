//
//  ReadingProgressView.swift
//  Ephemeris
//
//  Created by Larissa Martins Correa on 25/11/24.
//
import SwiftUI
import Charts

struct ReadingProgressView: View {
    // Mock de dados
    let readingData = [
        ReadingProgress(day: "Seg", pages: 10),
        ReadingProgress(day: "Ter", pages: 15),
        ReadingProgress(day: "Qua", pages: 5),
        ReadingProgress(day: "Qui", pages: 20),
        ReadingProgress(day: "Sex", pages: 25),
        ReadingProgress(day: "Sáb", pages: 30),
        ReadingProgress(day: "Dom", pages: 10)
    ]

    let totalPages: Int = 500 // Total de páginas no livro
    @State private var pagesRead: Int = 100 // Páginas lidas até agora

    var body: some View {
        VStack(spacing: 24) {
            Text("Progresso de Leitura")
                .font(.title)
                .bold()

            // Gráfico Circular
            VStack {
                Text("Progresso Atual")
                    .font(.headline)

                ProgressView(value: Double(pagesRead), total: Double(totalPages))
                    .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                    .frame(width: 150, height: 150)

                Text("\(pagesRead) de \(totalPages) páginas lidas")
                    .font(.subheadline)
            }

            Divider()

            // Gráfico de Barras
            VStack(alignment: .leading) {
                Text("Páginas Lidas por Dia")
                    .font(.headline)

                Chart {
                    ForEach(readingData) { data in
                        BarMark(
                            x: .value("Dia", data.day),
                            y: .value("Páginas", data.pages)
                        )
                        .foregroundStyle(Color.blue.gradient)
                    }
                }
                .frame(height: 200)
            }

            Divider()

            // Estatísticas
            VStack(alignment: .leading, spacing: 8) {
                Text("Estatísticas")
                    .font(.headline)

                HStack {
                    VStack(alignment: .leading) {
                        Text("Páginas Lidas:")
                        Text("\(pagesRead)")
                            .bold()
                    }
                    Spacer()
                    VStack(alignment: .leading) {
                        Text("Total de Tempo:")
                        Text("\(calculateTotalTime(pagesRead: pagesRead)) horas")
                            .bold()
                    }
                }

                HStack {
                    VStack(alignment: .leading) {
                        Text("Progresso:")
                        Text("\(Int(Double(pagesRead) / Double(totalPages) * 100))%")
                            .bold()
                    }
                    Spacer()
                    VStack(alignment: .leading) {
                        Text("Meta Diária:")
                        Text("\(calculateDailyGoal(pagesRead: pagesRead, days: 7)) páginas/dia")
                            .bold()
                    }
                }
            }
            .padding(.horizontal)

            Spacer()
        }
        .padding()
//        .navigationTitle("Progresso de Leitura")
    }

    // Função para calcular o total de tempo baseado nas páginas lidas
    private func calculateTotalTime(pagesRead: Int) -> Int {
        let averageTimePerPage = 2 // 2 minutos por página
        return (pagesRead * averageTimePerPage) / 60 // Tempo em horas
    }

    // Função para calcular a meta diária
    private func calculateDailyGoal(pagesRead: Int, days: Int) -> Int {
        let remainingPages = totalPages - pagesRead
        return max(remainingPages / days, 0)
    }
}

// Modelo de dados para o gráfico
struct ReadingProgress: Identifiable {
    let id = UUID()
    let day: String
    let pages: Int
}

struct ReadingProgressView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ReadingProgressView()
        }
    }
}
