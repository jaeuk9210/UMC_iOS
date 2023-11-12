//
//  ProfileCollectionViewCell.swift
//  Codebase
//
//  Created by 정재욱 on 11/12/23.
//

import UIKit

class ProfileCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Properties
    static let identifier = "ProfileCollectionViewCell"
    
    private lazy var profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .green
        imageView.layer.cornerRadius = 44
        imageView.layer.borderColor = UIColor.darkGray.cgColor
        imageView.layer.borderWidth = 1
        imageView.clipsToBounds = true
        return imageView
    } ()
    
    private lazy var addStoryImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .white
        imageView.image = UIImage(systemName: "plus.circle.fill")
        imageView.layer.cornerRadius = 12
        imageView.clipsToBounds = true
        return imageView
    } ()
    
    private lazy var inviteButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage.icMyInvite, for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 7, left: 9, bottom: 10, right: 8)
        button.layer.cornerRadius = 3
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.borderWidth = 1
        button.clipsToBounds = true
        return button
    } ()
    
    private lazy var profileEditButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("프로필 편집", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        button.layer.cornerRadius = 5
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.borderWidth = 1
        button.clipsToBounds = true
        return button
    } ()
    
    private lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        label.textAlignment = .center
        label.text = "username"
        return label
    } ()
    
    private lazy var postCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0"
        label.textAlignment = .center
        return label
    } ()
    
    private lazy var postLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "게시글"
        label.textAlignment = .center
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    } ()
    
    private lazy var postCountStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.addArrangedSubview(postCountLabel)
        stackView.addArrangedSubview(postLabel)
        stackView.spacing = 4
        return stackView
    } ()
    
    private lazy var followerCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0"
        label.textAlignment = .center
        return label
    } ()
    
    private lazy var followerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "팔로워"
        label.textAlignment = .center
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    } ()
    
    private lazy var followerCountStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.addArrangedSubview(followerCountLabel)
        stackView.addArrangedSubview(followerLabel)
        stackView.spacing = 4
        return stackView
    } ()
    
    private lazy var followingCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0"
        label.textAlignment = .center
        return label
    } ()
    
    private lazy var followingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "팔로잉"
        label.textAlignment = .center
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    } ()
    
    private lazy var followingCountStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.addArrangedSubview(followingCountLabel)
        stackView.addArrangedSubview(followingLabel)
        stackView.spacing = 4
        return stackView
    } ()
    
    private lazy var profileInfoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.addArrangedSubview(postCountStackView)
        stackView.addArrangedSubview(followerCountStackView)
        stackView.addArrangedSubview(followingCountStackView)
        stackView.spacing = 50
        return stackView
    } ()
    
    private var myProfileInfo: [UIView] {
        [profileImage, addStoryImage, inviteButton, profileEditButton, userNameLabel, profileInfoStackView]
    }
    
    //MARK: - Inits
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) hs not been implemented")
    }
    
    //MARK: - Actions
    
    //MARK: - Helpers
    private func setup() {
        addViews()
        setAutoLayout()
        
        [postCountLabel, followerCountLabel, followingCountLabel].forEach{
            $0.text = "\(Int.random(in: 0...10))"
        }
    }
    
    private func addViews() {
        myProfileInfo.forEach{
            contentView.addSubview($0)
        }
    }
    
    private func setAutoLayout() {
        NSLayoutConstraint.activate([
            profileImage.heightAnchor.constraint(equalToConstant: 88),
            profileImage.widthAnchor.constraint(equalToConstant: 88),
            profileImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            profileImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            
            addStoryImage.heightAnchor.constraint(equalToConstant: 24),
            addStoryImage.widthAnchor.constraint(equalToConstant: 24),
            addStoryImage.trailingAnchor.constraint(equalTo: profileImage.trailingAnchor),
            addStoryImage.bottomAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 0.3),
            
            inviteButton.heightAnchor.constraint(equalToConstant: 31),
            inviteButton.widthAnchor.constraint(equalToConstant: 31),
            inviteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            inviteButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            profileEditButton.leadingAnchor.constraint(equalTo: profileImage.leadingAnchor),
            profileEditButton.trailingAnchor.constraint(equalTo: inviteButton.leadingAnchor, constant: -10),
            profileEditButton.heightAnchor.constraint(equalTo: inviteButton.heightAnchor, multiplier: 1),
            profileEditButton.centerYAnchor.constraint(equalTo: inviteButton.centerYAnchor),
            
            userNameLabel.centerXAnchor.constraint(equalTo: profileImage.centerXAnchor),
            userNameLabel.topAnchor.constraint(equalTo: profileImage.bottomAnchor),
            
            profileInfoStackView.trailingAnchor.constraint(equalTo: profileEditButton.trailingAnchor),
            profileInfoStackView.centerYAnchor.constraint(equalTo: profileImage.centerYAnchor)
        ])
    }
}
