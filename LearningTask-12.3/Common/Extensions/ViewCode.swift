//
//  ViewCode.swift
//  LearningTask-12.3
//
//  Created by Italo cavalcanti on 20/01/23.
//

import Foundation
import UIKit

protocol ViewCode {
    func setupViews()
    func buildHierarchy()
    func setupConstraints()
}

extension UIView {
    func disableAutoResizing() {
        translatesAutoresizingMaskIntoConstraints = false
    }
}
