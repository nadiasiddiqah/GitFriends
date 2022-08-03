//
//  GFBodyLabel.swift
//  GitFriends
//
//  Created by Nadia Siddiqah on 8/2/22.
//

import Foundation
import UIKit

class GFBodyLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Custom initializer
    init(textAligment: NSTextAlignment) {
        super.init(frame: .zero)
        textAlignment = textAligment
        configure()
    }
    
    // Don't want to call configure outside of this file
    private func configure() {
        textColor = .secondaryLabel
        font = UIFont.preferredFont(forTextStyle: .body)
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.75
        lineBreakMode = .byWordWrapping
        translatesAutoresizingMaskIntoConstraints = false
    }
}
