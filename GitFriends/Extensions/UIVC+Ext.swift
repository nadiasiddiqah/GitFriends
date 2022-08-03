//
//  UIVC+Ext.swift
//  GitFriends
//
//  Created by Nadia Siddiqah on 8/2/22.
//

import Foundation
import UIKit

// UIButton Extension = all buttons have the behavior
// UIButton Subclass = subset of UIButtons have that behavior

extension UIViewController {
    
    func presentGFAlertOnMainThread(title: String, message: String, buttonTitle: String) {
        // Quick way to push UI updates to the main thread
        // GCD = don't have to do a capture list / weak self 
        DispatchQueue.main.async {
            let alertVC = GFAlertVC(title: title, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve    // alert fades in
            self.present(alertVC, animated: true)
        }
    }
}
