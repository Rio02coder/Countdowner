//
//  CountdownerApp.swift
//  Countdowner
//
//  Created by shmeelok chakraborty on 12/10/24.
//

import SwiftUI

@main
struct CountdownerApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
