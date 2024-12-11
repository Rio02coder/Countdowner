//
//  CountDownReducer.swift
//  Countdowner
//
//  Created by shmeelok chakraborty on 12/11/24.
//

func countdownReducer (_ countdownState: CountdownState, _ countdownAction: CountdownActions) -> CountdownState {
    var countdownState = countdownState
    
    switch countdownAction {
    case let countdownAction as AddCountdownAction:
        countdownState.countdowns.append(countdownAction.newCountdown)
    case let countdownAction as DeleteCountdownAction:
        countdownState.countdowns = countdownState.countdowns.filter({$0.id != countdownAction.idOfCountdownToDelete})
    case let countdownAction as EditCountdownNameAction:
        countdownState.countdowns = countdownState.countdowns.map { countdown in
            if countdown.id == countdownAction.idOfCountdownToEdit {
                var updatedCountdown = countdown
                updatedCountdown.name = countdownAction.newName
                return updatedCountdown
            }
            return countdown
        }
    default:
        break
    }
    return countdownState
}
