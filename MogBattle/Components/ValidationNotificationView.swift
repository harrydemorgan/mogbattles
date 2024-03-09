//
//  ValidationNotificationView.swift
//  MogBattle
//
//  Created by Harry Morgan on 26/01/2024.
//

import SwiftUI

struct ValidationNotificationView: View {
    let message: String
    
    var body: some View {
        VStack {
            Text(message)
                .foregroundColor(Color.white)
                .padding()
                .background(Color.gray.opacity(0.5))
                .cornerRadius(8)
                .padding(.horizontal)
                .transition(.move(edge: .top))
            Spacer()
        }
    }
}

#Preview {
    ValidationNotificationView(message: "error")
}
