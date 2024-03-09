//
//  SwiftUIView.swift
//  MogBattle
//
//  Created by Harry Morgan on 25/01/2024.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var validationMessage: String?
    @FocusState private var isFocused: Bool
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)
                VStack {
                    // Form Fields
                    VStack {
                        Spacer()
                        // Title
                        Text("Log in")
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
                        
                        // Password input
                        InputView(text: $password,
                                  title: "",
                                  placeholder: "Password",
                                  isSecureField: true)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                        
                        Spacer()
                        
                        // Forgot password
                        Text("Forgot password?")
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .padding()
                        
                        // Next button
                        Button(action: {
                            Task {
                                do {
                                    try await viewModel.signIn(withEmail: email, password: password)
                                } catch {
                                    validationMessage = "Invalid email or password"
                                }
                            }
                        }) {
                            HStack {
                                Spacer()
                                Text("Log in")
                                    .fontWeight(.bold)
                                Spacer()
                            }
                            .padding()
                            // Change button colour if email not valid and password not valid
                            .background(!(Validator.isValidEmail(email) || (password.count > 5 && password.count < 31)) ? Color.gray.opacity(0.5) : Color.white)
                            .foregroundColor(!(Validator.isValidEmail(email) || (password.count > 5 && password.count < 31)) ? Color.gray : Color.black)
                            .cornerRadius(8)
                        }
                        .padding(.top, 20)
                        // Disable button if email and password not valid
                        .disabled(!(Validator.isValidEmail(email)) || password.count < 5 || password.count > 31)
                        .padding(.horizontal)
                        
                    }
                    .padding(.horizontal)
                    
                }
                // Conditional overlay for validation message
                if let message = validationMessage {
                    ValidationNotificationView(message: message)
                    .onAppear {
                        // Set a timer to clear the validation message after 3 seconds
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            withAnimation {
                                validationMessage = nil
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    LoginView()
}
