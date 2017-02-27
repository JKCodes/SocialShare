//
//  MenuBar.swift
//  SocialShare
//
//  Created by Joseph Kim on 2/20/17.
//  Copyright © 2017 Joseph Kim. All rights reserved.
//

import UIKit

class MenuBar: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let cellId = "MenuCell"
    let imageNames = ["home", "trending", "subscriptions", "search", "account"]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Sets the background color of the menu bar
        backgroundColor = UIColor(red: 31/255.0, green: 102/255.0, blue: 158/255.0, alpha: 1.0)
        
        // CollectionView Setup
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MenuCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.scrollIndicatorInsets = UIEdgeInsetsMake(-50, 0, 0, 0)       // Bumps up the scroll bar so that the scroll bar clears the bottom nav bar
        collectionView.backgroundColor = .clear
        
        // Add collectionView to menu bar
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(collectionView)
        
        // Constraints for collectionView
        NSLayoutConstraint(item: collectionView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: collectionView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: collectionView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: collectionView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
        
        // Auto select the first menu item on load
        let selectIndexPath = IndexPath(item: 0, section: 0)
        collectionView.selectItem(at: selectIndexPath, animated: false, scrollPosition: [])
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width / 5, height: frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MenuCell
        
        cell.imageView.image = UIImage(named: imageNames[indexPath.item])?.withRenderingMode(.alwaysTemplate)
        cell.tintColor = UIColor(red: 54/255.0, green: 14/255.0, blue: 13/255.0, alpha: 1.0)
        
        return cell
    }
    
}
