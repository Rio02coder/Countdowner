//
//  HomeView.swift
//  Countdowner
//
//  Created by shmeelok chakraborty on 12/22/24.
//

import SwiftUI
import WidgetKit

struct HomeView: View {
    @EnvironmentObject private var authViewModel: AuthenticationViewModel
    @StateObject private var countdownListener = CountdownListener()
    init() {
        let appearance = UITabBarAppearance()
                appearance.configureWithDefaultBackground()
                appearance.backgroundEffect = UIBlurEffect(style: .systemMaterial)
        appearance.backgroundColor = UIColor(red: 50/255, green: 50/255, blue: 50/255, alpha: 0.5)
                UITabBar.appearance().standardAppearance = appearance
                UITabBar.appearance().scrollEdgeAppearance = appearance
    }

    var body: some View {
        TabView {
            CountdownListView(countdowns: countdownListener.countdowns, uid: authViewModel.user?.uid)
                .applyDefaultBackground()
                .tabItem {
                    Image(systemName: "timer")
                    Text("Countdowns")
                }
            SettingsView()
                .applyDefaultBackground()
                .tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
                }
        }
        .tint(.white)
        .onAppear() {
            if ((authViewModel.user?.uid) != nil) {
                countdownListener.startListening(authViewModel.user?.uid ?? "")
            }
        }
        .onDisappear() {
            if(authViewModel.user?.uid != nil) {
                let encoder = JSONEncoder()
                if let encoded = try? encoder.encode(countdownListener.countdowns) {
                    let defaults = UserDefaults(suiteName: APP_GROUP_NAME)
                    defaults?.set(encoded, forKey: COUNTDOWN_USER_DEFAULTS_NAME)
                    defaults?.synchronize()
                    WidgetCenter.shared.reloadAllTimelines()
                }
            }
            countdownListener.stopListening()
        }
    }
}

struct CustomTabBarBackground: View {
    var body: some View {
        Color.black // Background for the tab
    }
}

#Preview {
    HomeView()
        .environmentObject(AuthenticationViewModel())
        .applyDefaultBackground()
}
