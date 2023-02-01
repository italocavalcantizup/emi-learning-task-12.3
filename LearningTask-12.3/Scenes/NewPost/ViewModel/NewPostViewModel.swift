//
//  NewPostViewModel.swift
//  LearningTask-12.3
//
//  Created by Italo cavalcanti on 30/01/23.
//

import Foundation

protocol NewPostViewModelDelegate: AnyObject {
    func newPostViewModel(_ viewModel: NewPostViewModel, postCreated post: Post)
}

final class NewPostViewModel {
    
    weak var delegate: NewPostViewModelDelegate?
    var tuitrAPI: TuitrAPI?
    var author: User?
    var message: String?
    
    convenience init(author: User, tuitrAPI: TuitrAPI) {
        self.init()
        self.author = author
        self.tuitrAPI = tuitrAPI
    }
    
    private let charactersLimitOfMessage = 280
    private var sendButtonIsEnabled = true
    
    func sendNewPost(post: Post) {
        guard let tuitrAPI = tuitrAPI else { return }
        tuitrAPI.sendNewPost(newPost: post) { [weak self] result in
            switch result {
            case .success(let post):
                self?.delegate?.newPostViewModel(self!, postCreated: post)
            case .failure(let error):
                debugPrint(error)
            }
        }
    }
    
}
