//
//  AddCountdownFormStyle.swift
//  Countdowner
//
//  Created by shmeelok chakraborty on 12/23/24.
//

import SwiftUI

struct CountdownAddFormTitleStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 20, weight: .bold, design: .serif))
            .foregroundColor(.white)
    }
}

struct CountdownAddFormCancelButtonStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.red)
            .fontDesign(.rounded)
            .font(.system(size: 20))
    }
}

struct CountdownAddFormTitleAndDescriptionStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(Color(red:57/255, green: 56/255, blue: 55/255))                .frame(maxWidth: .infinity)
            .frame(height: 130)
            .padding(.horizontal)
    }
}

struct CountdownAddFormTextFieldStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.horizontal)
            .padding(.leading)
            .font(.system(size: 20, weight: .regular, design: .rounded))
            .foregroundColor(.white)
    }
}

struct CountdownTitleTextFieldPlaceholderStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(Color(red:146/255, green: 150/255, blue: 147/255))
    }
}

struct CountdownAddFormTimeTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .font(.system(size: 20))
            .fontWeight(.semibold)
            .fontDesign(.rounded)
    }
}

struct CountdownAddFormDividerStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(.white)
            .padding(.horizontal)
            .padding(.leading)
    }
}

extension View {
    func applyCountdownAddFormTitleStyle() -> some View {
        self.modifier(CountdownAddFormTitleStyle())
    }
    
    func applyCountdownAddFormCancelButtonStyle() -> some View {
        self.modifier(CountdownAddFormCancelButtonStyle())
    }
    
    func applyCountdownAddFormTitleAndDescriptionStyle() -> some View {
        self.modifier(CountdownAddFormTitleAndDescriptionStyle())
    }
    
    func applyCountdownAddFormTextFieldStyle() -> some View {
        self.modifier(CountdownAddFormTextFieldStyle())
    }
    
    func applyCountdownTitleTextFieldPlaceholderStyle() -> some View {
        self.modifier(CountdownTitleTextFieldPlaceholderStyle())
    }
    
    func applyCountdownAddFormTimeTextStyle() -> some View {
        self.modifier(CountdownAddFormTimeTextStyle())
    }
    
    func applyCountdownAddFormDividerStyle() -> some View {
        self.modifier(CountdownAddFormDividerStyle())
    }
}
