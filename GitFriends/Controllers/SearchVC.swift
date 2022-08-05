//
//  SearchVC.swift
//  GitFriends
//
//  Created by Nadia Siddiqah on 6/9/22.
//

import Foundation
import UIKit

class SearchVC: UIViewController {
    
    let logoImageView = UIImageView()
    let usernameTextField = GFTextField()
    let ctaButton = GFButton(backgroundColor: .systemGreen, title: "Get Followers")
    
    
    // Computed property
    var isUsernameEntered: Bool {
        return !usernameTextField.text!.isEmpty
    }

    
    // Get called once when view is first loaded in memory
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // light mode = white, dark mode = black
        // if you set it to .white, it would be white in light+dark mode
        view.backgroundColor = .systemBackground
        configureLogoImageView()
        configureTextField()
        configureCTAButton()
        dismissKeyboardTapGesture()
    }
    
    
    // Gets called everytime view appears (if you go back and forth between this + another screen)
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    
    func dismissKeyboardTapGesture() {
        // endEditing function causes view (or its embedded text field) to resign first responder status
        // #selector = remnants of obj-c, use @objc func to expose function to obj-c
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tap)
    }
    
    
    // Push = add VC on stack, Pop = remove VC off of stack
    @objc func pushFollowerListVC() {
        // Line in the sand, can't get past if condition is not met
        guard isUsernameEntered else {
            presentGFAlertOnMainThread(title: "Empty username",
                                       message: "Please enter a username. We need to know who to look for 😀.",
                                       buttonTitle: "OK")
            return
        }
            
        let vc = FollowersListVC()
        
        // Pass username to the next screen
        vc.username = usernameTextField.text
        
        // Set the title of vc 
        vc.title = usernameTextField.text
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func configureLogoImageView() {
        view.addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = UIImage(named: "gh-logo")!   // stringly-typed, should create constant to prevent crashes if mistyped
        
        // Set 4 constraints per view (H, W, X, Y) - (2 or 7 is too little/too much)
        NSLayoutConstraint.activate([
            // topAnchor = top edge of the view (Y coord)
            // safeAreaLayoutGuide = avoids navigation bar and other objects at the top of the superview
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            
            // centerXAnchor = horizontal center of the view (X coord)
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            // Best to set images to squares
            // Set to 200 bc the smallest iPhone is 320px
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            logoImageView.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    
    func configureTextField() {
        view.addSubview(usernameTextField)
        
        // Set textField's delegate to SearchVC
        // So now, the delegate listens for specific action from SearchVC to respond
        usernameTextField.delegate = self
        
        NSLayoutConstraint.activate([
            // Pinned to the bottom of logoImageView
            usernameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48),
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            // Trailing constant needs to be negative
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            // Based on UI guidelines, touch target should be at least 44px height
            usernameTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    
    func configureCTAButton() {
        view.addSubview(ctaButton)
        
        // Add target to button so it has a function
        // touchUpInside = normal button tap (others are for edge cases)
        ctaButton.addTarget(self, action: #selector(pushFollowerListVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            // Pinned to the bottom of the superview, use negative constant for bottomAnchor
            ctaButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            ctaButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            ctaButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            ctaButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}


// In order for SarchVC to access textField's text, it needs to conform to UITextFieldDelegate
// Delegate = sits back and listens to the SearchVC, so our action is tapping a return key
// When delegate detects that return key is tapped, it saves the textField's text
extension SearchVC: UITextFieldDelegate {
    
    // Responds when delegate detects that return button is tapped 
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushFollowerListVC()
        return true
    }
}
