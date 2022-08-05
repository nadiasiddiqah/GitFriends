//
//  GFAvatarIV.swift
//  GitFriends
//
//  Created by Nadia Siddiqah on 8/5/22.
//

import UIKit

class GFAvatarIV: UIImageView {
    
    // You can force unwrap if in your assets (not if you're downloading from internet)
    let placeholderImage = UIImage(named: "avatar-placeholder")!

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        // Change UIImageView's cornerRadius instead of the UIImage's cornerRadius
        layer.cornerRadius = 10
        clipsToBounds = true
        // Placeholder image
        image = placeholderImage
        translatesAutoresizingMaskIntoConstraints = false
    }
}
