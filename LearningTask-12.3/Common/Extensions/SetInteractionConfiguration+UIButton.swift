//
//  SetInteractionConfiguration+UIButton.swift
//  LearningTask-12.3
//
//  Created by Italo cavalcanti on 01/02/23.
//

import UIKit

extension UIButton {
    func setInteractionConfiguration(isEnabled: Bool, isInteractionEnabled: Bool, isHighlighted: Bool) {
        self.isEnabled = isEnabled
        self.isUserInteractionEnabled = isInteractionEnabled
        self.isHighlighted = isHighlighted
    }
}
