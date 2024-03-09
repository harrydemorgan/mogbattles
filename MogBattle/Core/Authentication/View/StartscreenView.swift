//
//  SwiftUIView.swift
//  MogBattle
//
//  Created by Harry Morgan on 25/01/2024.
//

import SwiftUI

struct StartscreenView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)
                VStack {
                    // Form Fields
                    VStack {
                        Spacer()
                        // Title
                        Text("MogBattles")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.bottom, 10)
                        
                        Spacer()
                        
                        // Log in button
                        NavButton(destination: AnyView(LoginView()),
                            condition: { true },
                            text: "Log In",
                            finalColor: .cyan,
                            finalTextColor: .black)
                        // Sign up button
                        NavButton(destination:AnyView(SignupView()),
                                  condition: { true },
                                  text: "Sign Up",
                                  finalColor: .white,
                                  finalTextColor: .black)
                    }
                    .padding(.horizontal)
                    
                }
            }
        }
    }
}

#Preview {
    StartscreenView()
}
