//
//  ProfileView.swift
//  MogBattle
//
//  Created by Harry Morgan on 25/01/2024.
//

import SwiftUI

struct ProfileView: View {
    @State private var image = UIImage()
    @State private var showSheet = false
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        if let user = viewModel.currentUser {
            List {
                Section {
                    HStack {
                        ZStack {
                            Image(uiImage: self.image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 80, height: 80)
                                .clipShape(Circle())
                                .onTapGesture {
                                    showSheet = true
                                }
                            Image(systemName: "plus")
                                .foregroundColor(.white)
                                .frame(width: 20, height: 20)
                                .background(Color.blue)
                                .clipShape(Circle())
                                .offset(x: 27, y: 27)
                        }
                        .sheet(isPresented: $showSheet) {
                               // Pick an image from the photo library:
                               ImagePicker(sourceType: .photoLibrary, selectedImage: self.$image)

                               //  If you wish to take a photo from camera instead:
                               // ImagePicker(sourceType: .camera, selectedImage: self.$image)
                        }
                        Spacer().frame(width:10)
                        Text(user.username)
                            .fontWeight(.semibold)
                        
                    }
                }
                
                Section {
                    HStack {
                        Text("Username")
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        Spacer()
                        // Text(user.username)
                        Text(user.username)
                    }
                }
                Section {
                    HStack {
                        Text("Email")
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        Spacer()
                        Text(user.email)
                    }
                }
                Section {
                    HStack {
                        Text("UID")
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        Spacer()
                        Text(user.id)
                    }
                }
                
                Button {
                    viewModel.signOut()
                } label: {
                    Text("Sign out")
                }
                
                Button {
                    
                } label: {
                    Text("Delete account")
                }
            }
        }
    }
}

#Preview {
    ProfileView()
}
