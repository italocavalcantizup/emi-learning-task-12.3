//
//  Result.swift
//  LearningTask-12.3
//
//  Created by Italo cavalcanti on 27/01/23.
//

import Foundation

extension Result {
    init(value: Success?, error: Failure?) {
        if let error = error {
            self = .failure(error)
            return
        }
        
        if let value = value {
            self = .success(value)
            return
        }
        
        fatalError("Could not possible to create a valid result")
    }
}
