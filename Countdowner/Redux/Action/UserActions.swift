//
//  UserActions.swift
//  Countdowner
//
//  Created by shmeelok chakraborty on 12/11/24.
//

protocol UserActions: ReduxAction {}


struct AddUserAction: UserActions {
    var newUser: User
}

struct DeleteUserAction: UserActions {}
