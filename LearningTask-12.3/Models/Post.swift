//
//  Post.swift
//  LearningTask-12.3
//
//  Created by Italo cavalcanti on 20/01/23.
//

import Foundation

class Post: Codable {
    let id: Int?
    let createdAt: Date
    let reposting: Post?
    let textContent: String?
    let imagePath: String?
    let author: User
    let loves: Int
    let replies: Int
    let reposts: Int
    
    init(id: Int?, createdAt: Date, reposting: Post?, textContent: String?, imagePath: String?, author: User, loves: Int, replies: Int, reposts: Int) {
        self.id = id
        self.createdAt = createdAt
        self.reposting = reposting
        self.textContent = textContent
        self.imagePath = imagePath
        self.author = author
        self.loves = loves
        self.replies = replies
        self.reposts = reposts
    }
}
