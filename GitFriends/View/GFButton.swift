//
//  GFButton.swift
//  GitFriends
//
//  Created by Nadia Siddiqah on 7/3/22.
//

import UIKit

class GFButton: UIButton {
    
    // Override initializer for UIButton
    // If it's not a custom view, don't need to override
    override init(frame: CGRect) {
        // Call superview to inherit default UIButton's properties
        super.init(frame: frame)
        
        // Add customization code for custom button
    }
    
    // This is handles initializing UIButton via storyboards
    required init?(coder: NSCoder) {
        // Bc we're not using storyboards, use fatalError
        fatalError("init(coder:) has not been implemented")
    }
    
    // Create custom initializer for button
    init(backgroundColor: UIColor, title: String) {
        // You can initialize with zero, bc we will set the frame using autolayout
        super.init(frame: .zero)
        self.backgroundColor = backgroundColor
        setTitle(title, for: .normal)
        configure()
    }
    
    // Private = can't be called outside of this file
    // Can't be used about GFButton is initialized
    private func configure() {
        layer.cornerRadius = 10
        titleLabel?.textColor = .white
        // Create dynamic type 
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        
        // allows you to use autolayout when using programmatic UI
        translatesAutoresizingMaskIntoConstraints = false
    }
}
