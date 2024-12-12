//
//  ReadingStatisticsView.swift
//  Ephemeris
//
//  Created by Larissa Martins Correa on 25/11/24.
//

import SwiftUI
import Charts

struct ReadingStatisticsView: View {
    @State private var readingData: [ReadingStat] = [
        ReadingStat(date: "Semana 1", pages: 50),
        ReadingStat(date: "Semana 2", pages: 120),
        ReadingStat(date: "Semana 3", pages: 90),
        ReadingStat(date: "Semana 4", pages: 150)
    ]
    
    @State private var monthlyStats: [MonthlyStat] = [
        MonthlyStat(month: "Janeiro", books: 2),
        MonthlyStat(month: "Fevereiro", books: 3),
        MonthlyStat(month: "Março", books: 1),
        MonthlyStat(month: "Abril", books: 4)
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Relatórios de Leitura")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.horizontal)
                    
                    // Gráfico semanal
                    VStack(alignment: .leading) {
                        Text("Progresso Semanal")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .padding(.horizontal)
                        
                        Chart {
                            ForEach(readingData) { stat in
                                BarMark(
                                    x: .value("Semana", stat.date),
                                    y: .value("Páginas Lidas", stat.pages)
                                )
                                .foregroundStyle(Color.darkBlue.gradient)
                            }
                        }
                        .frame(height: 200)
                        .padding(.horizontal)
                    }
                    
                    // Gráfico mensal
                    VStack(alignment: .leading) {
                        Text("Livros Lidos Mensalmente")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .padding(.horizontal)
                        
                        Chart {
                            ForEach(monthlyStats) { stat in
                                LineMark(
                                    x: .value("Mês", stat.month),
                                    y: .value("Livros", stat.books)
                                )
                                .symbol(.circle)
                                .foregroundStyle(Color.brown.gradient)
                            }
                        }
                        .frame(height: 200)
                        .padding(.horizontal)
                    }
                    
                    Spacer()
                }
                .navigationTitle("Estatísticas")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}

struct ReadingStat: Identifiable {
    let id = UUID()
    let date: String
    let pages: Int
}

struct MonthlyStat: Identifiable {
    let id = UUID()
    let month: String
    let books: Int
}

struct ReadingStatisticsView_Previews: PreviewProvider {
    static var previews: some View {
        ReadingStatisticsView()
    }
}
