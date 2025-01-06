//
//  SafeAreaUtils.swift
//  Countdowner
//
//  Created by shmeelok chakraborty on 1/5/25.
//

import SwiftUI

func shouldRespectSafeArea() -> Bool {
    let screenSize = UIScreen.main.bounds.size
    return screenSize.width <= 375
}
