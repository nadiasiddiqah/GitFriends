//
//  FollowersListVC.swift
//  GitFriends
//
//  Created by Nadia Siddiqah on 7/3/22.
//

import UIKit

class FollowersListVC: UIViewController {

    var username: String!
    
//    init(username: String) {
//        self.username = username
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        
        NetworkManager.shared.getFollowers(for: username, page: 1) { (followers, error) in
            guard let followers = followers else {
                self.presentGFAlertOnMainThread(title: "Bad Stuff Happened",
                                                message: error!,
                                                buttonTitle: "OK")
                return
            }
            
            print("followers.count = \(followers.count)")
            print(followers)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Make sure navigationBar isn't hidden for this screen, if it's hidden in previous screen
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

}
