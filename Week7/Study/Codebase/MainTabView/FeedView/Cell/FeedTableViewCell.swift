//
//  FeedTableViewCell.swift
//  Codebase
//
//  Created by 정재욱 on 11/12/23.
//

import UIKit

class FeedTableViewCell: UITableViewCell {
    //MARK: - Properties
    static let identifier = "FeedTableViewCell"
    
    private lazy var userProfileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "person.fill")
        imageView.backgroundColor = .systemGray3
        imageView.layer.cornerRadius = 12.5
        imageView.tintColor = .white
        imageView.clipsToBounds = true
        return imageView
    } ()
    
    private lazy var userNameLable: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 10, weight: .bold)
        label.text = "Uno"
        return label
    } ()
    
    private lazy var moreButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "ic_home_more"), for: .normal)
        return button
    } ()
    
    private lazy var feedImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    } ()
    
    private lazy var likeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "ic_home_heart"), for: .normal)
        button.setImage(UIImage(named: "ic_home_heart_full"), for: .selected)
        button.addTarget(self, action: #selector(actionIsHeart(_:)), for: .touchUpInside)
        return button
    } ()
    
    private lazy var messageButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "ic_home_comment"), for: .normal)
        return button
    } ()
    
    private lazy var shareButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "ic_home_send"), for: .normal)
        return button
    } ()
    
    private lazy var bookmarkButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "ic_bookmark_white"), for: .normal)
        button.setImage(UIImage(named: "ic_bookmark_black"), for: .selected)
        button.addTarget(self, action: #selector(actionBookmark(_:)), for: .touchUpInside)
        return button
    } ()
    
    private lazy var likeCountLable: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        label.text = "좋아요 4개"
        return label
    } ()
    
    private lazy var feedLable: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 8)
        label.text = "uno test\ntest"
        label.numberOfLines = 2
        return label
    } ()
    
    private lazy var myProfileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "person.fill")
        imageView.backgroundColor = .systemGray3
        imageView.layer.cornerRadius = 12.5
        imageView.tintColor = .white
        imageView.clipsToBounds = true
        return imageView
    } ()
    
    private lazy var commentTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.placeholder = "댓글달기..."
        return textField
    } ()
    
    //MARK: - Actions
    @objc func actionIsHeart(_ sender: Any) {
        if likeButton.isSelected {
            likeButton.isSelected = false
        } else {
            likeButton.isSelected = true
        }
    }
    
    @objc func actionBookmark(_ sender: Any) {
        if bookmarkButton.isSelected {
            bookmarkButton.isSelected = false
        } else {
            bookmarkButton.isSelected = true
        }
    }
    
    //MARK: - Helpers
    private func setup() {
        addViews()
        setAutoLayout()
    }
    
    private func addViews() {
        [userProfileImageView, userNameLable, moreButton, feedImageView, likeButton, messageButton, shareButton, bookmarkButton, likeCountLable, feedLable, myProfileImageView, commentTextField].forEach {
            contentView.addSubview($0)
        }
    }
    
    private func setAutoLayout() {
        NSLayoutConstraint.activate([
            userProfileImageView.heightAnchor.constraint(equalToConstant: 25),
            userProfileImageView.widthAnchor.constraint(equalToConstant: 25),
            userProfileImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            userProfileImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            
            userNameLable.centerYAnchor.constraint(equalTo: userProfileImageView.centerYAnchor),
            userNameLable.leadingAnchor.constraint(equalTo: userProfileImageView.trailingAnchor, constant: 10),
            
            moreButton.heightAnchor.constraint(equalToConstant: 17),
            moreButton.widthAnchor.constraint(equalToConstant: 17),
            moreButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            moreButton.centerYAnchor.constraint(equalTo: userProfileImageView.centerYAnchor),
            
            feedImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            feedImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            feedImageView.heightAnchor.constraint(equalTo: feedImageView.widthAnchor),
            feedImageView.topAnchor.constraint(equalTo: moreButton.bottomAnchor, constant: 10),
            
            likeButton.heightAnchor.constraint(equalToConstant: 17),
            likeButton.widthAnchor.constraint(equalToConstant: 17),
            likeButton.topAnchor.constraint(equalTo: feedImageView.bottomAnchor, constant: 10),
            likeButton.leadingAnchor.constraint(equalTo: userProfileImageView.leadingAnchor),
            
            messageButton.heightAnchor.constraint(equalToConstant: 20),
            messageButton.widthAnchor.constraint(equalToConstant: 20),
            messageButton.centerYAnchor.constraint(equalTo: likeButton.centerYAnchor),
            messageButton.leadingAnchor.constraint(equalTo: likeButton.trailingAnchor, constant: 13),
            
            shareButton.heightAnchor.constraint(equalToConstant: 17),
            shareButton.widthAnchor.constraint(equalToConstant: 17),
            shareButton.centerYAnchor.constraint(equalTo: messageButton.centerYAnchor),
            shareButton.leadingAnchor.constraint(equalTo: messageButton.trailingAnchor, constant: 13),
            
            bookmarkButton.heightAnchor.constraint(equalToConstant: 17),
            bookmarkButton.widthAnchor.constraint(equalToConstant: 17),
            bookmarkButton.centerYAnchor.constraint(equalTo: shareButton.centerYAnchor),
            bookmarkButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            
            likeCountLable.leadingAnchor.constraint(equalTo: likeButton.leadingAnchor),
            likeCountLable.topAnchor.constraint(equalTo: shareButton.bottomAnchor, constant: 10),
            
            feedLable.leadingAnchor.constraint(equalTo: likeCountLable.leadingAnchor),
            feedLable.trailingAnchor.constraint(equalTo: bookmarkButton.trailingAnchor),
            feedLable.topAnchor.constraint(equalTo: likeCountLable.bottomAnchor, constant: 10),
            
            myProfileImageView.heightAnchor.constraint(equalToConstant: 25),
            myProfileImageView.widthAnchor.constraint(equalToConstant: 25),
            myProfileImageView.leadingAnchor.constraint(equalTo: userProfileImageView.leadingAnchor),
            myProfileImageView.topAnchor.constraint(equalTo: feedLable.bottomAnchor, constant: 13),
            myProfileImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -13),
            
            commentTextField.trailingAnchor.constraint(equalTo: bookmarkButton.trailingAnchor),
            commentTextField.leadingAnchor.constraint(equalTo: myProfileImageView.trailingAnchor, constant: 7),
            commentTextField.centerYAnchor.constraint(equalTo: myProfileImageView.centerYAnchor),
            commentTextField.heightAnchor.constraint(equalTo: myProfileImageView.heightAnchor, multiplier: 1.36)
        ])
    }
    
    //MARK: - Inits
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
