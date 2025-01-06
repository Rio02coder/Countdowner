//
//  UserErrors.swift
//  Countdowner
//
//  Created by shmeelok chakraborty on 12/22/24.
//

import Foundation

struct UserDoesNotExistError: Error, LocalizedError {
    var errorDescription: String? {
        return "User is not found"
    }
}


struct UnknownError: Error, LocalizedError {
    var errorDescription: String? {
        return "An unknown error occurred while getting the user"
    }
}


struct FieldDoesNotExistError: Error, LocalizedError {
    var fieldName: String
    var errorDescription: String? {
        return "Field \(fieldName) does not exist for the user."
    }
}
