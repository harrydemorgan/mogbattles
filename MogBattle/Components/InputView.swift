//
//  InputView.swift
//  MogBattle
//
//  Created by Harry Morgan on 21/01/2024.
//

import SwiftUI

struct InputView: View {
    @Binding var text: String
    let title: String
    let placeholder: String
    var isSecureField = false
    @FocusState var keyboardFocused: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .foregroundStyle(Color(.white))
                .fontWeight(.semibold)
            if isSecureField {
                SecureField("",
                            text:$text,
                            prompt: Text(placeholder)
                            .foregroundColor(.gray)
                )
                    .padding()
                    .background(Color.black) // Set the background color of the text field to black
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray, lineWidth: 1) // Add a gray border
                    )
                    .foregroundColor(.white) // Set the text color to white
                    .padding(.horizontal)
                    .accentColor(.white) // Set the cursor and clear button color to white
                    .foregroundColor(Color.gray.opacity(0.5)) // Set the placeholder text color to lighter gray
            } else {
                TextField("",
                          text:$text,
                          prompt: Text(placeholder)
                          .foregroundColor(.gray)
                )
                    .focused($keyboardFocused)
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                keyboardFocused = true
                            }
                        }
                    .padding()
                    .background(Color.black) // Set the background color of the text field to black
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray, lineWidth: 1) // Add a gray border
                    )
                    .foregroundColor(.white) // Set the text color to white
                    .padding(.horizontal)
                    .accentColor(.white) // Set the cursor and clear button color to white
                    .foregroundColor(Color.gray.opacity(0.5)) // Set the placeholder text color to lighter gray
            }
            
            //Divider()
        }
    }
}

#Preview {
    ZStack {
        Color.black.edgesIgnoringSafeArea(.all)
        InputView(text: .constant(""), title: "Email Address", placeholder: "name@example.com")
    }
}
