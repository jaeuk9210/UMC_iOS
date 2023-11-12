//
//  StoryCollectionViewCell.swift
//  Codebase
//
//  Created by 정재욱 on 11/12/23.
//

import UIKit

class StoryCollectionViewCell: UICollectionViewCell {
    static let identifier = "StoryCollectionViewCell"
    
    private lazy var imageViewBackgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 24
        view.backgroundColor = .systemGray3
        view.clipsToBounds = true
        return view
    } ()
    
    private lazy var userProfileBackgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 23.5
        view.backgroundColor = .white
        view.clipsToBounds = true
        return view
    } ()
    
    private lazy var userProfileImageVIew: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 22.5
        imageView.clipsToBounds = true
        imageView.image = UIImage(systemName: "person.fill")
        imageView.backgroundColor = .systemGray5
        imageView.tintColor = .white
        return imageView
    } ()
    
    private lazy var userNmaeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Jino"
        label.font = UIFont.systemFont(ofSize: 9, weight: .bold)
        return label
    } ()
    
    func setup() {
        addViews()
        setAutoLayout()
    }
    
    func addViews() {
        contentView.addSubview(imageViewBackgroundView)
        imageViewBackgroundView.addSubview(userProfileBackgroundView)
        userProfileBackgroundView.addSubview(userProfileImageVIew)
        contentView.addSubview(userNmaeLabel)
    }
    
    func setAutoLayout() {
        NSLayoutConstraint.activate([
            imageViewBackgroundView.heightAnchor.constraint(equalToConstant: 48),
            imageViewBackgroundView.widthAnchor.constraint(equalToConstant: 48),
            imageViewBackgroundView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageViewBackgroundView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            userProfileBackgroundView.heightAnchor.constraint(equalToConstant: 47),
            userProfileBackgroundView.widthAnchor.constraint(equalToConstant: 47),
            userProfileBackgroundView.centerYAnchor.constraint(equalTo: imageViewBackgroundView.centerYAnchor),
            userProfileBackgroundView.centerXAnchor.constraint(equalTo: imageViewBackgroundView.centerXAnchor),
            
            userProfileImageVIew.heightAnchor.constraint(equalToConstant: 45),
            userProfileImageVIew.widthAnchor.constraint(equalToConstant: 45),
            userProfileImageVIew.centerYAnchor.constraint(equalTo: userProfileBackgroundView.centerYAnchor),
            userProfileImageVIew.centerXAnchor.constraint(equalTo: userProfileBackgroundView.centerXAnchor),
            
            userNmaeLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            userNmaeLabel.topAnchor.constraint(equalTo: imageViewBackgroundView.bottomAnchor, constant: 2)
        ])
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) hs not been implemented")
    }
}
