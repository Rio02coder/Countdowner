//
//  Store.swift
//  Countdowner
//
//  Created by shmeelok chakraborty on 12/11/24.
//
import Foundation

class Store: ObservableObject {
    var reducer: ReduxReducer
    @Published var state: Appstate
    
    init() {
        self.reducer = rootReducer
        self.state = Appstate()
    }
    
    func dispatch(action: ReduxAction) {
        state = reducer(state , action) as! Appstate
    }
}


