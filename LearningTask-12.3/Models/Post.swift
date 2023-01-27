//
//  Post.swift
//  LearningTask-12.3
//
//  Created by Italo cavalcanti on 20/01/23.
//

import Foundation

struct Post: Codable {
    let id: Int
    let createdAt: Date
    let textContent: String?
    let imagePath: String?
    let author: User
    let loves: Int
    let replies: Int
    let reposts: Int
}
