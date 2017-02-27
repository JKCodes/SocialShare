//
//  PostCell.swift
//  SocialShare
//
//  Created by Joseph Kim on 2/20/17.
//  Copyright © 2017 Joseph Kim. All rights reserved.
//

import UIKit
import Firebase

class PostCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        setupCell()
        setupSubviews()
    }

    // Default values for some constants
    private static let standardOffset: CGFloat = 8.0    // Default offset for elements
    private static let standardHeight: CGFloat = 30.0   // Default Height for elements
    private static let standardFont = UIFont(name: "Avenir Next", size: 16) // Default Font
    private static let contentHeight: CGFloat = 150.0
    
    // mainSubview
    let mainSubview: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4).cgColor
        view.layer.borderWidth = 0.5
        view.layer.shadowColor = UIColor(red: 120/255.0, green: 120/255.0, blue: 120/255.0, alpha: 0.6).cgColor
        view.layer.shadowOpacity = 0.8
        view.layer.shadowRadius = 5.0
        view.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        view.layer.cornerRadius = 2.0
        return view
    }()
    
    // profileImgView
    let profileImgView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .blue
        imageView.layer.cornerRadius = standardHeight / 2
        return imageView
    }()
    
    // usernameLbl
    let usernameLbl: UILabel = {
        let label = UILabel()
        label.text = "Temporary Name"
        label.font = standardFont
        return label
    }()
    
    // timeLbl
    let timeLbl: UILabel = {
        let label = UILabel()
        label.text = "3 hours ago"
        label.font = standardFont?.withSize(13.0)
        return label
    }()
    
    // contentImgView
    let contentImgView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .red
        return imageView
    }()
    
    // captionLbl
    let captionLbl: UILabel = {
        let label = UILabel()
        label.text = "Look at the photo above.  I took that photo myself.  I am very proud of myself."
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.font = standardFont?.withSize(13.0)
        return label
    }()
    
    // likesImgView
    let likesImgView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "empty-heart")
        return imageView
    }()
    
    // commentImageView
    let commentImgView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "comment")
        return imageView
    }()
    
    // likesLbl
    let likesLbl: UILabel = {
        let label = UILabel()
        label.text = "Likes: 1233"
        label.font = standardFont
        return label
    }()
    
    // separatorView
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 222/255.0, green: 222/255.0, blue: 222/255.0, alpha: 0.8)
        return view
    }()
    
    func setupCell() {
        backgroundColor = .clear
    }
    
    func setupSubviews() {
        
        // Removal of autosizing mask into constraints
        disableAutoMaskResizingIntoConstants(views: mainSubview, profileImgView, usernameLbl, timeLbl,
                                             contentImgView, captionLbl, likesImgView, commentImgView,
                                             likesLbl, separatorView)
        
        // Addition of subviews into the main view
        addSubview(mainSubview)
        addSubview(profileImgView)
        addSubview(usernameLbl)
        addSubview(timeLbl)
        addSubview(contentImgView)
        addSubview(captionLbl)
        addSubview(likesImgView)
        addSubview(commentImgView)
        addSubview(likesLbl)
        addSubview(separatorView)
        
        // Constraints using the traditional NSLayoutConstraint
        NSLayoutConstraint(item: mainSubview, attribute: .left, relatedBy: .equal, toItem: self, attribute: .leftMargin, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint(item: mainSubview, attribute: .right, relatedBy: .equal, toItem: self, attribute: .rightMargin, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint(item: mainSubview, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: PostCell.standardOffset).isActive = true
        NSLayoutConstraint(item: mainSubview, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: PostCell.standardOffset).isActive = true
        NSLayoutConstraint(item: profileImgView, attribute: .top, relatedBy: .equal, toItem: mainSubview, attribute: .top, multiplier: 1.0, constant: PostCell.standardOffset).isActive = true
        NSLayoutConstraint(item: profileImgView, attribute: .left, relatedBy: .equal, toItem: mainSubview, attribute: .leftMargin, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: profileImgView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: PostCell.standardHeight).isActive = true
        NSLayoutConstraint(item: profileImgView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: PostCell.standardHeight).isActive = true
        NSLayoutConstraint(item: usernameLbl, attribute: .left, relatedBy: .equal, toItem: profileImgView, attribute: .right, multiplier: 1.0, constant: PostCell.standardOffset).isActive = true
        NSLayoutConstraint(item: usernameLbl, attribute: .top, relatedBy: .equal, toItem: mainSubview, attribute: .top, multiplier: 1.0, constant: PostCell.standardOffset).isActive = true
        NSLayoutConstraint(item: usernameLbl, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: PostCell.standardHeight).isActive = true
        NSLayoutConstraint(item: timeLbl, attribute: .top, relatedBy: .equal, toItem: mainSubview, attribute: .top, multiplier: 1.0, constant: PostCell.standardOffset).isActive = true
        NSLayoutConstraint(item: timeLbl, attribute: .right, relatedBy: .equal, toItem: mainSubview, attribute: .rightMargin, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: timeLbl, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: PostCell.standardHeight).isActive = true

        // Some Constraints using the newer anchor form
        contentImgView.leftAnchor.constraint(equalTo: mainSubview.leftAnchor, constant: PostCell.standardOffset).isActive = true
        contentImgView.rightAnchor.constraint(equalTo: mainSubview.rightAnchor, constant: -(PostCell.standardOffset)).isActive = true
        contentImgView.topAnchor.constraint(equalTo: profileImgView.bottomAnchor, constant: PostCell.standardOffset).isActive = true
        contentImgView.heightAnchor.constraint(equalToConstant: PostCell.contentHeight).isActive = true
        captionLbl.topAnchor.constraint(equalTo: contentImgView.bottomAnchor, constant: PostCell.standardOffset * 2).isActive = true    // Twice the standardOffset
        captionLbl.leftAnchor.constraint(equalTo: mainSubview.leftAnchor, constant: PostCell.standardOffset * 2).isActive = true        // standardOffset * 2 from left
        captionLbl.rightAnchor.constraint(equalTo: mainSubview.rightAnchor, constant: -(PostCell.standardOffset * 2)).isActive = true   // standardOffset * 2 from right
        likesImgView.leftAnchor.constraint(equalTo: mainSubview.leftAnchor, constant: PostCell.standardOffset * 3).isActive = true      // Triple the standardOffset
        likesImgView.topAnchor.constraint(equalTo: captionLbl.bottomAnchor, constant: PostCell.standardOffset).isActive = true
        likesImgView.widthAnchor.constraint(equalToConstant: PostCell.standardHeight).isActive = true
        likesImgView.heightAnchor.constraint(equalToConstant: PostCell.standardHeight).isActive = true
        commentImgView.leftAnchor.constraint(equalTo: likesImgView.rightAnchor, constant: PostCell.standardOffset * 3).isActive = true      // Triple the standardOffset
        commentImgView.topAnchor.constraint(equalTo: captionLbl.bottomAnchor, constant: PostCell.standardOffset).isActive = true
        commentImgView.widthAnchor.constraint(equalToConstant: PostCell.standardHeight).isActive = true
        commentImgView.heightAnchor.constraint(equalToConstant: PostCell.standardHeight).isActive = true
        likesLbl.topAnchor.constraint(equalTo: captionLbl.bottomAnchor, constant: PostCell.standardOffset).isActive = true
        likesLbl.rightAnchor.constraint(equalTo: mainSubview.rightAnchor, constant: -(PostCell.standardOffset)).isActive = true
        likesLbl.heightAnchor.constraint(equalToConstant: PostCell.standardHeight).isActive = true
        separatorView.leftAnchor.constraint(equalTo: mainSubview.leftAnchor, constant: PostCell.standardOffset * 2).isActive = true
        separatorView.rightAnchor.constraint(equalTo: mainSubview.rightAnchor, constant: -(PostCell.standardOffset * 2)).isActive = true
        separatorView.topAnchor.constraint(equalTo: likesImgView.bottomAnchor, constant: PostCell.standardOffset).isActive = true
        separatorView.heightAnchor.constraint(equalToConstant: 1.0).isActive = true
        
    }
    
    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
        layoutIfNeeded()
        var size = super.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: horizontalFittingPriority, verticalFittingPriority: verticalFittingPriority)
        
        size.height = profileImgView.frame.size.height + contentImgView.frame.size.height + captionLbl.frame.size.height + PostCell.standardOffset * 15
        
        
        return size

    }

}
