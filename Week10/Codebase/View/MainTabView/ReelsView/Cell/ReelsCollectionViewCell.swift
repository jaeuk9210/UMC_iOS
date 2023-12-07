//
//  ReelsCollectionViewCell.swift
//  Codebase
//
//  Created by 정재욱 on 12/7/23.
//

import UIKit
import AVKit

import SnapKit

class ReelsCollectionViewCell: UICollectionViewCell {
    //MARK: - Properties
    static let identifier = "ReelsCollectionViewCell"

    var videoView: VideoPlayerView?

    private lazy var cellTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "릴스"
        label.font = .boldSystemFont(ofSize: 25)
        label.textAlignment = .left
        label.textColor = .white
        return label
    }()

    private lazy var cameraImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "camera")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.tintColor = .white
        return imageView
    }()

    private lazy var commentImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "message")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.tintColor = .white
        return imageView
    }()

    private lazy var likeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "suit.heart")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.tintColor = .white
        return imageView
    }()

    private lazy var shareImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "paperplane")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.tintColor = .white
        return imageView
    }()
    //MARK: - Inits

    override init(frame: CGRect) {
        super.init(frame: frame)

    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Actions

    //MARK: - Helpers
    public func setupURL(_ urlStr: String) {
        self.videoView = VideoPlayerView(frame: .zero, urlStr: urlStr)
        addViews()
        setAutoLayout()
    }

    private func addViews() {
        guard let videoView = videoView else { return }
        contentView.addSubview(videoView)
        [cellTitleLabel, cameraImageView, likeImageView, commentImageView, shareImageView].forEach {
            contentView.addSubview($0)
        }
    }

    private func setAutoLayout() {
        guard let videoView = videoView else { return }
        videoView.snp.makeConstraints {
            $0.edges.equalTo(contentView)
        }

        cellTitleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(20)
        }

        cameraImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.width.height.equalTo(35)
        }

        shareImageView.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-50)
            $0.trailing.equalToSuperview().offset(-20)
            $0.width.height.equalTo(35)
        }

        commentImageView.snp.makeConstraints {
            $0.bottom.equalTo(shareImageView.snp.top).offset(-20)
            $0.centerX.equalTo(shareImageView)
            $0.width.height.equalTo(35)
        }

        likeImageView.snp.makeConstraints {
            $0.bottom.equalTo(commentImageView.snp.top).offset(-20)
            $0.centerX.equalTo(shareImageView)
            $0.width.height.equalTo(35)
        }
    }
}
