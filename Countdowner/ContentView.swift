//
//  ContentView.swift
//  Countdowner
//
//  Created by shmeelok chakraborty on 12/10/24.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var store: Store
    @StateObject var viewModel = AuthenticationViewModel()
    var body: some View {
        if(viewModel.user == nil) {
            LoginView()
                .environmentObject(viewModel)
                .applyDefaultBackground()
        } else {
            NavigationView {
                VStack{
                    Text("Hello world")
                    Button("Sign out") {
                        viewModel.signOut()
                    }
                    Button("Add") {
                        store.dispatch(action: AddCountdownAction(newCountdown: Countdown(name: "Math")))
                    }
                    Button("View") {
                        print(store.state.countdowns)
                    }
                    .navigationTitle(Text("Welcome"))
                }
            }.applyDefaultBackground()
        }
    }
}

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
