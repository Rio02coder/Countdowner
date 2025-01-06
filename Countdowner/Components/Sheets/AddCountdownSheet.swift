//
//  AddCountdownSheet.swift
//  Countdowner
//
//  Created by shmeelok chakraborty on 12/23/24.
//

import SwiftUI

struct AddCountdownSheet: View {
    var closeHandler: () -> Void
    var uid: String;
    var body: some View {
        VStack {
            AddCountdownForm(closeHandler: closeHandler, uid: uid)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding(.top)
        .background(Color(red: 37/255, green: 38/255, blue: 38/255))
    }
}

#Preview {
    AddCountdownSheet(closeHandler: {
        print("Sheet closed")
    }, uid: "shm")
}
