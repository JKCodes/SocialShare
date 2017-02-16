//
//  RoundTextField.swift
//  SocialShare
//
//  Created by Joseph Kim on 2/14/17.
//  Copyright © 2017 Joseph Kim. All rights reserved.
//

import UIKit

@IBDesignable


class RoundTextField: UITextField {
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        didSet {
            layer.borderColor = borderColor?.cgColor
        }
    }
}
