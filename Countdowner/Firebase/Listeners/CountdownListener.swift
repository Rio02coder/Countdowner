//
//  CountdownListener.swift
//  Countdowner
//
//  Created by shmeelok chakraborty on 12/22/24.
//

import SwiftUI
import Firebase
import FirebaseFirestore


class CountdownListener: ObservableObject {
    @Published var countdowns: [Countdown] = []
    private var listener: ListenerRegistration? = nil
    
    func adaptFirebaseResponse(_ firebaseResponse: Any?) -> [Countdown] {
        guard let countdownsArray = firebaseResponse as? [[String: Any]] else {
            return []
        }
        
        return countdownsArray.compactMap { countdown in
            guard let name = countdown["name"] as? String,
                  let date = (countdown["date"] as? Timestamp)?.dateValue() else {
                return nil
            }
            
            let description = countdown["description"] as? String
            return Countdown(name: name, description: description, date: date, id: countdown["id"] as? String ?? UUID().uuidString)
        }
    }
    
    func startListening(_ uid: String) {
        let db = Firestore.firestore()
        print("Listener activated")
        listener = db.collection(USERS_DOCUMENT_NAME).document(uid)
            .addSnapshotListener { [weak self] snapshot, error in
                guard let self = self else { return }
                if let error = error {
                    print("Error listening for field changes: \(error.localizedDescription)")
                    return
                }
                if let snapshot = snapshot, snapshot.exists {
                    countdowns = adaptFirebaseResponse(snapshot.get(COUNTDOWN_FIELD_NAME))
                } else {
                    print("Document does not exist")
                }
            }
    }
    
    func stopListening() {
        listener?.remove()
        listener = nil
    }
}

