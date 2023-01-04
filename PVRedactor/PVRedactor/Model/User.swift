//
//  User.swift
//  PVRedactor
//
//  Created by Serhii Kopytchuk on 30.12.2022.
//

import SwiftUI
import FirebaseFirestoreSwift
import FirebaseAuth

struct User: Identifiable, Codable {

    @DocumentID var id = "\(UUID())"
    var gmail: String
    var name: String

    init(gmail: String, id: String, name: String) {
        self.gmail = gmail
        self.id = id
        self.name = name
    }

    init () {
        self.init(gmail: "", id: "", name: "")
    }

}
