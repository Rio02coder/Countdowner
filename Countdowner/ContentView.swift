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
            HomeView()
                .environmentObject(viewModel)
        }
    }
}

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
