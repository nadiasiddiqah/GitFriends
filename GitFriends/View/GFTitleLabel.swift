//
//  GFTitleLabel.swift
//  GitFriends
//
//  Created by Nadia Siddiqah on 8/2/22.
//

import Foundation
import UIKit

class GFTitleLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Custom initializer
    init(textAligment: NSTextAlignment, fontSize: CGFloat) {
        super.init(frame: .zero)
        textAlignment = textAligment
        font = UIFont.systemFont(ofSize: fontSize, weight: .bold)
        configure()
    }
    
    // Don't want to call configure outside of this file
    private func configure() {
        textColor = .label
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.9
        lineBreakMode = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints = false
    }
}
