//
//  LoginWithEmail.swift
//  Countdowner
//
//  Created by shmeelok chakraborty on 12/21/24.
//

import Foundation

func loginWithEmailValidator (email: String) -> Bool {
    let emailRegex =
                #"^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
    return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
}
