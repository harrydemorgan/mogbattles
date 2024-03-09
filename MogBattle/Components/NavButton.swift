//
//  NavButton.swift
//  MogBattle
//
//  Created by Harry Morgan on 25/01/2024.
//

import SwiftUI

struct NavButton: View {
    let destination: AnyView
    let condition: () -> Bool
    let text: String
    let finalColor: Color
    let finalTextColor: Color

    var body: some View {
        NavigationLink(destination: destination) {
            HStack {
                Spacer()
                Text(text)
                    .fontWeight(.bold)
                Spacer()
            }
            .padding()
            // Change button color if validation fails
            .background(!condition() ? Color.gray.opacity(0.5) : finalColor)
            .foregroundColor(!condition() ? Color.gray : finalTextColor)
            .cornerRadius(8)
        }
        .padding(.top, 20)
        // Disable button if validation fails
        .disabled(!condition())
    }
}

#Preview {
    NavButton(destination: AnyView(EmptyView()), condition: { true }, text: "Next", finalColor: .black, finalTextColor: .white)
}
