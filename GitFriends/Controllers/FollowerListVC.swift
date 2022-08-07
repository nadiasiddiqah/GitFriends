//
//  FollowersListVC.swift
//  GitFriends
//
//  Created by Nadia Siddiqah on 7/3/22.
//

import UIKit

class FollowerListVC: UIViewController {

    // enums = hashable by default
    enum Section {
        case main   // main section of collection view
    }
    
    
    var username: String!
    var followers: [Follower] = []
    
    
    var collectionView: UICollectionView!
    
    // diffable data source = good for collections that are highly dynamic / changing 
    // needs to have <sectionIdentifierType: itemIdentifierType> (that conform to hashable)
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // View did load has a list of commands, like a table of contents (no to little logic)
        configureVC()
        configureCollectionView()
        getFollowers()
        configureDataSource()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Make sure navigationBar isn't hidden for this screen, if it's hidden in previous screen
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    func configureVC() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    
    func configureCollectionView() {
        // Initialize collectionView, then add it to the view
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view))
        view.addSubview(collectionView)
        
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseId)
    }
    
    /* NetworkManager has strong ref to self (FollowerListVC) -> can cause memory leak
       So set weak self, so NetworkManager has weak ref to self
       When self is weak, it is optional */
    /* Unowned self = force unwraps self, which is dangerous */
    func getFollowers() {
        NetworkManager.shared.getFollowers(for: username, page: 1) { [weak self] result in
            
            guard let self = self else { return }
            
            switch result {
            case .success(let followers):
                self.followers = followers
                self.updateData()
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Bad Stuff Happened",
                                                message: error.rawValue,
                                                buttonTitle: "OK")
            }
        }
    }
    
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView,
                                                                           cellProvider: { collectionView, indexPath, follower in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseId, for: indexPath) as! FollowerCell
            cell.set(follower: follower)      // configure cell
            return cell
        })
    }
    
    // take snapshot of old data, takes snapshot of new data, and gets the diff to update the data
    func updateData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
}
