//
//  DismissKeyboard.swift
//  Countdowner
//
//  Created by shmeelok chakraborty on 12/20/24.
//

import SwiftUI

struct DismissKeyboardModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(
                Color.clear
                    .contentShape(Rectangle()) // Ensures the background area is tappable
                    .onTapGesture {
                        hideKeyboard()
                    }
            )
    }

    private func hideKeyboard() {
        UIApplication.shared.inputView?.endEditing(true)
    }
}

extension View {
    func dismissKeyboardOnTap() -> some View {
        self.modifier(DismissKeyboardModifier())
    }
}
