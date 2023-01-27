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
    
    var tuitrAPI: TuitrAPI?
    
    convenience init(api tuitrAPI: TuitrAPI) {
        self.init()
        self.tuitrAPI = tuitrAPI
    }
    
    weak var delegate: HomeFeedViewModelDelegate?
    
    var feed: [Post] = [] {
        didSet {
            delegate?.homeFeedViewModel(self, postsLoaded: feed)
        }
    }
    
    func loadFeed() {
        guard let tuitrAPI = tuitrAPI else { return }
        tuitrAPI.getFeedPosts { [weak self] result in
            switch result {
            case .success(let posts):
                self?.feed = posts
            case .failure(let error):
                debugPrint(error)
            }
        }
    }
    
}
