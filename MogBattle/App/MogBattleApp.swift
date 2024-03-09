//
//  MogBattleApp.swift
//  MogBattle
//
//  Created by Harry Morgan on 21/01/2024.
//

import SwiftUI
import Firebase

@main
struct MogBattleApp: App {
    @StateObject var viewModel = AuthViewModel()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
