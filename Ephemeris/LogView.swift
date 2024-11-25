//
//  LogView.swift
//  Ephemeris
//
//  Created by Larissa Martins Correa on 25/11/24.
//

import SwiftUI

struct LogView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var showPassword = false
    @State private var errorMessage = ""
    @State private var isLoading = false

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // Título
                Spacer()
                Text("Bem-vindo ao Ephemeris")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color.nude)

                Spacer()

                // Campos de entrada
                VStack(spacing: 15) {
                    // Campo de email
                    TextField("Email", text: $email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(8)

                    // Campo de senha
                    HStack {
                        if showPassword {
                            TextField("Senha", text: $password)
                        } else {
                            SecureField("Senha", text: $password)
                        }
                        Button(action: { showPassword.toggle() }) {
                            Image(systemName: showPassword ? "eye.slash" : "eye")
                                .foregroundColor(.gray)
                        }
                    }
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(8)
                }

                // Mensagem de erro
                if !errorMessage.isEmpty {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .font(.caption)
                        .padding(.top, 5)
                }

                // Botão de Login
                Button(action: loginAction) {
                    if isLoading {
                        ProgressView()
                            .padding()
                    } else {
                        Text("Entrar")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color("darkBlue").opacity(3.0))
                            .foregroundColor(.nude)
                            .cornerRadius(8)
                    }
                }
                .disabled(isLoading || email.isEmpty || password.isEmpty)

                // Botões de autenticação social
                VStack(spacing: 15) {
                    Button(action: loginWithGoogle) {
                        HStack {
                            Image(systemName: "globe")
                                .foregroundColor(.blue)
                            Text("Entrar com Google")
                                .fontWeight(.semibold)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(8)
                    }

                    Button(action: loginWithApple) {
                        HStack {
                            Image(systemName: "applelogo")
                                .foregroundColor(.black)
                            Text("Entrar com Apple")
                                .fontWeight(.semibold)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(8)
                    }
                    
                    
                    Button(action: loginWithApple) {
                            Text("Criar Conta")
                                .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(8)
                    }
                    
                    Button("Esqueci minha senha") {
                        // Adicionar ação de recuperação
                    }.font(.footnote)
                        .foregroundColor(.gray)
                        .padding(.horizontal)
                    
                    
                }
Spacer()
            
            }
            .padding()
            .background(Color("darkBlue").opacity(0.9)) // Alterando o fundo para darkBlue
            .ignoresSafeArea() // Ignora a área segura para cobrir toda a tela
        }
    }

    // Funções de autenticação
    private func loginAction() {
        isLoading = true
        // Simulação de autenticação
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            isLoading = false
            if email == "teste@exemplo.com" && password == "123456" {
                print("Login bem-sucedido!")
            } else {
                errorMessage = "Credenciais inválidas. Tente novamente."
            }
        }
    }

    private func loginWithGoogle() {
        print("Autenticação com Google.")
    }

    private func loginWithApple() {
        print("Autenticação com Apple.")
    }
}

struct RegistrationView: View {
    var body: some View {
        Text("Tela de Registro")
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LogView()
    }
}


#Preview {
    LogView()
}
