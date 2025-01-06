//
//  UserReducer.swift
//  Countdowner
//
//  Created by shmeelok chakraborty on 12/11/24.
//

func userReducer(_ userState: UserState, _ userAction: UserActions) -> UserState {
    var userState = userState
    switch userAction {
        case let userAction as AddUserAction:
            userState.user = userAction.newUser
    case _ as DeleteUserAction:
            userState.user = nil
        default:
            break
    }
    return userState
}
