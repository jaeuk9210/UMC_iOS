//
//  ProfileViewController.swift
//  Codebase
//
//  Created by 정재욱 on 11/12/23.
//

import UIKit
import Combine

import SnapKit

class ProfileViewController: UIViewController, UIGestureRecognizerDelegate, UIScrollViewDelegate {

    private var refreshControl = UIRefreshControl()
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    var subscriptions = Set<AnyCancellable>()
    
    var userPosts: [UserFeedUserPost]? {
        didSet {
            self.profileCollectionView.reloadData()
        }
    }
    
    var userInfo: UserFeedUserInfo? {
        didSet {
            self.profileCollectionView.reloadData()
        }
    }
    
    var deletedIndex: Int?

    //MARK: - Properties
    private lazy var nicknameLabel: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem()
        barButtonItem.title = ""
        barButtonItem.tintColor = .black
        barButtonItem.target = self
        return barButtonItem
    } ()

    private lazy var postButton: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem()
        barButtonItem.tintColor = .black
        barButtonItem.image = UIImage(systemName: "plus.app")
        barButtonItem.target = self
        return barButtonItem
    } ()

    private lazy var moreButton: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem()
        barButtonItem.tintColor = .black
        barButtonItem.image = UIImage(systemName: "line.3.horizontal")
        barButtonItem.target = self
        barButtonItem.action = #selector(moreButtonDidTap(_:))
        return barButtonItem
    } ()

    private lazy var profileCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.estimatedItemSize = .zero
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 1, bottom: 0, right: 1)
        return collectionView
    } ()

    var name: String? = nil {
        didSet {
            nicknameLabel.title = name
        }
    }

    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        addViews()
        setAutoLayout()
        setupCollectionView()

        setBinding()
        
        setupData()
        
        profileCollectionView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
    }

    //MARK: - Actions

    @objc
    func moreButtonDidTap(_ sender: UIButton) {
        UserDefaults.standard.set(nil, forKey: "authKey")
        updateLoginStatus()
        let loginViewController = LoginViewController()
        let navVC = UINavigationController(rootViewController: loginViewController)
        navVC.modalPresentationStyle = .fullScreen
        self.present(navVC, animated: true)
    }
    
    @objc
    func didLongPressCell(gestureRecognizer: UILongPressGestureRecognizer) {
        if gestureRecognizer.state != .began { return }
        
        let position = gestureRecognizer.location(in: profileCollectionView)
        
        if let indexPath = profileCollectionView.indexPathForItem(at: position) {
            guard let userPosts = self.userPosts else { return }
            let cellData = userPosts[indexPath.item]
            deletedIndex = indexPath.item
            if let postIDx = cellData._id {
                UserFeedDataManager().deleteUserFeed(self, postIDx)
            }
        }
    }

    @objc func refresh(){
        self.profileCollectionView.reloadData()
    }
    
    //MARK: - Helpers
    private func addViews() {
        self.navigationItem.leftBarButtonItem = nicknameLabel
        self.navigationItem.rightBarButtonItems = [moreButton, postButton]

        view.addSubview(profileCollectionView)
    }

    private func setAutoLayout() {
        profileCollectionView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }

    private func setupCollectionView() {
        profileCollectionView.delegate = self
        profileCollectionView.dataSource = self

        profileCollectionView.register(ProfileCollectionViewCell.self, forCellWithReuseIdentifier: ProfileCollectionViewCell.identifier)
        profileCollectionView.register(PostCollectionViewCell.self, forCellWithReuseIdentifier: PostCollectionViewCell.identifier)
        
        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(didLongPressCell(gestureRecognizer:)))
        gesture.minimumPressDuration = 0.66
        gesture.delegate = self
        gesture.delaysTouchesBegan = true
        profileCollectionView.addGestureRecognizer(gesture)
    }
    
    private func setupData() {
        UserFeedDataManager().getUserFeed(self)
    }
    
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
            if (refreshControl.isRefreshing) {
               
                self.refreshControl.endRefreshing()
                setupData()
            }
    }
}

extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return userPosts?.count ?? 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = indexPath.section
        switch section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileCollectionViewCell.identifier, for: indexPath) as! ProfileCollectionViewCell
            if let cellData = self.userInfo {
                cell.setupInfo(cellData)
            }
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PostCollectionViewCell.identifier, for: indexPath) as! PostCollectionViewCell
            let itemIndex = indexPath.item
            if let cellData = self.userPosts {
                cell.setupFeed(cellData[itemIndex].postImgURL)
            }
            return cell
        }
    }
}

extension ProfileViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let section = indexPath.section
        switch section {
        case 0:
            return CGSize(width: collectionView.frame.width, height: 159)
        default:
            let side = CGFloat((collectionView.frame.width / 3) - (4 / 3))
            return CGSize(width: side, height: side)
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        switch section {
        case 0:
            return CGFloat(0)
        default:
            return CGFloat(1)
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        switch section {
        case 0:
            return CGFloat(0)
        default:
            return CGFloat(1)
        }
    }
}

extension ProfileViewController {
    fileprivate func setBinding() {
    }
    
    func successFeedAPI(_ result: UserFeedModel) {
        self.userPosts = result.result?.userPosts
        self.userInfo = result.result?.userInfo
        name = result.result?.userInfo?.username
    }
    
    func successDeletePostAPI(_ isSuccess: Bool) {
        guard isSuccess else { return }
        
        if let deletedIndex = self.deletedIndex {
            self.userPosts?.remove(at: deletedIndex)
        }
    }
}
