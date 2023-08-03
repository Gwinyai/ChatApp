//
//  UserModel.swift
//  ChatApp
//
//  Created by Gwinyai Nyatsoka on 3/8/2023.
//

import Foundation
import FirebaseDatabase

struct UserModel {
    
    static let reference = Database.database().reference().child("users")
    
    let id: String
    let username: String
    var avatarURL: URL?
    
    init?(snapshot: DataSnapshot) {
        guard let data = snapshot.value as? [String: Any] else { return nil }
        guard let username = data["username"] as? String else { return nil }
        guard let id = data["id"] as? String else { return nil }
        self.id = id
        self.username = username
        if let avatar = data["avatarURL"] as? String,
           let avatarURL = URL(string: avatar) {
            self.avatarURL = avatarURL
        }
    }
    
}
