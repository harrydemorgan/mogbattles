//
//  ContentView.swift
//  MogBattle
//
//  Created by Harry Morgan on 21/01/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var isProfileView = true
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            if viewModel.userSession != nil {
                StaticUIView(isProfileView: $isProfileView)
                if isProfileView {
                    ProfileView()
                } else {
                    VotingView()
                }
            } else {
                StartscreenView()
            }
        }
    }
}

#Preview {
    ContentView().environmentObject(AuthViewModel())
}
