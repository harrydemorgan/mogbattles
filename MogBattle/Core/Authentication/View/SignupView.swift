//
//  LoginView.swift
//  MogBattle
//
//  Created by Harry Morgan on 21/01/2024.
//

import SwiftUI

struct SignupView: View {
    @State private var email = ""
    @FocusState private var isFocused: Bool
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)
                VStack {                    
                    // Form Fields
                    VStack {
                        Spacer()
                        // Title
                        Text("Enter your email")
                            .font(.largeTitle)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .padding(.bottom, 10)
                        
                        // Email input
                        InputView(text: $email,
                                  title: "",
                                  placeholder: "Email")
                        .focused($isFocused)
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                isFocused = true
                            }
                        }
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                        
                        // Agreement statement
                        Text("By entering your email, you're agreeing to our Terms of Service and Privacy Policy.")
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .padding()
                        
                        Spacer()
                        
                        // Next button
                        NavButton(destination: AnyView(SignupPasswordView(email: email)), condition: { Validator.isValidEmail(email) },
                            text: "Next",
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
    SignupView()
}
