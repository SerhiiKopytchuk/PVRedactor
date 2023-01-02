//
//  FirestorePathManager.swift
//  PVRedactor
//
//  Created by Serhii Kopytchuk on 30.12.2022.
//

import SwiftUI
import FirebaseFirestore
import FirebaseAuth
import Firebase

class FirestorePathManager {
    static let shared = FirestorePathManager()
    private init() {}

    private let dataBase = Firestore.firestore()

    private enum FirestoreNavigation: String {
        case users
    }

    // MARK: - for authViewModel

    var usersCollection: CollectionReference {
        dataBase.collection(FirestoreNavigation.users.rawValue)
    }

    func getUserDocumentReference(for userId: String?) -> DocumentReference {
        usersCollection
            .document(userId ?? "userId")
    }

}
