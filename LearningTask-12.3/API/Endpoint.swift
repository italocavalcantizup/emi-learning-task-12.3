//
//  Endpoint.swift
//  LearningTask-12.3
//
//  Created by Italo cavalcanti on 27/01/23.
//

import Foundation

struct Endpoint {
    typealias QueryParams = [String: String]
    
    let path: String
    private var queryParams: [URLQueryItem]? = nil
    
    init(path: String, queryParams: QueryParams? = nil) {
        self.path = path
        
        if let queryParams = queryParams {
            self.queryParams = queryParams.map { URLQueryItem(name: $0, value: $1)}
        }
    }
    
    var uri: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "tuitr-api.herokuapp.com"
        components.path = self.path
        components.queryItems = self.queryParams
        return components.url
    }
}
