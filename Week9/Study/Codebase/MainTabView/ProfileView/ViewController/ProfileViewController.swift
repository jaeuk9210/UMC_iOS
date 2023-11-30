//
//  ProfileViewController.swift
//  Codebase
//
//  Created by 정재욱 on 11/12/23.
//

import UIKit
import Combine

import SnapKit
import KakaoSDKUser

class ProfileViewController: UIViewController {

    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    var subscriptions = Set<AnyCancellable>()

    private lazy var kakaoAuthViewModel: KakaoAuthViewModel = {
        KakaoAuthViewModel()
    } ()

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

        kakaoAuthViewModel.getUserInfo()
        setBinding()
    }

    //MARK: - Actions

    @objc
    func moreButtonDidTap(_ sender: UIButton) {
        kakaoAuthViewModel.kakaoLogout()
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
            self.kakaoAuthViewModel.profileImageURL
                .receive(on: DispatchQueue.main)
                .assign(to: \.profileImage, on: cell)
                .store(in: &subscriptions)
            self.kakaoAuthViewModel.username
                .receive(on: DispatchQueue.main)
                .assign(to: \.userName, on: cell)
                .store(in: &subscriptions)
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
        self.kakaoAuthViewModel.userEmail
            .receive(on: DispatchQueue.main)
            .assign(to: \.name, on: self)
            .store(in: &subscriptions)
    }
}
