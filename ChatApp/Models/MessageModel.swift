//
//  MessageModel.swift
//  ChatApp
//
//  Created by Gwinyai Nyatsoka on 6/8/2023.
//

import Foundation

struct MessageModel {
    let username: String
    let text: String
    let createdAt: Date
    var avatar: URL?
    var displayDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter.string(from: createdAt)
    }
    
}
