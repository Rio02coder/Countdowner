//
//  CountdownView.swift
//  Countdowner
//
//  Created by shmeelok chakraborty on 12/22/24.
//

import SwiftUI

struct CountdownListView: View {
    var countdowns: [Countdown];
    var uid: String?
    let columns = [
        GridItem(.adaptive(minimum: 180)),
        ]
    @State private var initialMinY: CGFloat? = nil
    @State var isScrolling: Bool = false
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(countdowns) { countdown in
                    CountdownComponent(countdown: countdown, uid: uid != nil ? uid! : "")
                        .scrollTransition { content, phase in
                            content
                                .opacity(phase.isIdentity ? 1.0 : 0.5)
                                .scaleEffect(x: phase.isIdentity ? 1.0 : 0.8, y: phase.isIdentity ? 1.0 : 0.8)
                        }
                        .background(
                            GeometryReader { geo in
                            Color.clear.preference(key: ScrollPreferenceKey.self, value: geo.frame(in: .named("scroll")).minY)
                            }
                         )
                      }
             }
        }
        .contentMargins(15, for: .scrollContent)
        .coordinateSpace(name: "scroll")
        .onPreferenceChange(ScrollPreferenceKey.self, perform: { minY in
            guard let minY = minY else { return }
            if initialMinY == nil {
                initialMinY = minY
            } else if let initial = initialMinY {
                withAnimation(.default) {
                    isScrolling = minY < initial
                }
            }
        })
        .safeAreaInset(edge: .top, content: {
            Color.clear
                .frame(height: 60)
        })
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay {
            Navbar(title: "Countdowns", isScrolling: isScrolling, children: AddCountdownButton(uid: uid == nil ? "" : uid!))
        }

    }
}

//#Preview {
//    CountdownListView()
//        .applyDefaultBackground()
//}
