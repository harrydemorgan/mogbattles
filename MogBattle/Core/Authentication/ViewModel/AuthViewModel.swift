//
//  AuthViewModel.swift
//  MogBattle
//
//  Created by Harry Morgan on 25/01/2024.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
import FirebaseStorage

protocol AuthenticationFormProtocol {
    var formIsValid: Bool { get }
}

@MainActor
class AuthViewModel : ObservableObject {
    // Check whether user logged in
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    
    init() {
        self.userSession = Auth.auth().currentUser
        
        Task {
            await fetchUser()
        }
    }
    
    func signIn(withEmail email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            // Fetch user info to set currentUser
            await fetchUser()
        } catch {
            // Invalid login
            print("DEBUG: Failed to log in with error \(error.localizedDescription)")
            // catch this error in loginview
            throw error
        }
    }
    
    func signUp(withEmail email: String, password: String, username: String) async throws {
        // Function to check username availability
        func checkUsernameAvailability(_ username: String) async throws -> Bool {
            let querySnapshot = try await Firestore.firestore().collection("users").whereField("username", isEqualTo: username).getDocuments()
            return querySnapshot.documents.isEmpty
        }
        
        do {
            // Check username availability
            let isUsernameAvailable = try await checkUsernameAvailability(username)
            guard isUsernameAvailable else {
                throw NSError(domain: "com.yourapp.error", code: -1, userInfo: [NSLocalizedDescriptionKey: "Username is already taken"])
            }
            // Create user with email and password
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            // Save user data in firestore
            let user = User(id: result.user.uid, username: username, email: email)
            let encodedUser = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
            // Fetch user data
            await fetchUser()
        } catch {
            print("DEBUG: Failed to create user with error \(error.localizedDescription)")
            throw error
        }
    }
    
    func signOut() {
        do {
            // Sign out on backend
            try Auth.auth().signOut()
            // Clear user session and go back to start screen
            self.userSession = nil
            self.currentUser = nil
        } catch {
            print("DEBUG: Failed to sign out with error \(error.localizedDescription)")
        }
    }
    
    func deleteAccount() {
        
    }
    
    func fetchUser() async {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let snapshot = try? await Firestore.firestore().collection("users").document(uid).getDocument() else { return }
        // Set the current user
        self.currentUser = try? snapshot.data(as: User.self)
    }
}
