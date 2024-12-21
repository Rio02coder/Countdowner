//
//  LoginView.swift
//  Countdowner
//
//  Created by shmeelok chakraborty on 12/20/24.
//

import SwiftUI

struct LoginView: View {
    @State private var isShowingSheet = false
    var body: some View {
        VStack {
            Text("Countdown").applyCountdownTextStyle()
            Image("CountdownerLogo")
                .resizable()
                .aspectRatio(contentMode: .fill)
            Spacer()
            Button("Login with email") {
                isShowingSheet.toggle()
            }.sheet(isPresented: $isShowingSheet) {
                LoginSheet(closeAction: {
                    isShowingSheet.toggle()
                })
        }.buttonStyle(LoginWithEmailButtonStyle())
    }
  }
}

#Preview {
    LoginView()
        .applyDefaultBackground()
}
