//
//  RecommendCollectionViewCell.swift
//  Week3
//
//  Created by 정재욱 on 10/13/23.
//

import UIKit

class RecommendCollectionViewCell: UICollectionViewCell {
    static let identifier = "RecommendCollectionViewCell"
    
    lazy var collectionCell: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius                        = 6
        imageView.clipsToBounds                             = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.heightAnchor.constraint(equalToConstant: 108).isActive                            = true
        imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 1.0).isActive = true
        imageView.backgroundColor = .lightGray
        return imageView
    } ()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text                                      = "글 제목"
        label.textAlignment                             = .left
        label.font                                      = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor                                 = .black
        label.numberOfLines                             = 2
        label.widthAnchor.constraint(equalToConstant: 108).isActive = true
        label.lineBreakMode                             = .byTruncatingTail
        return label
    } ()
    
    lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.text                                      = "0원"
        label.textAlignment                             = .left
        label.font                                      = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor                                 = .black
        return label
    } ()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not  been implemented")
    }
    
    private func setUI() {
        addSubview(collectionCell)
        collectionCell.addSubview(postImageView)
        collectionCell.addSubview(titleLabel)
        collectionCell.addSubview(priceLabel)
    }
    
    private func setConstraint() {
        NSLayoutConstraint.activate([
            collectionCell.topAnchor.constraint(equalTo: topAnchor),
            collectionCell.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionCell.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionCell.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            postImageView.topAnchor.constraint(equalTo: collectionCell.topAnchor),
            postImageView.leadingAnchor.constraint(equalTo: collectionCell.leadingAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: 6),
            titleLabel.leadingAnchor.constraint(equalTo: collectionCell.leadingAnchor),

            priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 6),
            priceLabel.leadingAnchor.constraint(equalTo: collectionCell.leadingAnchor),
        ])
    }
}
