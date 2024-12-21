//
//  SignInWithGoogleButton.swift
//  Countdowner
//
//  Created by shmeelok chakraborty on 12/21/24.
//
import SwiftUI

struct SignInWithGoogleButton: View {
    var body: some View {
        HStack {
                    Spacer()
            Image("Google")
                .frame( alignment: .center)
            Text("Login With Google")
                    Spacer()
        }
        .font(.system(size: 18, weight: .heavy, design: .rounded))
        .foregroundColor(.black)
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: 15)
                        .foregroundColor(.white)
                }
                .padding()

    }
}
