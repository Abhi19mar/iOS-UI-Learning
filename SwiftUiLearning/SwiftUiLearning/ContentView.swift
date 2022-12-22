//
//  ContentView.swift
//  SwiftUiLearning
//
//  Created by Abhishek Goel on 22/12/22.
//

import SwiftUI

struct ContentView: View {
    @State var isPresenting = false
    @State var readyToNavigate : Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Button {
                    //Code here before changing the bool value
                    readyToNavigate = false
                } label: {
                    Text("Navigate Button")
                }
                
                Button {
                    //Code here before changing the bool value
                    readyToNavigate = true
                } label: {
                    Text("Navigate Button")
                }.navigationTitle("Navigation")
                    .navigationDestination(isPresented: $readyToNavigate) {
                        HolaView()
                    }
            }
        }
        
    }
    
}

struct HolaView: View {
    var body: some View {
        Text("Hola, como estas?")
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
