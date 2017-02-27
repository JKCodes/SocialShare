//
//  MenuCell.swift
//  SocialShare
//
//  Created by Joseph Kim on 2/20/17.
//  Copyright © 2017 Joseph Kim. All rights reserved.
//

import UIKit

class MenuCell: UICollectionViewCell {
    
    let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // While the cell is helddown
    override var isHighlighted: Bool {
        didSet {
            imageView.tintColor = isHighlighted ? .white : UIColor(red: 54/255.0, green: 14/255.0, blue: 13/255.0, alpha: 1.0)
        }
    }
    
    // After user has chosen a cell - i.e. the finger is off the screen
    override var isSelected: Bool {
        didSet {
            imageView.tintColor = isSelected ? .white : UIColor(red: 54/255.0, green: 14/255.0, blue: 13/255.0, alpha: 1.0)
        }
    }
    
    func setupViews() {
        imageView.image = UIImage(named: "home")?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = UIColor(red: 54/255.0, green: 14/255.0, blue: 13/255.0, alpha: 1.0)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: imageView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: imageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: imageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 28.0),
            NSLayoutConstraint(item: imageView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 28.0)
            ])
    
        backgroundColor = .clear
    }
}
