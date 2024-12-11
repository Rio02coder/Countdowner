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

    var body: some View {
        NavigationView {
            VStack{
                Text("Hello world")
                Button("Add") {
                    store.dispatch(action: AddCountdownAction(newCountdown: Countdown(name: "Math")))
                }
                Button("View") {
                    print(store.state.countdowns)
                    print(store.state.user)
                }
                .navigationTitle(Text("Welcome"))
            }
        }
    }
}

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
