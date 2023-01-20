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
    
    var feed: [Post] = [] {
        didSet {
            delegate?.homeFeedViewModel(self, postsLoaded: feed)
        }
    }
    
}
