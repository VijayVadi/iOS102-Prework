//
//  ContentView.swift
//  iOS102-PreWork
//
//  Created by Vijay Vadi on 11/16/23.
//

import Foundation

import SwiftUI

struct ContentView: View {
    
    @State private var animationDegrees: Float = 45.0
    
    @State private var isPresenting = false
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    Text("Welcome,")
                        .font(.system(size: 28))
                        .foregroundStyle(.white)
                        .fontWeight(.medium)
                    Spacer()
                }.padding(.leading, 24)
                
                HStack(spacing: 0) {
                    Text(UserDefaults.standard.string(forKey: "firstName")!)
                        .foregroundStyle(.white)
                        .font(.system(size: 28))
                        .fontWeight(.medium)
                    Spacer()
                }.padding(.leading, 24)
                    .padding(.top, 2)
                
                VStack(alignment: .leading, spacing: 0) {
                        Text("You are good to go!")
                            .foregroundStyle(.white)
                            .font(.system(size: 22))
                            .fontWeight(.medium)
                            .opacity(0.75)
                    
                        Text("Your form answers have been collected,\nif you would like to make any changes you can go back at any time.")
                            .foregroundStyle(.white.opacity(0.5))
                            .font(.system(size: 18))
                            .fontWeight(.medium)
                            .padding(.top, 12)
                }.padding(.leading, 24)
                    .padding(.trailing, 25)
                    .padding(.top, 50)
                
                let userDefaults = UserDefaults.standard
                VStack(spacing: 0) {
                    HStack(spacing: 0) {
                        Text("Your Answers,\n\nName: \(userDefaults.string(forKey: "firstName")!) \(userDefaults.string(forKey: "lastName")!)\nSchool: \(userDefaults.string(forKey: "schoolName")!)\nYear: \(userDefaults.integer(forKey: "year") + 1)\n\nPets: \(userDefaults.integer(forKey: "numberOfPets"))\nMore Pets? \(userDefaults.bool(forKey: "morePets") ? "Yes" : "No")")
                            .foregroundStyle(.white.opacity(0.75))
                            .font(.system(size: 18))
                            .fontWeight(.medium)
                            .padding(.top, 12)
                        
                        Spacer()
                    }.padding(.leading, 24)
                        Button {
                            self.isPresenting = true
                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 50)
                                    .foregroundStyle(.white.opacity(0.5))
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 52)
                            
                                Text("Make Changes")
                                    .foregroundStyle(.black)
                                    .font(.system(size: 18))
                                    .fontWeight(.medium)
                            }
                        }.padding(.horizontal, 40)
                        .padding(.top, 40)
                    
                }
                
                
                Spacer()
                
            }.padding(.top, 96)
                //.background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 25))
                .background(
                    Rectangle().fill(.clear)
                        .blur(radius: 20)
                        .ignoresSafeArea()
                )
                .padding(.leading, 0)
                .padding(.trailing, 0)
        }
        .fullScreenCover(isPresented: $isPresenting, content: {
                    StoryboardPresenter(storyboardName: "Main", viewControllerID: "Main")
                        .edgesIgnoringSafeArea(.all)
                })
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background {
            ZStack {
                LinearGradient(colors: [Color.teal, Color.purple], startPoint: .topLeading, endPoint: .bottomTrailing)
                    .edgesIgnoringSafeArea(.all)
                    .hueRotation(.degrees(Double(animationDegrees)))
                    .onAppear {
                        Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { timer in
                            withAnimation(.smooth(duration: 8).repeatForever(autoreverses: true)) {
                                if animationDegrees >= 360 {
                                    animationDegrees = 45
                                } else {
                                    animationDegrees += 45
                                }
                        }
                        }
                }
                Rectangle()
                    .background(.thinMaterial)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .frame(height: 1000)
            }
        }
    }
}

#Preview {
    ContentView()
}

struct StoryboardPresenter: UIViewControllerRepresentable {
    var storyboardName: String
    var viewControllerID: String?

    func makeUIViewController(context: Context) -> UIViewController {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        if let viewControllerID = viewControllerID {
            return storyboard.instantiateViewController(identifier: viewControllerID)
        } else {
            return storyboard.instantiateInitialViewController()!
        }
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
    }
}
