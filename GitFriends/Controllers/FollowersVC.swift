//
//  FollowersVC.swift
//  GitFriends
//
//  Created by Nadia Siddiqah on 7/3/22.
//

import UIKit

class FollowersVC: UIViewController {

    var username: String!
    
//    init(username: String) {
//        self.username = username
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        // Make sure navigationBar isn't hidden for this screen, if it's hidden in previous screen
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        

    }

}
