//
//  FollowerCell.swift
//  GitFriends
//
//  Created by Nadia Siddiqah on 8/5/22.
//

import UIKit

class FollowerCell: UICollectionViewCell {
    // every FollowerCell will have same reuseId, can't be overriden
    static let reuseId = "FollowerCell"
    
    let avatarIV = GFAvatarIV(frame: .zero)
    let usernameLabel = GFTitleLabel(textAligment: .center, fontSize: 16)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(follower: Follower) {
        usernameLabel.text = follower.login
    }
    
    private func configure() {
        addSubview(avatarIV)
        addSubview(usernameLabel)
        
        let padding: CGFloat = 8
        
        NSLayoutConstraint.activate([
            avatarIV.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            avatarIV.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            avatarIV.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            avatarIV.heightAnchor.constraint(equalTo: avatarIV.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            usernameLabel.topAnchor.constraint(equalTo: avatarIV.bottomAnchor, constant: 12),
            usernameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            usernameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            usernameLabel.heightAnchor.constraint(equalToConstant: 20)
            // Font size is 16, so use height of 20 to add padding for the label
        ])
    }
}
