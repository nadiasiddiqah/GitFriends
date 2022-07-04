//
//  GFTextField.swift
//  GitFriends
//
//  Created by Nadia Siddiqah on 7/3/22.
//

import UIKit

class GFTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        
        layer.cornerRadius = 10
        layer.borderWidth = 2
        layer.borderColor = UIColor.systemGray4.cgColor  // when dealing with layer, use CGColor
        
        textColor = .label  // black in light mode, white in black mode
        tintColor = .label  // color of blinking cursor
        textAlignment = .center
        font = UIFont.preferredFont(forTextStyle: .title2)
        adjustsFontSizeToFitWidth = true // text shrinks for long usernames
        minimumFontSize = 12 // text can't shrink past minFontSize
        
        backgroundColor = .tertiarySystemBackground
        autocorrectionType = .no
        
        placeholder = "Enter a username"
    }
}
