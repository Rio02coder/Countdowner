//
//  UserFunctions.swift
//  Countdowner
//
//  Created by shmeelok chakraborty on 12/22/24.
//

import Firebase
import FirebaseFirestore

/**
 Function to return the initial data of
 the user when creating them in the database.
 */
func getInitData(email: String?) -> [String: Any] {
    let emailString: String = (email != nil) ? email! : DEFAULT_EMAIL
    return [
        COUNTDOWN_FIELD_NAME: [],
        DISPLAY_EMAIL_FIELD_NAME: emailString
    ]
}

/**
 This function checks if a user exists in the db with the given user id.
 Params: uid: String - The user id
 */
func checkIfUserExists(uid: String) async -> Bool {
    let db = Firestore.firestore()
    do {
        let userDoc = try await db.collection(USERS_DOCUMENT_NAME).document(uid).getDocument()
        if userDoc.exists {
            return true
        } else {
            return false
        }
    } catch {
        return false
    }
}

/**
 This function creates a new user in the
 users collection of firebase with the UID and populate the default data with email.
 The email is optional. If no email is provided, a default email is added.
 It returns true if the creation was successful and false otherwise
 Params: uid: String - The user id
 */
func createUserWithUidAndEmail(uid: String, email: String?) async -> Bool {
    let db = Firestore.firestore()
    do {
        try await db.collection(USERS_DOCUMENT_NAME).document(uid).setData(getInitData(email: email))
        return true
    } catch {
        return false
    }
}


/**
 Function to create a user document, the user document does not already exist.
 This returns true in the case if the user already exists or a new user is created and
 false otherwise.
 
 Params: uid: String - The user id
 */
func createUserIfNotExists(uid: String, email: String?) async -> Bool {
    let doesUserExist = await checkIfUserExists(uid: uid)
    if doesUserExist {
        return true
    } else {
        return await createUserWithUidAndEmail(uid: uid, email: email)
    }
}


/**
 Function to get the value of a specific user field.
 Params: uid: String - The user id, fieldName: String - The user field
 */
func getUserField(_ uid: String, _ fieldName: String) async throws -> Any {
    let db = Firestore.firestore()
    
    do {
        let userDoc = try await db.collection("users").document(uid).getDocument()
        if userDoc.exists {
            if let result = userDoc.get(fieldName) {
                return result
            } else {
                throw FieldDoesNotExistError(fieldName: fieldName)
            }
        } else {
            throw UserDoesNotExistError()
        }
    } catch {
        throw UnknownError()
    }
}
