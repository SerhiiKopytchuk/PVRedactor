//
//  AuthViewModel.swift
//  PVRedactor
//
//  Created by Serhii Kopytchuk on 30.12.2022.
//

import SwiftUI
import Foundation
import FirebaseAuth
import FirebaseFirestoreSwift
import FirebaseFirestore

class AuthViewModel: ObservableObject {

    // MARK: - variables

    @Published var isSignedIn = false
    @Published var isShowLoader = false
    @Published var currentUser: User = User()

    @Published var alertText: String?

    let auth = Auth.auth()
    let firebaseManager = FirestorePathManager.shared

    var userUID: String {
        self.auth.currentUser?.uid ?? "no UID"
    }

    init() {
        isSignedIn = Auth.auth().currentUser != nil
    }

    // MARK: - functions

    func getCurrentUser() {
        DispatchQueue.global(qos: .userInteractive).async {  [weak self] in
            self?.firebaseManager.getUserDocumentReference(for: self?.userUID)
                .getDocument(as: User.self) { result in
                    DispatchQueue.main.async {
                        switch result {
                        case .success(let user):
                            self?.currentUser = user
                        case .failure(let error):
                            print(error)
                        }
                    }
                }
        }
    }

    func updateCurrentUser(userId: String) {
        DispatchQueue.global(qos: .userInteractive).async { [weak self] in
            self?.firebaseManager.getUserDocumentReference(for: userId)
                .addSnapshotListener { document, error in

                    guard let document = document, error == nil else {
                        print("failed to add update current user: \(error?.localizedDescription ?? "")")
                        return
                    }

                    DispatchQueue.main.async {
                        if let userLocal = try? document.data(as: User.self) {
                            self?.currentUser = userLocal
                        }
                    }
                }
        }
    }

    // MARK: - authorization

    fileprivate func doesUserHaveFirebaseAccount(completion: @escaping (Bool) -> Void ) {
        firebaseManager.getUserDocumentReference(for: userUID)
            .getDocument(as: User.self) { result in
                switch result {
                case .success:
                    completion(true)
                case .failure:
                    completion(false)
                }
            }
    }

    func signUp(username: String, email: String, password: String) {
        showLoader()
        DispatchQueue.global(qos: .userInteractive).async { [weak self] in
            self?.auth.createUser(withEmail: email, password: password) { result, error in

                guard let _ = result, error == nil else {
                    self?.showAlert(text: error?.localizedDescription ?? "failed to sign up")
                    return
                }

                DispatchQueue.main.async {
                        self?.createFirebaseUser(name: username, gmail: self?.auth.currentUser?.email ?? "")
                        self?.setUserSignedIn()
                        self?.hideLoader()
                }
            }
        }
    }

    func signIn(email: String, password: String ) {
        showLoader()
        DispatchQueue.global(qos: .userInteractive).async { [weak self] in
            self?.auth.signIn(withEmail: email, password: password) { result, error in

                guard let _ = result, error == nil else {
                    self?.showAlert(text: error?.localizedDescription)
                    return
                }

                DispatchQueue.main.async {
                    self?.hideLoader()
                    self?.setUserSignedIn()
                }
            }
        }
    }

    func signOut() {
        do {
            try auth.signOut()
        } catch {
            print("failed to sign out")
            return
        }

        self.isSignedIn = false
    }

    fileprivate func setUserSignedIn() {
        self.getCurrentUser()
        withAnimation(.easeOut(duration: 0.4)) {
            self.isSignedIn = true
        }
    }

    fileprivate func showLoader() {
        withAnimation(.easeOut(duration: 0.3)) {
            isShowLoader = true
        }
    }

    fileprivate func hideLoader() {
        withAnimation(.easeOut(duration: 0.3)) {
            isShowLoader = false
        }
    }

    fileprivate func showAlert(text: String?) {
        self.alertText = text ?? "error"
    }

    fileprivate func createFirebaseUser(name: String, gmail: String) {
        let newUser = User(gmail: gmail,
                           id: Auth.auth().currentUser?.uid ?? "\(UUID())",
                           name: name)
        do {
            try firebaseManager.getUserDocumentReference(for: newUser.id)
                .setData(from: newUser)
        } catch {
            print("error adding message to FireStore:: \(error)")
        }
    }
}
