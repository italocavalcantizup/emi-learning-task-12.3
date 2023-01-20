//
//  ViewCode.swift
//  LearningTask-12.3
//
//  Created by Italo cavalcanti on 20/01/23.
//

import Foundation

protocol ViewCode {
    func buildHierarchy()
    func setupConstraints()
}

extension ViewCode {
    func setupViews() {
        buildHierarchy()
        setupConstraints()
    }
}
