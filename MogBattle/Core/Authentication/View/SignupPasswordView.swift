//
//  SignupPasswordView.swift
//  MogBattle
//
//  Created by Harry Morgan on 22/01/2024.
//

import SwiftUI

struct SignupPasswordView: View {
    let email: String
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var validationMessage: String?
    @State private var isValidated = false
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
                        Text("Enter a password")
                            .font(.largeTitle)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .padding(.bottom, 10)
                        
                        // Password input
                        InputView(text: $password,
                                  title: "",
                                  placeholder: "Password",
                                  isSecureField: true)
                            .focused($isFocused)
                            .onAppear {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                    isFocused = true
                                }
                            }
                            .autocorrectionDisabled()
                            .textInputAutocapitalization(.never)
                        
                        // Confirm password input
                        InputView(text: $confirmPassword,
                                  title: "",
                                  placeholder: "Confirm password",
                                  isSecureField: true)
                            .autocorrectionDisabled()
                            .textInputAutocapitalization(.never)
                        
                        Spacer()

                        NavButton(destination: AnyView(SignupUsernameView(email: email, password: password)), condition: { password.count > 5 && password.count < 31 && password == confirmPassword }, text: "Next", finalColor: .white, finalTextColor: .black)
                    }
                    .padding(.horizontal)
                }
            }
        }
    }
}

#Preview {
    SignupPasswordView(email: "email")
}
