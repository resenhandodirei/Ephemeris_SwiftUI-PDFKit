//
//  BookReviewView.swift
//  Ephemeris
//
//  Created by Larissa Martins Correa on 25/11/24.
//
import SwiftUI

struct BookReviewView: View {
    @State private var reviews: [Review] = [
        Review(user: "João Silva", rating: 4, comment: "Um livro excelente! Recomendo."),
        Review(user: "Ana Costa", rating: 5, comment: "Incrível! A história me prendeu do início ao fim.")
    ]
    @State private var newRating: Int = 0
    @State private var newComment: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                // Lista de Avaliações
                List {
                    ForEach(reviews) { review in
                        VStack(alignment: .leading, spacing: 5) {
                            HStack {
                                Text(review.user)
                                    .font(.headline)
                                Spacer()
                                HStack(spacing: 2) {
                                    ForEach(0..<5) { star in
                                        Image(systemName: star < review.rating ? "star.fill" : "star")
                                            .foregroundColor(star < review.rating ? .yellow : .gray)
                                    }
                                }
                            }
                            Text(review.comment)
                                .font(.body)
                                .foregroundColor(.secondary)
                        }
                        .padding(.vertical, 5)
                    }
                }
                .listStyle(InsetGroupedListStyle())
                
                Divider()
                
                // Formulário de Nova Avaliação
                VStack(alignment: .leading, spacing: 10) {
                    Text("Sua Avaliação")
                        .font(.headline)
                    
                    HStack {
                        ForEach(1...5, id: \.self) { star in
                            Image(systemName: star <= newRating ? "star.fill" : "star")
                                .foregroundColor(star <= newRating ? .yellow : .gray)
                                .onTapGesture {
                                    newRating = star
                                }
                        }
                    }
                    
                    TextField("Escreva um comentário...", text: $newComment)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Button(action: {
                        submitReview()
                    }) {
                        Text("Enviar Avaliação")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(newRating > 0 && !newComment.isEmpty ? Color.blue : Color.gray)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .disabled(newRating == 0 || newComment.isEmpty)
                }
                .padding()
            }
            .navigationTitle("Avaliações")
        }
    }
    
    private func submitReview() {
        let newReview = Review(user: "Você", rating: newRating, comment: newComment)
        reviews.insert(newReview, at: 0)
        newRating = 0
        newComment = ""
    }
}

struct Review: Identifiable {
    let id = UUID()
    let user: String
    let rating: Int
    let comment: String
}

struct BookReviewView_Previews: PreviewProvider {
    static var previews: some View {
        BookReviewView()
    }
}
