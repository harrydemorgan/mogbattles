//
//  User.swift
//  MogBattle
//
//  Created by Harry Morgan on 25/01/2024.
//

import Foundation

struct User: Identifiable, Codable {
    let id: String
    let username: String
    let email: String
}

extension User {
    static var MOCK_USER = User(id: NSUUID().uuidString, username: "test", email: "test@gmail.com")
}
