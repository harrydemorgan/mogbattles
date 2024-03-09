//
//  SwiftUIView.swift
//  MogBattle
//
//  Created by Harry Morgan on 27/01/2024.
//

import SwiftUI

struct StaticUIView: View {
    @Binding var isProfileView: Bool
    var body: some View {
        HStack {
            Spacer()
            Button(action: {
                isProfileView = false
            }) {
                Text("Vote")
                    .font(.title3)
                    .foregroundStyle(isProfileView ? Color.gray : Color.white)
                    .fontWeight(isProfileView ? .regular : .semibold)
            }
            .disabled(!isProfileView)
            
            Spacer()
            
            Button(action: {
                isProfileView = true
            }) {
                Text("Profile")
                    .font(.title3)
                    .foregroundStyle(isProfileView ? Color.white : Color.gray)
                    .fontWeight(isProfileView ? .semibold : .regular)
            }
            .disabled(isProfileView)
            Spacer()
        }
    }
}
