//
//  RoomModel.swift
//  ChatApp
//
//  Created by Gwinyai Nyatsoka on 2/8/2023.
//

import Foundation
import FirebaseDatabase

struct RoomModel {
    
    static let reference = Database.database().reference().child("rooms")
    
    let title: String
    let createdAt: Date
    var avatarURL: URL?
    
    init?(data: (key: String, value: Any)) {
        let roomId = data.key
        guard let roomValue = data.value as? [String: Any] else {
            return nil
        }
        guard let title = roomValue["title"] as? String else {
            return nil
        }
        guard let createdAt = roomValue["createdAt"] as? Double else {
            return nil
        }
        let createdAtDate = Date(timeIntervalSince1970: createdAt)
        
        self.title = title
        self.createdAt = createdAtDate
        
        if let avatar = roomValue["avatarURL"] as? String,
           let avatarURL = URL(string: avatar) {
            self.avatarURL = avatarURL
        }
    }
    
}
