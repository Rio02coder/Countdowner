//
//  LoginWithEmail.swift
//  Countdowner
//
//  Created by shmeelok chakraborty on 12/20/24.
//

import SwiftUI
struct LoginWithEmailButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        let label = configuration.label
        HStack {
                    Spacer()
                    label
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
