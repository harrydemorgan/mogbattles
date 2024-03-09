//
//  ContentView.swift
//  MogBattles
//
//  Created by Harry Morgan on 17/01/2024.
//

import SwiftUI

struct VotingView: View {
    @State private var isButton1Tapped = false
    @State private var isButton2Tapped = false
    @State private var showNextButton = false
    var body: some View {
        VStack {
            Spacer() // Add some space at the top
                    
            HStack {
                // Button 1
                Button(action: {
                    // Handle action for Button 1
                    withAnimation() {
                        isButton1Tapped.toggle()
                        if !showNextButton {
                            showNextButton.toggle()
                        }
                        if isButton1Tapped && isButton2Tapped {
                            isButton1Tapped.toggle()
                            isButton2Tapped.toggle()
                        }
                    }
                    print("Button 1 tapped")
                }) {
                    ZStack {
                        Image("person1")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 170, height: 170)
                            .cornerRadius(10)
                            .opacity((isButton1Tapped ? 0.8 : 1.0) * (isButton2Tapped ? 0.4 : 1.0)) // Darken the image when tapped
                        if isButton1Tapped || isButton2Tapped {
                            Text("20%")
                                .foregroundStyle(Color.white)
                                .font(.title)
                        }
                    }
                }
                // Spacer between buttons
                Spacer()
                
                // Button 2
                Button(action: {
                    // Handle action for Button 2
                    withAnimation() {
                        isButton2Tapped.toggle()
                        if !showNextButton {
                            showNextButton.toggle()
                        }
                        if isButton1Tapped && isButton2Tapped {
                            isButton1Tapped.toggle()
                            isButton2Tapped.toggle()
                        }
                    }
                    print("Button 2 tapped")
                }) {
                    ZStack {
                        Image("person2")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 170, height: 170)
                            .cornerRadius(10)
                            .opacity((isButton2Tapped ? 0.8 : 1.0) * (isButton1Tapped ? 0.4 : 1.0)) // Darken the image when tapped
                        if isButton1Tapped || isButton2Tapped {
                            Text("80%")
                                .foregroundStyle(Color.white)
                                .font(.title)
                        }
                    }
                }
            }
            Spacer() // Add some space at the bottom
            
            ZStack() {
                // Centered "Next" button
                if showNextButton {
                    Button(action: {
                        // Handle action for "Next" button
                        print("Next button tapped")
                    }) {
                        Text("Next")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(Color.white)
                            .cornerRadius(10)
                            .font(.title) // Adjust the font size, .title is larger
                    }
                    .buttonStyle(PlainButtonStyle()) // Disable default button animation for "Next" button
                }
            }
        }
        .padding() // Optional: Add padding to the entire VStack
        .background(Color.black)
    }
    
    
    
}

#Preview {
    VotingView()
}
