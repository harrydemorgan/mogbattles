//
//  SignupUsernameView.swift
//  MogBattle
//
//  Created by Harry Morgan on 25/01/2024.
//

import SwiftUI

struct SignupUsernameView: View {
    let email: String
    let password: String
    @State private var username = ""
    @State private var validationMessage: String?
    @FocusState private var isFocused: Bool
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            VStack {
                // Form Fields
                VStack {
                    Spacer()
                    // Title
                    Text("Enter a username")
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding(.bottom, 10)
                    
                    // Email input
                    InputView(text: $username,
                              title: "",
                              placeholder: "Username")
                    // Open keyboard automatically
                    .focused($isFocused)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            isFocused = true
                        }
                    }
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                    
                    Spacer()
                    
                    Button(action: {
                        Task {
                            if Validator.isValidUsername(username) {
                                do {
                                    try await viewModel.signUp(withEmail: email, password: password, username: username)
                                } catch {
                                    validationMessage = error.localizedDescription
                                }
                            } else {
                                validationMessage = "Username contains invalid characters"
                            }
                        }
                    }) {
                        HStack {
                            Spacer()
                            Text("Next")
                                .fontWeight(.bold)
                            Spacer()
                        }
                        .padding()
                        // Change button colour if email not valid
                        .background(username.count < 3 || username.count > 16 ? Color.gray.opacity(0.5) : Color.white)
                        .foregroundColor(username.count < 3 || username.count > 16 ? Color.gray : Color.black)
                        .cornerRadius(8)
                    }
                    .padding(.top, 20)
                    // Disable button if email not valid
                    .disabled(username.count < 3 || username.count > 16)
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


#Preview {
    SignupUsernameView(email: "email", password: "password")
}
