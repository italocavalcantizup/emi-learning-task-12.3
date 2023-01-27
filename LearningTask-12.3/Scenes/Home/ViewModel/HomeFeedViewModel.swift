//
//  HomeFeedViewModel.swift
//  LearningTask-12.3
//
//  Created by Italo cavalcanti on 20/01/23.
//

import Foundation

protocol HomeFeedViewModelDelegate: AnyObject {
    func homeFeedViewModel(_ viewModel: HomeFeedViewModel, postsLoaded: [Post])
}

final class HomeFeedViewModel {
    
    weak var delegate: HomeFeedViewModelDelegate?
    
    var feed: [Post] = [
        Post(author: User(id: nil,
                          fullName: "Italo Cavalcanti",
                          username: "italocavalcanti",
                          profilePictureURL: URL(string: "https://github.com/italocavalcantizup.png")!),
             createdAt: "1d",
             id: Int(Date.timeIntervalBetween1970AndReferenceDate),
             imagePath: "Avatar",
             loves: 2,
             replies: 0,
             reposts: 0,
             textContent: "Meu tweet aqui. Meu tweet aqui. Meu tweet aqui. Meu tweet aqui."),
        Post(author: User(id: nil,
                          fullName: "Italo Cavalcanti",
                          username: "italocavalcanti",
                          profilePictureURL: URL(string: "https://github.com/italocavalcantizup.png")!),
             createdAt: "1d",
             id: Int(Date.timeIntervalBetween1970AndReferenceDate),
             imagePath: "Avatar",
             loves: 2,
             replies: 0,
             reposts: 0,
             textContent: "Meu tweet aqui. Meu tweet aqui. Meu tweet aqui. Meu tweet aqui."),
    ] {
        didSet {
            delegate?.homeFeedViewModel(self, postsLoaded: feed)
        }
    }
    
}
