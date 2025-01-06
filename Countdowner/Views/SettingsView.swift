//
//  SettingsView.swift
//  Countdowner
//
//  Created by shmeelok chakraborty on 12/22/24.
//

import SwiftUI
import WidgetKit

struct SettingsView: View {
    @EnvironmentObject private var authViewModel: AuthenticationViewModel
    @State var showAlert: Bool = false
    var body: some View {
        VStack {
            // Single person icon
            Image(systemName: "person.circle.fill")
                .resizable()
                .frame(width: 100, height: 100)
                .foregroundColor(.blue)
                .padding(.top, 50)
                    
                    // Email display
            Text(authViewModel.displayName)
                        .font(.title2)
                        .fontDesign(.serif)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.top, 20)
                    
            Spacer()
            
            VStack(spacing: 15) {
                Button(action: {
                    UserDefaults(suiteName: APP_GROUP_NAME)?.removeObject(forKey: COUNTDOWN_USER_DEFAULTS_NAME)
                    UserDefaults(suiteName: APP_GROUP_NAME)?.synchronize()
                    WidgetCenter.shared.reloadAllTimelines()
                    authViewModel.signOut()
                }) {
                    Text("Logout")
                        .font(.system(size: 18, weight: .semibold))
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.white)
                        .foregroundColor(.black)
                        .cornerRadius(12)
                        .padding(.horizontal, 40)
                }
                
                Button(action: {
                    Task {
                        UserDefaults(suiteName: APP_GROUP_NAME)?.removeObject(forKey: COUNTDOWN_USER_DEFAULTS_NAME)
                        UserDefaults(suiteName: APP_GROUP_NAME)?.synchronize()
                        WidgetCenter.shared.reloadAllTimelines()
                        if await authViewModel.deleteAccount() == false {
                            showAlert = true
                        }
                    }
                }) {
                    Text("Delete Account")
                        .font(.system(size: 18, weight: .semibold))
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                        .padding(.horizontal, 40)
                }
            }
            .padding(.bottom, 30)
        }
        .frame(maxWidth: .infinity, alignment: .top)
        .background(Color(UIColor.black))

        .alert("Error", isPresented: $showAlert, actions: {
            Button("Ok") {
                showAlert = false
            }
        }, message: {
            Text("There was an error in deleting your account. Try again later").foregroundColor(.white)
        })
    }
}

#Preview {
    SettingsView()
        .environmentObject(AuthenticationViewModel())
}
