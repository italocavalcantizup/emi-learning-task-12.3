//
//  TuitrAPI.swift
//  LearningTask-12.3
//
//  Created by Italo cavalcanti on 27/01/23.
//

import Foundation

final class TuitrAPI {
    
    private var httpRequest: HTTPRequest
    
    init(httpRequest: HTTPRequest) {
        self.httpRequest = httpRequest
    }
    
    func getFeedPosts(completionHandler: @escaping (Result<[Post], NetworkError>) -> Void) {
        let endpoint = Endpoint(path: "/api/feed/")
        
        httpRequest.execute(endpoint: endpoint) { (result: Result<[Post], NetworkError>) in
            switch result {
            case .success(let posts):
                DispatchQueue.main.async {
                    completionHandler(.success(posts))
                }
            case .failure(let error):
                debugPrint(error)
                DispatchQueue.main.async {
                    completionHandler(.failure(error))
                }
            }
        }
    }
}


