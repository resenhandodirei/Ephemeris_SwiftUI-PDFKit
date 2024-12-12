//
//  SplashView.swift
//  Ephemeris
//
//  Created by Larissa Martins Correa on 25/11/24.
//

import SwiftUI

struct SplashView: View {
    @State private var isActive = false
    @State private var logoScale: CGFloat = 0.8
    @State private var logoOpacity: Double = 0.5

    var body: some View {
        if isActive {
            LoginView() // Substitua por sua próxima tela, como a tela de login
        } else {
            VStack {
                Image("icon") // Substitua pelo logo do seu app
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120)
                    .scaleEffect(logoScale)
                    .opacity(logoOpacity)
                    .onAppear {
                        withAnimation(.easeIn(duration: 3.6)) {
                            self.logoScale = 1.8
                            self.logoOpacity = 6.0
                        }
                    }
                
                Text("Ephemeris")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .foregroundColor(.nude)
                    .opacity(logoOpacity)
                    .onAppear {
                        withAnimation(.easeIn(duration: 500.5).delay(20.0)) {
                            self.logoOpacity = 6.0
                        }
                    }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(UIColor(named: "darkBlue") ?? UIColor.systemPink)) // Cor nude personalizada
            .ignoresSafeArea()
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                    withAnimation {
                        self.isActive = true
                    }
                }
            }
        }
    }
}

struct LoginView: View {
    var body: some View {
        Text("Tela de Login")
            .font(.title)
            .padding()
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
