//
//  NewPostViewModel.swift
//  LearningTask-12.3
//
//  Created by Italo cavalcanti on 30/01/23.
//

import Foundation

protocol NewPostViewModelDelegate: AnyObject {
    func newPostViewModel(_ viewModel: NewPostViewModel, anyAction action: Any?)
}

final class NewPostViewModel {
    
    weak var delegate: NewPostViewModelDelegate?
    var author: User?
    var message: String? {
        didSet {
            // listener para limite
        }
    }
    private let charactersLimitOfMessage = 280
    private var sendButtonIsEnabled = true
    
    func sendNewPost() {
        // enviar novo tweet
    }
    
}
