//
//  StoryCollectionViewCell.swift
//  Codebase
//
//  Created by 정재욱 on 11/12/23.
//

import UIKit

import SnapKit

class StoryCollectionViewCell: UICollectionViewCell {
    static let identifier = "StoryCollectionViewCell"

    private lazy var imageViewBackgroundView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 24
        view.backgroundColor = .systemGray3
        view.clipsToBounds = true
        return view
    } ()

    private lazy var userProfileBackgroundView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 23.5
        view.backgroundColor = .white
        view.clipsToBounds = true
        return view
    } ()

    private lazy var userProfileImageVIew: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 22.5
        imageView.clipsToBounds = true
        imageView.image = UIImage(systemName: "person.fill")
        imageView.backgroundColor = .systemGray5
        imageView.tintColor = .white
        return imageView
    } ()

    private lazy var userNmaeLabel: UILabel = {
        let label = UILabel()
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
        imageViewBackgroundView.snp.makeConstraints {
            $0.height.width.equalTo(48)
            $0.top.centerX.equalTo(contentView)
        }

        userProfileBackgroundView.snp.makeConstraints {
            $0.height.width.equalTo(47)
            $0.center.equalTo(imageViewBackgroundView)
        }

        userProfileImageVIew.snp.makeConstraints {
            $0.height.width.equalTo(45)
            $0.center.equalTo(userProfileBackgroundView)
        }

        userNmaeLabel.snp.makeConstraints {
            $0.centerX.equalTo(contentView)
            $0.top.equalTo(imageViewBackgroundView.snp.bottom).offset(2)
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) hs not been implemented")
    }
}
