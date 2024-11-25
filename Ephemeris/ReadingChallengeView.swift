//
//  ReadingChallengeView.swift
//  Ephemeris
//
//  Created by Larissa Martins Correa on 25/11/24.
//
import SwiftUI

struct ReadingChallengeView: View {
    @State private var challenges: [Challenge] = [
        Challenge(title: "Ler 5 Livros", progress: 3, goal: 5, reward: "Medalha de Bronze"),
        Challenge(title: "Ler 100 Páginas em 7 Dias", progress: 100, goal: 100, reward: "Medalha de Prata"),
        Challenge(title: "Ler 30 Minutos por Dia", progress: 15, goal: 30, reward: "Medalha de Ouro")
    ]
    
    @State private var showReward: Bool = false
    @State private var unlockedReward: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(challenges.indices, id: \.self) { index in
                        ChallengeCardView(challenge: $challenges[index]) {
                            unlockReward(for: challenges[index])
                        }
                    }
                }
                .listStyle(InsetGroupedListStyle())
            }
            .navigationTitle("Desafios de Leitura")
            .overlay(
                // Usando um Group para condicionalmente mostrar a view
                Group {
                    if showReward {
                        RewardView(reward: unlockedReward, showReward: $showReward)
                    }
                }
            )
        }
    }
    
    private func unlockReward(for challenge: Challenge) {
        if challenge.progress >= challenge.goal {
            unlockedReward = challenge.reward
            showReward = true
        }
    }
}

struct ChallengeCardView: View {
    @Binding var challenge: Challenge
    var onUnlock: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(challenge.title)
                .font(.headline)
            
            ProgressView(value: Double(challenge.progress), total: Double(challenge.goal))
                .accentColor(challenge.progress >= challenge.goal ? .green : .blue)
            
            HStack {
                Text("\(challenge.progress)/\(challenge.goal) concluídos")
                    .font(.subheadline)
                Spacer()
                Button(action: {
                    if challenge.progress >= challenge.goal {
                        onUnlock()
                    }
                }) {
                    Text(challenge.progress >= challenge.goal ? "Desbloquear" : "Progresso")
                        .padding(8)
                        .background(challenge.progress >= challenge.goal ? Color.green : Color.gray.opacity(0.3))
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .disabled(challenge.progress < challenge.goal)
            }
        }
        .padding()
        .background(Color(UIColor.secondarySystemBackground))
        .cornerRadius(10)
        .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
}

struct RewardView: View {
    let reward: String
    @Binding var showReward: Bool
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Recompensa Desbloqueada!")
                .font(.title)
                .fontWeight(.bold)
            
            Text(reward)
                .font(.headline)
                .padding()
                .background(Color.yellow)
                .cornerRadius(10)
                .shadow(radius: 10)
            
            Button(action: {
                showReward = false
            }) {
                Text("Fechar")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 20)
        .frame(maxWidth: 300)
        .frame(height: 300)
        .overlay(
            Color.black.opacity(0.5)
                .ignoresSafeArea()
        )
    }
}

struct Challenge: Identifiable {
    let id = UUID()
    var title: String
    var progress: Int
    var goal: Int
    var reward: String
}

struct ReadingChallengeView_Previews: PreviewProvider {
    static var previews: some View {
        ReadingChallengeView()
    }
}
