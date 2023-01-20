//
//  Author.swift
//  LearningTask-12.3
//
//  Created by rafael.rollo on 07/12/2022.
//

import Foundation

struct User: Codable {
    let id: Int?
    let fullName: String
    let username: String
    let profilePictureURL: URL
    
    enum CodingKeys: String, CodingKey {
        case id, fullName, username
        case profilePictureURL = "profilePicturePath"
    }
}
