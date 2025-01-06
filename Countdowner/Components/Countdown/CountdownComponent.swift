//
//  CountdownComponent.swift
//  Countdowner
//
//  Created by shmeelok chakraborty on 12/23/24.
//

import SwiftUI

struct CountdownComponent: View {
    var countdown: Countdown = Countdown(name: "CSE 583 Assignment", description: "Assignment 2")
    var uid: String
    var startColor: Color = Color.pink
    var endColor: Color = Color.red
    @State private var isPresented: Bool = false
    var body: some View {
        
        Button(action: {
            isPresented = true
        }, label: {
            RoundedRectangle(cornerRadius: 30)
                .fill( LinearGradient(
                    gradient: Gradient(colors: [startColor, endColor]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                ))
                .frame(maxWidth: .infinity)
                .frame(height: 170)
                .padding(.horizontal)
                .overlay(content: {
                    VStack {
                        Text(String(getTimeIntervalNumberFromCurrentDate(date: countdown.date)))
                         .fontWeight(.heavy)
                         .fontDesign(.serif)
                         .font(.system(size: 120))
                         .foregroundColor(.white)
                        Text(countdown.name)
                            .lineLimit(1)
                            .fontWeight(.bold)
                            .fontDesign(.rounded)
                            .foregroundColor(.white)
                            .font(.system(size: 19))
                            .padding(.horizontal)
                            .padding(.bottom)
                    }
                     .padding()
                     .frame(maxHeight: .infinity)
                     .frame(alignment: .top)
                })
        }).fullScreenCover(isPresented: $isPresented) {
            CountdownView(uid: uid, countdown: countdown, closeAction: {
                isPresented = false
            }, headerColor: LinearGradient(
                gradient: Gradient(colors: [startColor, endColor]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            ))
        }
    }
}

extension Color {
    static func random() -> Color {
        Color(red: Double.random(in: 0...1),
              green: Double.random(in: 0...1),
              blue: Double.random(in: 0...1))
    }
}

//#Preview {
//    CountdownComponent()
//}
