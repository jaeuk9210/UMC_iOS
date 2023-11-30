//
//  FeedViewController.swift
//  Codebase
//
//  Created by 정재욱 on 11/12/23.
//

import UIKit

import SnapKit

class FeedViewController: UIViewController {

    //MARK: - Properties
    private lazy var navigationView: UIView = {
        let view = UIView()
        return view
    } ()

    private lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ic_catstagram_logo")
        imageView.contentMode = .scaleAspectFit
        return imageView
    } ()

    private lazy var postButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "ic_home_upload"), for: .normal)
        button.addTarget(self, action: #selector(buttonGoAlbum(_:)), for: .touchUpInside)
        return button
    } ()

    private lazy var notiButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "ic_home_heart"), for: .normal)
        return button
    } ()

    private lazy var directMessageButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "ic_home_send"), for: .normal)
        return button
    } ()

    private lazy var feedTableView: UITableView = {
        let tableView = UITableView(frame: view.bounds, style: .plain)
        return tableView
    } ()

    private var navBarItems: [UIView] {
        [logoImageView, postButton, notiButton, directMessageButton]
    }

    var arrCat: [FeedModel] = []

    let imagePickerViewController = UIImagePickerController()

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

        let input = FeedAPIInput(limit: 20, page: 10)
        FeedDataManager().feedDataManager(input, self)

        imagePickerViewController.delegate = self
    }

    //MARK: - Actions
    @objc func buttonGoAlbum(_ sender: Any) {
        self.imagePickerViewController.sourceType = .photoLibrary
        self.present(imagePickerViewController, animated: true, completion: nil)
    }

    //MARK: - Helpers
    private func addViews() {
        view.addSubview(navigationView)
        navBarItems.forEach {
            navigationView.addSubview($0)
        }
        view.addSubview(feedTableView)
    }

    private func setAutoLayout() {
        navigationView.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }

        logoImageView.snp.makeConstraints {
            $0.width.equalTo(140)
            $0.leading.equalToSuperview().offset(15)
            $0.top.equalToSuperview().offset(5)
            $0.bottom.equalToSuperview().offset(-5)
            $0.centerY.equalToSuperview()
        }

        postButton.snp.makeConstraints {
            $0.height.width.equalTo(25)
            $0.centerY.equalToSuperview()
            $0.trailing.equalTo(notiButton.snp.leading).offset(-15)
        }

        notiButton.snp.makeConstraints {
            $0.height.width.equalTo(27)
            $0.centerY.equalToSuperview()
            $0.trailing.equalTo(directMessageButton.snp.leading).offset(-15)
        }

        directMessageButton.snp.makeConstraints {
            $0.height.width.equalTo(25)
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-15)
        }

        feedTableView.snp.makeConstraints {
            $0.top.equalTo(navigationView.snp.bottom)
            $0.bottom.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

//MARK: - TableView setting

extension FeedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrCat.count + 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: StoryTableViewCell.identifier, for: indexPath) as! StoryTableViewCell
            cell.selectionStyle = .none
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: FeedTableViewCell.identifier, for: indexPath) as! FeedTableViewCell
            cell.selectionStyle = .none
            cell.feedImageView.imageDownload(url: URL(string: arrCat[indexPath.row - 1].url!), contentMode: .scaleAspectFill, key: arrCat[indexPath.row - 1].url)
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

extension FeedViewController {
    func successAPI(_ result: [FeedModel]) {
        arrCat = result
        feedTableView.reloadData()
    }
}

extension FeedViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            print(image)
        }
    }
}
