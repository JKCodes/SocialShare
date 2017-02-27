//
//  UIView+MasksAndConstraints.swift
//  SocialShare
//
//  Created by Joseph Kim on 2/25/17.
//  Copyright © 2017 Joseph Kim. All rights reserved.
//

import UIKit

extension UIView {
    func disableAutoMaskResizingIntoConstants(views: UIView...) {
        for (_, view) in views.enumerated() {
            view.translatesAutoresizingMaskIntoConstraints = false
        }
    }
}
