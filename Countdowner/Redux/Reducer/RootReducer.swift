//
//  RootReducer.swift
//  Countdowner
//
//  Created by shmeelok chakraborty on 12/11/24.
//

func rootReducer (_ state: ReduxState, _ action: ReduxAction) -> Appstate {
    var state = state as! Appstate
    switch action {
        case let action as UserActions:
            state.user = userReducer(state.user, action)
        case let action as CountdownActions:
            state.countdowns = countdownReducer(state.countdowns, action)
        default:
            break
        }
    return state
}
