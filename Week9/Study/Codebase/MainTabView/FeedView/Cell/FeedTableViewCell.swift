//
//  FeedTableViewCell.swift
//  Codebase
//
//  Created by 정재욱 on 11/12/23.
//

import UIKit

import SnapKit

class FeedTableViewCell: UITableViewCell {
    //MARK: - Properties
    static let identifier = "FeedTableViewCell"

    private lazy var userProfileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.fill")
        imageView.backgroundColor = .systemGray3
        imageView.layer.cornerRadius = 12.5
        imageView.tintColor = .white
        imageView.clipsToBounds = true
        return imageView
    } ()

    private lazy var userNameLable: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10, weight: .bold)
        label.text = "Uno"
        return label
    } ()

    private lazy var moreButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "ic_home_more"), for: .normal)
        return button
    } ()

    lazy var feedImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        return imageView
    } ()

    private lazy var likeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "ic_home_heart"), for: .normal)
        button.setImage(UIImage(named: "ic_home_heart_full"), for: .selected)
        button.addTarget(self, action: #selector(actionIsHeart(_:)), for: .touchUpInside)
        return button
    } ()

    private lazy var messageButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "ic_home_comment"), for: .normal)
        return button
    } ()

    private lazy var shareButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "ic_home_send"), for: .normal)
        return button
    } ()

    private lazy var bookmarkButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "ic_bookmark_white"), for: .normal)
        button.setImage(UIImage(named: "ic_bookmark_black"), for: .selected)
        button.addTarget(self, action: #selector(actionBookmark(_:)), for: .touchUpInside)
        return button
    } ()

    private lazy var likeCountLable: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        label.text = "좋아요 4개"
        return label
    } ()

    private lazy var feedLable: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 8)
        label.text = "uno test\ntest"
        label.numberOfLines = 2
        return label
    } ()

    private lazy var myProfileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.fill")
        imageView.backgroundColor = .systemGray3
        imageView.layer.cornerRadius = 12.5
        imageView.tintColor = .white
        imageView.clipsToBounds = true
        return imageView
    } ()

    private lazy var commentTextField: UITextField = {
        let textField = UITextField()
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
        userProfileImageView.snp.makeConstraints {
            $0.height.width.equalTo(25)
            $0.leading.top.equalTo(contentView).offset(10)
        }

        userNameLable.snp.makeConstraints {
            $0.centerY.equalTo(userProfileImageView)
            $0.leading.equalTo(userProfileImageView.snp.trailing).offset(10)
        }

        moreButton.snp.makeConstraints {
            $0.height.width.equalTo(17)
            $0.trailing.equalTo(contentView).offset(-10)
            $0.centerY.equalTo(userProfileImageView)
        }

        feedImageView.snp.makeConstraints {
            $0.leading.trailing.equalTo(contentView)
            $0.height.equalTo(feedImageView.snp.width)
            $0.top.equalTo(moreButton.snp.bottom).offset(10)
        }

        likeButton.snp.makeConstraints {
            $0.height.width.equalTo(17)
            $0.top.equalTo(feedImageView.snp.bottom).offset(10)
            $0.leading.equalTo(userProfileImageView)
        }

        messageButton.snp.makeConstraints {
            $0.height.width.equalTo(20)
            $0.centerY.equalTo(likeButton)
            $0.leading.equalTo(likeButton.snp.trailing).offset(13)
        }

        shareButton.snp.makeConstraints {
            $0.height.width.equalTo(17)
            $0.centerY.equalTo(messageButton)
            $0.leading.equalTo(messageButton.snp.trailing).offset(13)
        }

        bookmarkButton.snp.makeConstraints {
            $0.height.width.equalTo(17)
            $0.centerY.equalTo(shareButton)
            $0.trailing.equalTo(contentView).offset(-10)
        }

        likeCountLable.snp.makeConstraints {
            $0.leading.equalTo(likeButton)
            $0.top.equalTo(shareButton.snp.bottom).offset(10)
        }

        feedLable.snp.makeConstraints {
            $0.leading.equalTo(likeCountLable)
            $0.trailing.equalTo(bookmarkButton)
            $0.top.equalTo(likeCountLable.snp.bottom).offset(10)
        }

        myProfileImageView.snp.makeConstraints {
            $0.height.width.equalTo(25)
            $0.leading.equalTo(userProfileImageView)
            $0.top.equalTo(feedLable.snp.bottom).offset(13)
            $0.bottom.equalTo(contentView).offset(-13)
        }

        commentTextField.snp.makeConstraints {
            $0.trailing.equalTo(bookmarkButton)
            $0.leading.equalTo(myProfileImageView.snp.trailing).offset(7)
            $0.centerY.equalTo(myProfileImageView)
            $0.height.equalTo(myProfileImageView).multipliedBy(1.36)
        }
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        feedImageView.image = nil
    }

}
