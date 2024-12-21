//
//  Heading.swift
//  Countdowner
//
//  Created by shmeelok chakraborty on 12/20/24.
//

import SwiftUI

struct HeadlineTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content.font(.system(size: 34, weight: .bold, design: .serif)).foregroundColor(.white)
    }
}

extension View {
    func applyHeadlineTextStyle() -> some View {
        self.modifier(HeadlineTextStyle())
    }
}

