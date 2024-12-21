//
//  ErrorText.swift
//  Countdowner
//
//  Created by shmeelok chakraborty on 12/21/24.
//

import SwiftUI

struct ErrorText: View {
    var showError: Bool
    var label: String
    var body: some View {
        if(showError) {
            Text(label)
                .foregroundColor(.red)
                .font(.caption)
                .fontWeight(.bold)
                .padding(.horizontal)
        } else {
            EmptyView()
        }
    }
}
