//
//  Navbar.swift
//  Countdowner
//
//  Created by shmeelok chakraborty on 12/23/24.
//

import SwiftUI

struct Navbar: View {
    var title: String = ""
    var isScrolling: Bool
    var children: (any View)?
    var body: some View {
        VStack() {
            Color.clear
                .frame(height: shouldRespectSafeArea() ? 50 : 50)
                .background(.ultraThinMaterial)
                .opacity(isScrolling ? 0.8 : 0)
                .blur(radius: 0.5)
                .edgesIgnoringSafeArea(shouldRespectSafeArea() ? [] : [])
                .overlay(content: {
                    HStack {
                        Text(title)
                            .font(.system(size: isScrolling ? 22 : 35, weight: .bold, design: .serif))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, alignment:  .leading)
                            .padding(.leading)
                        Spacer()
                        if let children = children {
                            AnyView(children)
                                .font(isScrolling ? .body : .title)

                        } else {
                            EmptyView()
                        }
                    }.frame(maxWidth: .infinity)
                     .padding(.horizontal)
//                    Text("Hi").foregroundColor(.white)
                })
        }
        .frame(maxHeight: .infinity, alignment: .top)
        
    }
}

#Preview {
    Navbar(title: "Countdowns", isScrolling: true, children: AddCountdownButton(uid: "shm")).applyDefaultBackground()
}
