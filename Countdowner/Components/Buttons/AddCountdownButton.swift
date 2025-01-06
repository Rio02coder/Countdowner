//
//  AddCountdownButton.swift
//  Countdowner
//
//  Created by shmeelok chakraborty on 12/23/24.
//

import SwiftUI

struct AddCountdownButton: View {
    @State private var showSheet: Bool = false
    var uid: String;
    var body: some View {
        Button(action: {
            showSheet.toggle()
        }) {
            Image(systemName: "plus.circle.fill")
                .foregroundColor(.white)
        }.sheet(isPresented: $showSheet, content: {
            AddCountdownSheet(closeHandler: {
                showSheet = false
            }, uid: uid)
        })
    }
}

#Preview {
    AddCountdownButton(uid: "sdj")
        .applyDefaultBackground()
}
