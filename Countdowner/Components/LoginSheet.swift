//
//  LoginSheet.swift
//  Countdowner
//
//  Created by shmeelok chakraborty on 12/20/24.
//

import SwiftUI

struct LoginSheet: View {
    let closeAction: () -> Void
    @State private var email: String = ""
    var body: some View {
        ZStack{
            Image("EmailLoginLinkLogo")
                .resizable()
                .aspectRatio(contentMode: .fit)
            VStack{
                Text("Your Email").applyHeadlineTextStyle()
                    .padding(.top, 50)
                TextField("Email", text: $email)
                                .padding()
                                .background(Color(.white))
                                .cornerRadius(18)
                                .padding(.horizontal)
                Spacer()
                Button("Send Link") {
                    closeAction()
                }
            }
        }
        .buttonStyle(LoginWithEmailButtonStyle())
        .background(Color(red: 37/255, green: 38/255, blue: 38/255))
    }
}

//#Preview {
//    LoginSheet(closeAction: {
//        
//    }).applyDefaultBackground()
//}
