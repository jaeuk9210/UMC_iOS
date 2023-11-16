//
//  ProfileCollectionViewCell.swift
//  Codebase
//
//  Created by 정재욱 on 11/12/23.
//

import UIKit

import SnapKit

class ProfileCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Properties
    static let identifier = "ProfileCollectionViewCell"
    
    lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .green
        imageView.layer.cornerRadius = 44
        imageView.layer.borderColor = UIColor.darkGray.cgColor
        imageView.layer.borderWidth = 1
        imageView.clipsToBounds = true
        return imageView
    } ()
    
    private lazy var addStoryImage: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .white
        imageView.image = UIImage(systemName: "plus.circle.fill")
        imageView.layer.cornerRadius = 12
        imageView.clipsToBounds = true
        return imageView
    } ()
    
    private lazy var inviteButton: UIButton = {
        let button = UIButton()
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
        label.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        label.textAlignment = .center
        label.text = "username"
        return label
    } ()
    
    private lazy var postCountLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textAlignment = .center
        return label
    } ()
    
    private lazy var postLabel: UILabel = {
        let label = UILabel()
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
        label.text = "0"
        label.textAlignment = .center
        return label
    } ()
    
    private lazy var followerLabel: UILabel = {
        let label = UILabel()
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
        label.text = "0"
        label.textAlignment = .center
        return label
    } ()
    
    private lazy var followingLabel: UILabel = {
        let label = UILabel()
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
        stackView.axis = .horizontal
        stackView.addArrangedSubview(postCountStackView)
        stackView.addArrangedSubview(followerCountStackView)
        stackView.addArrangedSubview(followingCountStackView)
        stackView.spacing = 50
        return stackView
    } ()
    
    private var myProfileInfo: [UIView] {
        [profileImageView, addStoryImage, inviteButton, profileEditButton, userNameLabel, profileInfoStackView]
    }
    
    var profileImage: URL? = URL(string: "") {
        didSet {
            profileImageView.imageDownload(url: profileImage,contentMode: .scaleAspectFill, key: profileImage?.absoluteString)
        }
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
        profileImageView.snp.makeConstraints {
            $0.height.width.equalTo(88)
            $0.top.leading.equalTo(contentView).offset(10)
        }
        
        addStoryImage.snp.makeConstraints {
            $0.height.width.equalTo(24)
            $0.trailing.equalTo(profileImageView)
            $0.bottom.equalTo(profileImageView.snp.bottom).offset(0.3)
        }
        
        inviteButton.snp.makeConstraints{
            $0.height.width.equalTo(31)
            $0.trailing.bottom.equalTo(contentView).offset(-10)
        }
        
        profileEditButton.snp.makeConstraints{
            $0.leading.equalTo(profileImageView)
            $0.trailing.equalTo(inviteButton.snp.leading).offset(-10)
            $0.height.centerY.equalTo(inviteButton)
        }
        
        userNameLabel.snp.makeConstraints{
            $0.centerX.equalTo(profileImageView)
            $0.top.equalTo(profileImageView.snp.bottom)
        }
        
        profileInfoStackView.snp.makeConstraints{
            $0.trailing.equalTo(profileEditButton)
            $0.centerY.equalTo(profileImageView)
        }
    }
}
