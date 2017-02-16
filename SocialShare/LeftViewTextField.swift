//
//  LeftViewTextField.swift
//  SocialShare
//
//  Created by Joseph Kim on 2/15/17.
//  Copyright © 2017 Joseph Kim. All rights reserved.
//

import UIKit

class LeftViewTextField: RoundTextField {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setImage(with: "settings")
    }
 
    
    /// Inserts a UIView in the leftview section of the textfield.  UIView contains an imageView which is set according to value of imageName
    func setImage(with imageName: String) {

        let heightOffset: CGFloat = 10.0
        let tempView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: frame.height, height: frame.height))
        let imageView = UIImageView(image: UIImage(named: imageName))
        
        // Prepare to set constraints on imageView
        imageView.translatesAutoresizingMaskIntoConstraints = false
        tempView.addSubview(imageView)
        
        // Sets height, width, x, and y constraints
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: imageView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant : frame.height - heightOffset),
            NSLayoutConstraint(item: imageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant : frame.height - heightOffset),
            NSLayoutConstraint(item: imageView, attribute: .centerX, relatedBy: .equal, toItem: tempView, attribute: .centerX, multiplier: 1.0, constant : heightOffset / 2),
            NSLayoutConstraint(item: imageView, attribute: .centerY, relatedBy: .equal, toItem: tempView, attribute: .centerY, multiplier: 1.0, constant : 0)
            ])

        // Finally sets the leftView mode to appear
        leftViewMode = .always
        leftView = tempView
    }
    
}
