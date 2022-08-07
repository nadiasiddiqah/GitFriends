//
//  UIHelper.swift
//  GitFriends
//
//  Created by Nadia Siddiqah on 8/6/22.
//

import UIKit

struct UIHelper {
    // NO green (view specific code), can be refactored out
    // custom flow layout for collection view
    static func createThreeColumnFlowLayout(in view: UIView) -> UICollectionViewFlowLayout {
        // Figure out total available width to get width of each cell
        let width = view.bounds.width  // total width of the screen
        let padding: CGFloat = 12
        let minItemSpacing: CGFloat = 10
        let availableWidth = width - (padding * 2) - (minItemSpacing * 2)
        let cellWidth = availableWidth / 3
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: cellWidth, height: cellWidth + 40)   // 40 gives extra space for label
        
        return flowLayout
    }
}
