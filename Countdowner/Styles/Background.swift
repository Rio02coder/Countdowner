//
//  Background.swift
//  Countdowner
//
//  Created by shmeelok chakraborty on 12/20/24.
//

import SwiftUI

struct DefaultBackgroundModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(Color.black) // Set your default color here
    }
}

extension View {
    func applyDefaultBackground() -> some View {
        self.modifier(DefaultBackgroundModifier())
    }
}
