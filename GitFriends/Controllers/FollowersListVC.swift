//
//  FollowersListVC.swift
//  GitFriends
//
//  Created by Nadia Siddiqah on 7/3/22.
//

import UIKit

class FollowersListVC: UIViewController {

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
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createThreeColumnFlowLayout())
        view.addSubview(collectionView)
        
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseId)
    }
    
    // NO green (view specific code), can be refactored out 
    // custom flow layout for collection view
    func createThreeColumnFlowLayout() -> UICollectionViewFlowLayout {
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
    
    
    func getFollowers() {
        NetworkManager.shared.getFollowers(for: username, page: 1) { result in
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
