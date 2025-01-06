//
//  LoginView.swift
//  Countdowner
//
//  Created by shmeelok chakraborty on 12/20/24.
//

import SwiftUI

struct LoginView: View {
    @State private var isShowingSheet = false
    @Environment(\.verticalSizeClass) var verticalSizeClass;
    @Environment(\.horizontalSizeClass) var horizontalSizeClass;
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: AuthenticationViewModel
    var isIpadLandscape: Bool {
        horizontalSizeClass == .regular && verticalSizeClass == .regular
    }
    var body: some View {
        VStack {
            Text(APP_NAME).applyCountdownTextStyle()
            Image("CountdownerLogo")
                .resizable()
                .aspectRatio(contentMode: isIpadLandscape ? .fit : .fill)
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
