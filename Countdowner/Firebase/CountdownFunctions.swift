//
//  CountdownFunctions.swift
//  Countdowner
//
//  Created by shmeelok chakraborty on 12/22/24.
//

import Firebase
import FirebaseFirestore

//func addNewCountdown(_ uid: String, countdown: Countdown) {
//    var db = Firestore.firestore()
//    var userDocument = db.collection(USERS_DOCUMENT_NAME).document().updateData([
//        COUNTDOWN_FIELD_NAME:
//    ])
//}

func addNewCountdown(_ uid: String, countdown: Countdown) async throws {
    let db = Firestore.firestore()
    let userDocument = db.collection(USERS_DOCUMENT_NAME).document(uid)

    // Prepare the data to be added
    let countdownData: [String: Any] = [
        "id": countdown.id,
        "name": countdown.name,
        "description": countdown.description ?? "",
        "date": Timestamp(date: countdown.date)
    ]

    do {
        try await userDocument.updateData([
            COUNTDOWN_FIELD_NAME: FieldValue.arrayUnion([countdownData])
        ])
        print("Countdown added successfully!")
    } catch {
        print("Error adding countdown: \(error.localizedDescription)")
        throw error
    }
}


func updateCountdown(_ uid: String, oldCountdown: Countdown, updatedCountdown: Countdown) async throws {
    let db = Firestore.firestore()
    let userDocument = db.collection(USERS_DOCUMENT_NAME).document(uid)

    do {
        try await userDocument.updateData([
            COUNTDOWN_FIELD_NAME: FieldValue.arrayRemove([oldCountdown])
        ])
        try await userDocument.updateData([
            COUNTDOWN_FIELD_NAME: FieldValue.arrayUnion([updatedCountdown])
        ])
        print("Countdown updated successfully!")
    } catch {
        print("Error updating countdown: \(error.localizedDescription)")
        throw error
    }
}


func deleteCountdown(_ uid: String, countdownToDelete: Countdown) async throws {
    let db = Firestore.firestore()
    let userDocument = db.collection(USERS_DOCUMENT_NAME).document(uid)
    let countdownData: [String: Any] = [
        "id": countdownToDelete.id,
        "name": countdownToDelete.name,
        "description": countdownToDelete.description ?? "",
        "date": Timestamp(date: countdownToDelete.date)
    ]
    do {
        try await userDocument.updateData([
            COUNTDOWN_FIELD_NAME: FieldValue.arrayRemove([countdownData])
        ])
        print("Countdown deleted successfully!")
    } catch {
        print("Error deleteing countdown: \(error.localizedDescription)")
        throw error
    }
}
