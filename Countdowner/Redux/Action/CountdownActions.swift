//
//  CountdownActions.swift
//  Countdowner
//
//  Created by shmeelok chakraborty on 12/11/24.
//

protocol CountdownActions: ReduxAction {}


struct AddCountdownAction: CountdownActions {
    var newCountdown: Countdown
}

struct DeleteCountdownAction: CountdownActions {
    var idOfCountdownToDelete: String
}

struct EditCountdownNameAction: CountdownActions {
    var idOfCountdownToEdit: String
    var newName: String
}
