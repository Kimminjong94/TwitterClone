//
//  ProfileController.swift
//  TwitterClone
//
//  Created by 김민종 on 2023/03/03.
//

import UIKit

private let reuseIdentifier = "TweetCell"
private let headerIdentifier = "ProfileHeader"

class ProfileController: UICollectionViewController {
    
    //MARK: - Properties
    
    private var user: User
    
    
    private var tweets = [Tweet]() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    //MARK: - Lifecycle
    
    init(user: User) {
        self.user = user
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        fetchTweets()
        checkIfUserIsFollowed()
        fetchUserStats()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.isHidden = true
        
    }
    
    //MARK: - API
    
    func fetchTweets() {
        TweetService.shared.fetchTweets(forUser: user) { tweets in
            print("wTWEETS ARE\(tweets)o")
            self.tweets = tweets
        }
    }
    
    
    func checkIfUserIsFollowed() {
        UserService.shared.checkIfUserIsFollowed(uid: user.uid) { isFollowed in
            self.user.isFollowed = isFollowed
            self.collectionView.reloadData()
        }
    }
    
    func fetchUserStats() {
        UserService.shared.fetchUserStats(uid: user.uid) { stats in
            
            self.user.stats = stats
            self.collectionView.reloadData()
            
        }
        
        
        
        
    }
    
    //MARK: - Helpers
    
    func configureCollectionView() {
        collectionView.backgroundColor = .white
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.register(TweetCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.register(ProfileHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerIdentifier)
    }
}

//MARK: - UICollectionviewDataSource

extension ProfileController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tweets.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! TweetCell
        cell.tweet = tweets[indexPath.row]
        return cell
        
    }
}

//MARK: - UICollectionviewDelegate

extension ProfileController {
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerIdentifier, for: indexPath) as! ProfileHeader
        
        header.user = user
        header.delegate = self
        return header
    }
}

//MARK: - UICollectionviiewDelegateFlow

extension ProfileController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 350)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 120)
    }
    
}

extension ProfileController: ProfileHeaderDelegate {
    func handleEditProfileFollow(_ header: ProfileHeader) {
                
        guard !user.isCurrentUser else { return print("Show profile controller")}
        
        if user.isFollowed {
            UserService.shared.unFollowUser(uid: user.uid) { (err, ref) in
                self.user.isFollowed = false
                self.collectionView.reloadData()
            }
            
        } else {
            UserService.shared.followUser(uid: user.uid) { (ref,err) in
                self.user.isFollowed = true
                self.collectionView.reloadData()
            }
        }
    }
    
    func handelDismissal() {
        navigationController?.popViewController(animated: true)
    }
}
