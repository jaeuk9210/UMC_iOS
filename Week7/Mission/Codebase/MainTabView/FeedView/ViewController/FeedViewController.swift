//
//  FeedViewController.swift
//  Codebase
//
//  Created by 정재욱 on 11/12/23.
//

import UIKit

class FeedViewController: UIViewController {
    
    //MARK: - Properties
    private lazy var navigationView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    } ()

    private lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "ic_catstagram_logo")
        imageView.contentMode = .scaleAspectFit
        return imageView
    } ()
    
    private lazy var postButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "ic_home_upload"), for: .normal)
        return button
    } ()
    
    private lazy var notiButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "ic_home_heart"), for: .normal)
        return button
    } ()
    
    private lazy var directMessageButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "ic_home_send"), for: .normal)
        return button
    } ()
    
    private lazy var feedTableView: UITableView = {
        let tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    } ()
    
    private var navBarItems: [UIView] {
        [logoImageView, postButton, notiButton, directMessageButton]
    }
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addViews()
        setAutoLayout()
        
        feedTableView.delegate = self
        feedTableView.dataSource = self
        feedTableView.separatorStyle = .none
        
        feedTableView.register(FeedTableViewCell.self, forCellReuseIdentifier: FeedTableViewCell.identifier)
        feedTableView.register(StoryTableViewCell.self, forCellReuseIdentifier: StoryTableViewCell.identifier)
    }
    
    //MARK: - Actions
    
    //MARK: - Helpers
    private func addViews() {
        view.addSubview(navigationView)
        navBarItems.forEach {
            navigationView.addSubview($0)
        }
        view.addSubview(feedTableView)
    }
    
    private func setAutoLayout() {
        NSLayoutConstraint.activate([
            //Navigation bar view autolayout
            navigationView.heightAnchor.constraint(equalToConstant: 50),
            navigationView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navigationView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            navigationView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            //Logo image autolayout
            logoImageView.widthAnchor.constraint(equalToConstant: 140),
            logoImageView.leadingAnchor.constraint(equalTo: logoImageView.superview!.leadingAnchor, constant: 15),
            logoImageView.topAnchor.constraint(equalTo: logoImageView.superview!.topAnchor, constant: 5),
            logoImageView.bottomAnchor.constraint(equalTo: logoImageView.superview!.bottomAnchor, constant: -5),
            logoImageView.centerYAnchor.constraint(equalTo: logoImageView.superview!.centerYAnchor),
            
            //Post button autolayout
            postButton.widthAnchor.constraint(equalToConstant: 25),
            postButton.heightAnchor.constraint(equalToConstant: 25),
            postButton.centerYAnchor.constraint(equalTo: postButton.superview!.centerYAnchor),
            postButton.trailingAnchor.constraint(equalTo: notiButton.leadingAnchor, constant: -15),
            
            //Like button autolayout
            notiButton.widthAnchor.constraint(equalToConstant: 27),
            notiButton.heightAnchor.constraint(equalToConstant: 27),
            notiButton.centerYAnchor.constraint(equalTo: notiButton.superview!.centerYAnchor),
            notiButton.trailingAnchor.constraint(equalTo: directMessageButton.leadingAnchor, constant: -15),
            
            //Direct message button autolayout
            directMessageButton.widthAnchor.constraint(equalToConstant: 25),
            directMessageButton.heightAnchor.constraint(equalToConstant: 25),
            directMessageButton.centerYAnchor.constraint(equalTo: directMessageButton.superview!.centerYAnchor),
            directMessageButton.trailingAnchor.constraint(equalTo: directMessageButton.superview!.trailingAnchor, constant: -15),
            
            //Feed table view autolayout
            feedTableView.topAnchor.constraint(equalTo: navigationView.bottomAnchor),
            feedTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            feedTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            feedTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}

//MARK: - TableView setting

extension FeedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: StoryTableViewCell.identifier, for: indexPath) as! StoryTableViewCell
            cell.selectionStyle = .none
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: FeedTableViewCell.identifier, for: indexPath) as! FeedTableViewCell
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 80
        } else {
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let tableViewCell = cell as? StoryTableViewCell else {
            return
        }
        
        tableViewCell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forRow: indexPath.row)
    }
}

//MARK: - CollectionView Setting

extension FeedViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StoryCollectionViewCell.identifier, for: indexPath) as! StoryCollectionViewCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 50, height: 60)
    }
}
