//
//  ProfileViewController.swift
//  Codebase
//
//  Created by 정재욱 on 11/12/23.
//

import UIKit

class ProfileViewController: UIViewController {

    //MARK: - Properties
    private lazy var nickName: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem()
        barButtonItem.title = "Nickname"
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
        return barButtonItem
    } ()
    
    private lazy var profileCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.estimatedItemSize = .zero
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 1, bottom: 0, right: 1)
        return collectionView
    } ()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addViews()
        setAutoLayout()
        setupCollectionView()
    }
    
    //MARK: - Actions
    
    //MARK: - Helpers
    private func addViews() {
        self.navigationItem.leftBarButtonItem = nickName
        self.navigationItem.rightBarButtonItems = [moreButton, postButton]
        
        view.addSubview(profileCollectionView)
    }
    
    private func setAutoLayout() {
        NSLayoutConstraint.activate([
            profileCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            profileCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            profileCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            profileCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
    
    private func setupCollectionView() {
        profileCollectionView.delegate = self
        profileCollectionView.dataSource = self
        
        profileCollectionView.register(ProfileCollectionViewCell.self, forCellWithReuseIdentifier: ProfileCollectionViewCell.identifier)
        profileCollectionView.register(PostCollectionViewCell.self, forCellWithReuseIdentifier: PostCollectionViewCell.identifier)
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
            return 24
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = indexPath.section
        switch section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileCollectionViewCell.identifier, for: indexPath) as! ProfileCollectionViewCell
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PostCollectionViewCell.identifier, for: indexPath) as! PostCollectionViewCell
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
            let side = CGFloat((collectionView.frame.width / 3) - (4/3))
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
