//
//  LoginView.swift
//  Countdowner
//
//  Created by shmeelok chakraborty on 12/20/24.
//

import SwiftUI

struct LoginView: View {
    @State private var isShowingSheet = false
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: AuthenticationViewModel
    var body: some View {
        VStack {
            Text(APP_NAME).applyCountdownTextStyle()
            Image("CountdownerLogo")
                .resizable()
                .aspectRatio(contentMode: .fill)
            Spacer()
            Button(action: {
                Task {
                    if await viewModel.signInWithGoogle() == true {
                        dismiss()
                    }
                }
                }) {
                  SignInWithGoogleButton()
                }
    }
  }
}

#Preview {
    LoginView()
        .applyDefaultBackground()
}
