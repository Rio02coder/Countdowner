//
//  Appstate.swift
//  Countdowner
//
//  Created by shmeelok chakraborty on 12/11/24.
//

struct Appstate: ReduxState {
    var user = UserState()
    var countdowns = CountdownState()
}
