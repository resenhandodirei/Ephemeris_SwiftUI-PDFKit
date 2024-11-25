//
//  ForumView.swift
//  Ephemeris
//
//  Created by Larissa Martins Correa on 25/11/24.
//

import SwiftUI

struct ForumView: View {
    @State private var posts: [Post] = [
        Post(author: "Larissa Martins", content: "Alguém mais achou o final de '1984' impactante?", likes: 12, comments: [
            Comment(author: "João Silva", content: "Sim! Foi uma reviravolta emocionante."),
            Comment(author: "Ana Costa", content: "Achei triste, mas realista.")
        ]),
        Post(author: "Pedro Santos", content: "Recomendo muito 'Duna' para quem gosta de ficção científica.", likes: 8, comments: [])
    ]
    @State private var newPostContent: String = ""

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(posts) { post in
                        VStack(alignment: .leading, spacing: 10) {
                            HStack {
                                Text(post.author)
                                    .font(.headline)
                                    .foregroundColor(.blue)
                                Spacer()
                                Text("\(post.likes) ❤️")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            
                            Text(post.content)
                                .font(.body)
                            
                            if !post.comments.isEmpty {
                                Divider()
                                VStack(alignment: .leading, spacing: 5) {
                                    Text("Comentários:")
                                        .font(.subheadline)
                                        .fontWeight(.bold)
                                    ForEach(post.comments) { comment in
                                        HStack {
                                            Text("\(comment.author):")
                                                .font(.subheadline)
                                                .fontWeight(.bold)
                                            Text(comment.content)
                                                .font(.subheadline)
                                        }
                                    }
                                }
                            }
                        }
                        .padding(.vertical, 5)
                    }
                }
                .listStyle(InsetGroupedListStyle())
                
                Divider()
                
                HStack {
                    TextField("Escreva um novo post...", text: $newPostContent)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                    
                    Button(action: {
                        addNewPost()
                    }) {
                        Text("Postar")
                            .padding(.horizontal)
                            .padding(.vertical, 8)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    .disabled(newPostContent.isEmpty)
                }
                .padding()
            }
            .navigationTitle("Fórum de Discussões")
        }
    }
    
    // Função para adicionar um novo post
    private func addNewPost() {
        let newPost = Post(author: "Você", content: newPostContent, likes: 0, comments: [])
        posts.insert(newPost, at: 0)
        newPostContent = ""
    }
}

struct Post: Identifiable {
    let id = UUID()
    let author: String
    let content: String
    var likes: Int
    var comments: [Comment]
}

struct Comment: Identifiable {
    let id = UUID()
    let author: String
    let content: String
}

struct ForumView_Previews: PreviewProvider {
    static var previews: some View {
        ForumView()
    }
}

