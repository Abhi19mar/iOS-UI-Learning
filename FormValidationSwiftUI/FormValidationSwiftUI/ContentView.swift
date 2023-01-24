//
//  ContentView.swift
//  FormValidationSwiftUI
//
//  Created by Abhishek Goel on 17/01/23.
//

import SwiftUI
import Combine

struct ContentView: View {
    @StateObject private var viewModel = LoginViewModel()
    @State private var isTapped: Bool = false
    @State private var email: String = ""
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.red, .orange]), startPoint: .leading, endPoint: .trailing).ignoresSafeArea()
                VStack(spacing: 10) {
                    EntryField(sfSymbolName: "envelope", placeholder: "Email Address", prompt: viewModel.emailPrompt, field: $viewModel.email)
                        .padding(EdgeInsets(top: 10, leading: 20, bottom: 20, trailing: 20))
                    EntryField(sfSymbolName: "lock.fill", placeholder: "Password", prompt: viewModel.passwordPrompt, field: $viewModel.password, isSecure: true)
                        .padding(EdgeInsets(top: 10, leading: 20, bottom: 20, trailing: 20))
                    EntryField(sfSymbolName: "lock.fill", placeholder: "Confirm", prompt: viewModel.confirmPasswordPrompt, field: $viewModel.confirmPassword, isSecure: true)
                        .padding(EdgeInsets(top: 10, leading: 20, bottom: 20, trailing: 20))
                    Button {
                        if viewModel.canSubmit {
                            isTapped = true
                            email = viewModel.getDetails()
                            viewModel.login()
                        }
                    } label: {
                        Text("Sign Up")
                            .bold()
                    }.disabled(!viewModel.canSubmit)
                        .buttonBorderShape(.capsule)
                        .buttonStyle(.bordered)
                        .padding(.top, 100)
                }.padding(.bottom, 100)
            }.navigationTitle("Login Page")
                .navigationDestination(isPresented: $isTapped) {
                    SecondScreen(email: email)
                }
        }
    }
}

struct SecondScreen: View {
    var email: String
    var options: [Profile] = [.init(name: "Edit Password", image: "lock"),
                              .init(name: "Edit photo", image: "person.fill")]
    var body: some View {
        NavigationStack {
            Text("You have been sucessfully logged in with email: \(email)")
            VStack {
                List {
                    Section("My Profile") {
                        ForEach(options, id: \.name) { option in
                            NavigationLink(value: option) {
                                Label(option.name, systemImage: option.image)
                            }
                        }
                    }
                }
            }.navigationTitle("hello")
                .navigationDestination(for: Profile.self) { option in
                    ZStack {
                        Label(option.name, systemImage: option.image)
                            .font(.largeTitle.bold())
                    }
                }
        }
    }
}

struct Profile: Hashable {
    let name: String
    let image: String
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
