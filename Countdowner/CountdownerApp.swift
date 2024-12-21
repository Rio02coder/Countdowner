//
//  CountdownerApp.swift
//  Countdowner
//
//  Created by shmeelok chakraborty on 12/10/24.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth
import GoogleSignIn

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
    func application(_ app: UIApplication,
                     open url: URL,
                     options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return GIDSignIn.sharedInstance.handle(url)
    }
    
//  func application(_ app: UIApplication,
//                     open url: URL,
//                     options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
//    return GIDSignIn.sharedInstance.handle(url)
//  }
}

@main
struct CountdownerApp: App {
    let persistenceController = PersistenceController.shared
    let store: Store = Store()
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(store)
//            LoginView()
//                .applyDefaultBackground()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
//                .environmentObject(store)
//                .environmentObject(viewModel)
        }
    }
}
