//
//  ScrollPreferenceKey.swift
//  Countdowner
//
//  Created by shmeelok chakraborty on 12/23/24.
//

import SwiftUICore

struct ScrollPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat? = nil
    static func reduce(value: inout CGFloat?, nextValue: () -> CGFloat?) {
        value = value ?? nextValue()
    }
}
