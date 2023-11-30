//
//  StoryTableViewCell.swift
//  Codebase
//
//  Created by 정재욱 on 11/12/23.
//

import UIKit

import SnapKit

class StoryTableViewCell: UITableViewCell {
    //MARK: - Properties
    static let identifier = "StoryTableViewCell"

    let storyCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        flowLayout.minimumLineSpacing = 12
        let view = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        view.showsHorizontalScrollIndicator = false
        return view
    } ()

    //MARK: - Actions

    //MARK: - Hepers
    func setup() {
        addViews()
        setAutoLayout()
    }

    func addViews() {
        contentView.addSubview(storyCollectionView)
    }

    func setAutoLayout() {
        storyCollectionView.snp.makeConstraints {
            $0.edges.equalTo(contentView)
        }
    }

    func setCollectionViewDataSourceDelegate(dataSourceDelegate: UICollectionViewDelegate & UICollectionViewDataSource, forRow row: Int) {
        storyCollectionView.delegate = dataSourceDelegate
        storyCollectionView.dataSource = dataSourceDelegate
        storyCollectionView.tag = row

        storyCollectionView.register(StoryCollectionViewCell.self, forCellWithReuseIdentifier: StoryCollectionViewCell.identifier)
        storyCollectionView.reloadData()
    }

    //MARK: - Inits

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not  been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
