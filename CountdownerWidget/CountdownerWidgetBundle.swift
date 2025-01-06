//
//  CountdownerWidgetBundle.swift
//  CountdownerWidget
//
//  Created by shmeelok chakraborty on 1/5/25.
//

import WidgetKit
import SwiftUI

@main
struct CountdownerWidgetBundle: WidgetBundle {
    var body: some Widget {
        CountdownerWidget()
        CountdownerWidgetControl()
        CountdownerWidgetLiveActivity()
    }
}
