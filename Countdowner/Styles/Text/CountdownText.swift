//
//  CountdownLogo.swift
//  Countdowner
//
//  Created by shmeelok chakraborty on 12/20/24.
//

import SwiftUI

struct CountdownTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 45, weight: .bold, design: .serif)).foregroundColor(.white)
    }
}

extension View {
    func applyCountdownTextStyle() -> some View {
           self.modifier(CountdownTextStyle())
       }
}
