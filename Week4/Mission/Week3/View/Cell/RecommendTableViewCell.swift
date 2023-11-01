//
//  RecommendTableViewCell.swift
//  Week3
//
//  Created by 정재욱 on 10/11/23.
//

import UIKit

class RecommendTableViewCell: UITableViewCell {
    
    lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.showsHorizontalScrollIndicator = false
        return view
    }()
    
    lazy var RecommendTitle: UILabel = {
        let label = UILabel()
        label.text = "이번주 우리동네 인기 상품"
        label.font                                      = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var moreButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.forward"), for: .normal)
        button.tintColor = .lightGray
        button.heightAnchor.constraint(equalToConstant: 30).isActive    = true
        button.widthAnchor.constraint(equalToConstant: 30).isActive     = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    func setup() {
        addSubview(RecommendTitle)
        addSubview(moreButton)
        addSubview(collectionView)

        
        RecommendTitle.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive            = true
        RecommendTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive    = true
        
        moreButton.centerYAnchor.constraint(equalTo: RecommendTitle.centerYAnchor).isActive       = true
        moreButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive     = true
        
        collectionView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive             = true
        collectionView.topAnchor.constraint(equalTo: RecommendTitle.bottomAnchor).isActive   = true
        collectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16).isActive               = true
        collectionView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive           = true
    }
    
    
    func setCollectionViewDataSourceDelegate(dataSourceDelegate: UICollectionViewDelegate & UICollectionViewDataSource, forRow row: Int) {
        collectionView.delegate = dataSourceDelegate
        collectionView.dataSource = dataSourceDelegate
        collectionView.tag = row
        
        collectionView.register(RecommendCollectionViewCell.self, forCellWithReuseIdentifier: RecommendCollectionViewCell.identifier)
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        flowLayout.minimumLineSpacing = 6
        
        collectionView.collectionViewLayout = flowLayout
        
        collectionView.reloadData()
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
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
